//
//  BidNowPopupViewController.swift
//  MyVagonDispatcher
//
//  Created by Apple on 30/09/21.
//

import UIKit

class ConfirmBidPopupVC: UIViewController {
  
    //MARK: - Propertise
    @IBOutlet weak var MainView: ViewCustomClass!
    @IBOutlet weak var LblTitle: themeLabel!
    @IBOutlet weak var LblDescripiton: themeLabel!
    @IBOutlet weak var BtnLeft: themeButton!
    @IBOutlet weak var BtnRight: themeButton!
    @IBOutlet weak var bidTextField: themeTextfield!
    @IBOutlet weak var btnSelectDriver: UIButton!
    @IBOutlet weak var viewSelectDriver: UIView!
    @IBOutlet weak var cancleHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var btnRemoveDriver: ThemeButtonVerify!
    
    var bidNowViewModel = BidNowViewModel()
    var MinimumBidAmount = ""
    var BookingId = ""
    var AvailabilityId = ""
    var selectedDriverId = ""
    var LeftbtnTitle : String?
    var RightBtnTitle : String?
    var IsHideImage : Bool = true
    var ShownImage : UIImage?
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        SetValue()
        setUI()
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setLocalization()
    }
    
    // MARK: - Custom methods
    @objc func changeLanguage(){
        self.setLocalization()
    }
    
    func setLocalization(){
        self.LblDescripiton.text = "Bidding starting price".localized
        self.bidTextField.placeholder = "Enter your bid".localized
        self.btnSelectDriver.setTitle("empty_driver_massage".localized, for: .normal)
    }
    
    func setUI(){
        self.btnRemoveDriver.setImage(UIImage(named: "cross"), for: .selected)
        self.btnRemoveDriver.layer.cornerRadius = btnRemoveDriver.frame.height / 2
        bidTextField.layer.cornerRadius = 13
        bidTextField.layer.borderColor = UIColor(hexString: "#9B51E0").cgColor
        viewSelectDriver.layer.cornerRadius = 13
        viewSelectDriver.layer.borderWidth = 0.5
        viewSelectDriver.layer.borderColor = #colorLiteral(red: 0.611544311, green: 0.2912456691, blue: 0.8909440637, alpha: 1).cgColor
        btnSelectDriver.setTitleColor(#colorLiteral(red: 0.611544311, green: 0.2912456691, blue: 0.8909440637, alpha: 1), for: .normal)
        if AvailabilityId != "0"{
            self.viewSelectDriver.isHidden = true
        }else{
            self.viewSelectDriver.isHidden = false
        }
    }
    
    func SetValue(){
        LblTitle.text = Currency + MinimumBidAmount
        UIView.performWithoutAnimation {
            BtnLeft.setTitle("Cancel".localized, for: .normal)
            BtnRight.setTitle("Bid".localized, for: .normal)
            self.BtnLeft.layoutIfNeeded()
            self.BtnRight.layoutIfNeeded()
        }
    }
   
    // MARK: - IBAction methods
    @IBAction func btnCancle(_ sender: themeButton) {
        self.view.backgroundColor = .clear
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRemoveDriverClick(_ sender: Any) {
        self.btnSelectDriver.setTitle("empty_driver_massage".localized, for: .normal)
        self.selectedDriverId = ""
        self.cancleHeightConstant.constant = 0
    }
    
    @IBAction func btnBidPost(_ sender: themeButton) {
        if bidTextField.text != ""{
            BidPost()
        }else{
            Utilities.ShowAlertOfInfo(OfMessage: "Please enter bid".localized)
        }
    }
    
    @IBAction func btnSelectClick(_ sender: Any) {
        
        SingletonClass.sharedInstance.getAvailableDriverList(bookingId: BookingId) { data in
            let controller = AppStoryboard.Popup.instance.instantiateViewController(withIdentifier: SelectPopUpVC.storyboardID) as! SelectPopUpVC
            controller.pageTitle = "empty_driver_massage".localized
            controller.tabTypeSelection = .Drivers
            let filterData = data?.filter({$0.driverVehicle?.isAssing == 1 && $0.blockStatus != "0"})
            if (filterData?.count ?? 0) > 0{
                controller.arrDriver = filterData ?? [DispaterDriver]()
                controller.modalPresentationStyle = .overCurrentContext
                controller.modalTransitionStyle = .crossDissolve
                controller.clickEdit = { (driver) in
                    let driver = driver as? DispaterDriver
                    self.btnSelectDriver.setTitle(driver?.name, for: .normal)
                    self.selectedDriverId = "\(driver?.id ?? 0)"
                    self.cancleHeightConstant.constant = 20
                }
                self.present(controller, animated: true, completion: nil)
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: "no_driver_found_msg".localized)
            }
        }
    }
}

// MARK: - Webservice methods
extension ConfirmBidPopupVC{
    func BidPost(){
        self.bidNowViewModel.bidNowPopupViewController = self
        let reqModel = BidReqModel()
        reqModel.booking_id = BookingId
        reqModel.amount = (bidTextField.text ?? "")
        reqModel.driver_id = selectedDriverId
        reqModel.dispatcherId = "\(SingletonClass.sharedInstance.DispatcherProfileData?.id ?? 0)"
        reqModel.availability_id = AvailabilityId
        self.bidNowViewModel.WebServiceBidPost(ReqModel: reqModel)
    }
}

