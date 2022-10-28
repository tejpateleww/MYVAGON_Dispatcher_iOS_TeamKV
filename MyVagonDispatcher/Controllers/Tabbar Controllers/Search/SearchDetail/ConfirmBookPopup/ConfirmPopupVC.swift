//
//  CommonAcceptRejectPopupVC.swift
//  MyVagon
//
//  Created by Apple on 16/08/21.
//

import UIKit

class ConfirmPopupVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var TitleImage: UIImageView!
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var LblDescripiton: UILabel!
    @IBOutlet weak var BtnLeft: themeButton!
    @IBOutlet weak var BtnRight: themeButton!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var btnRemoveDriver: ThemeButtonVerify!
    @IBOutlet weak var cancleHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var viewSelectDriver: UIView!
    
    var loadDetailsModel : LoadDetailViewModel?
    var loadDetailsVc : SearchDetailVC?
    var bookingID = ""
    var availabilityId = ""
    var selectedDriverId = ""
    var isForBook = false
    var TitleAttributedText : NSAttributedString?
    var DescriptionAttributedText : NSAttributedString?
    var LeftbtnTitle : String?
    var RightBtnTitle : String?
    var IsHideImage : Bool = true
    var ShownImage : UIImage?
    var LeftbtnClosour : (()->())?
    var RightbtnClosour : (()->())?
    var closeClosour : (()->())?
    var showDriverSelection = false
    
    // MARK: - Life-cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        SetValue()
        setLocalization()
    }
    
    override func viewWillLayoutSubviews() {
        MainView.roundCorners(corners: [.topLeft,.topRight], radius: 30)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let click = self.closeClosour{
            click()
        }
    }
    
    //MARK: - Custom Methods
    func SetValue() {
        TitleImage.superview?.isHidden = (IsHideImage == true) ? true : false
        TitleImage.image = ShownImage ?? UIImage()
        LblTitle.attributedText = TitleAttributedText
        LblDescripiton.attributedText = DescriptionAttributedText
        BtnLeft.isHidden = (LeftbtnTitle == "") ? true : false
        BtnRight.isHidden = (RightBtnTitle == "") ? true : false
        UIView.performWithoutAnimation {
            BtnLeft.setTitle(LeftbtnTitle, for: .normal)
            BtnRight.setTitle(RightBtnTitle, for: .normal)
            self.BtnLeft.layoutIfNeeded()
            self.BtnRight.layoutIfNeeded()
        }
    }
    
    func setLocalization() {
        self.btnSelect.setTitle("empty_driver_massage".localized, for: .normal)
    }
    
    func setUpUI(){
        viewSelectDriver.layer.cornerRadius = 13
        viewSelectDriver.layer.borderWidth = 0.5
        viewSelectDriver.layer.borderColor = #colorLiteral(red: 0.611544311, green: 0.2912456691, blue: 0.8909440637, alpha: 1).cgColor
        btnSelect.setTitleColor(#colorLiteral(red: 0.611544311, green: 0.2912456691, blue: 0.8909440637, alpha: 1), for: .normal)
        if showDriverSelection{
            self.viewSelectDriver.isHidden = false
        }else{
            self.viewSelectDriver.isHidden = true
        }
    }
    
    // MARK: - IBAction Methods
    @IBAction func btnCancle(_ sender: themeButton) {
        if let click = self.LeftbtnClosour{
            click()
        }
    }
    
    @IBAction func btnBookNow(_ sender: themeButton) {
        if isForBook{
            self.CallBookNow()
        } else {
            if let click = self.RightbtnClosour{
                click()
            }
        }
    }
    
    @IBAction func btnSelectClick(_ sender: Any) {
        SingletonClass.sharedInstance.getAvailableDriverList(bookingId: bookingID) { data in
            let controller = AppStoryboard.Popup.instance.instantiateViewController(withIdentifier: SelectPopUpVC.storyboardID) as! SelectPopUpVC
            controller.tabTypeSelection = .Drivers
            controller.pageTitle = "empty_driver_massage".localized
            let filterData = data?.filter({$0.driverVehicle?.isAssing == 1 && $0.blockStatus != "0"})
            if (filterData?.count ?? 0) > 0{
                controller.arrDriver = filterData ?? [DispaterDriver]()
                controller.modalPresentationStyle = .overCurrentContext
                controller.modalTransitionStyle = .crossDissolve
                controller.clickEdit = { (driver) in
                    let driver = driver as? DispaterDriver
                    self.btnSelect.setTitle(driver?.name, for: .normal)
                    self.selectedDriverId = "\(driver?.id ?? 0)"
                    self.cancleHeightConstant.constant = 20
                }
                self.present(controller, animated: true, completion: nil)
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: "no_driver_found_msg".localized)
            }
        }
    }
    
    @IBAction func btnRemoveDriverClick(_ sender: Any) {
        self.btnSelect.setTitle("empty_driver_massage".localized, for: .normal)
        self.cancleHeightConstant.constant = 0
        self.selectedDriverId = ""
    }
}

// MARK: - Webservice Methods
extension ConfirmPopupVC{
    func CallBookNow() {
        self.loadDetailsModel?.loadDetailsVC = loadDetailsVc
        self.loadDetailsModel?.commonAcceptRejectPopupVC = self
        let reqModel = BookNowReqModel()
        reqModel.driver_id = self.selectedDriverId
        reqModel.booking_id = bookingID
        reqModel.availability_id = self.availabilityId
        self.loadDetailsModel?.BookNow(ReqModel: reqModel)
    }
}
