//
//  AssignVehicalVC.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 27/07/22.
//

import UIKit
import Cosmos

class AssignVehicalVC: BaseViewController {
    
    //MARK: - Propertise
    @IBOutlet weak var lblTruck: UILabel!
    @IBOutlet weak var btnTruck: UIButton!
    @IBOutlet weak var lblTractor: UILabel!
    @IBOutlet weak var btnTractor: UIButton!
    @IBOutlet weak var lblDriverName: themeLabel!
    @IBOutlet weak var btnAssign: themeButton!
    @IBOutlet weak var viewRating: CosmosView!
    
    var VehicleData : AvailableVehicle?
    var SelectedTextField : UITextField?
    var assignVehicleViewModel = AssignVehicleViewModel()
    let GeneralPicker = GeneralPickerView()
    var driverId = ""
    var driverName = ""
    var rating = 0.0
    var selectedTruck = ""
    var selectedTractor = ""
    
    //MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpdata()
    }
    
    //MARK: - Custom Method
    func setUpUI(){
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "assign_vehicle".localized, leftImage: NavItemsLeft.back.value, rightImages: [], isTranslucent: true, ShowShadow: true)
        setLocalization()
    }
    
    func setUpdata(){
        self.getVehicleList()
        //        self.btnTruck.delegate = self
        //        self.btnTractor.delegate = self
        setData()
    }
    
    func setData(){
        self.lblDriverName.text = driverName
        self.viewRating.settings.fillMode = .precise
        self.viewRating.rating = rating
    }
    
    func setLocalization(){
        lblTractor.text = "Tractor".localized
        lblTruck.text = "Truck".localized
        btnTractor.setTitle("select_tractor".localized, for: .normal)
        btnTractor.setTitleColor(.lightGray, for: .normal)
        btnTruck.setTitle("select_truck".localized, for: .normal)
        btnTruck.setTitleColor(.lightGray, for: .normal)
        btnAssign.setTitle("Assign".localized, for: .normal)
    }
    
    func validation() -> (Bool,String){
        if selectedTractor == ""{
            return (false,"select_tractor".localized)
        }else if selectedTruck == ""{
            return (false,"select_truck".localized)
        }else{
            return (true,"Successful")
        }
    }
    
    //MARK: - IBAction Method
    @IBAction func btnAssignVehicleClick(_ sender: Any) {
        let validation = validation()
        if validation.0{
            self.assignVehicle()
        }else{
            Utilities.ShowAlertOfInfo(OfMessage: validation.1)
        }
        
    }
    @IBAction func btnSelectTractorClick(_ sender: Any) {
        if self.VehicleData?.tractors?.count ?? 0 > 0{
            let controller = AppStoryboard.Popup.instance.instantiateViewController(withIdentifier: SelectPopUpVC.storyboardID) as! SelectPopUpVC
            controller.pageTitle = "select_tractor".localized
            controller.tabTypeSelection = .Vehicles
            controller.arrTractor = VehicleData?.tractors ?? []
            controller.modalPresentationStyle = .overCurrentContext
            controller.modalTransitionStyle = .crossDissolve
            controller.clickEdit = { (tractor) in
                let tractor = tractor as? TractorList
                self.selectedTractor = "\(tractor?.id ?? 0)"
                self.btnTractor.setTitle(tractor?.registrationNo, for: .normal)
                self.btnTractor.setTitleColor(.black, for: .normal)
            }
            self.present(controller, animated: true, completion: nil)
        }else{
            Utilities.ShowAlertOfValidation(OfMessage: "noTractor".localized)
        }
    }
    
    @IBAction func btnSelectTruckClick(_ sender: Any) {
        if self.VehicleData?.trucks?.count ?? 0 > 0{
                        let controller = AppStoryboard.Popup.instance.instantiateViewController(withIdentifier: SelectPopUpVC.storyboardID) as! SelectPopUpVC
                        controller.pageTitle = "select_truck".localized
                        controller.tabTypeSelection = .Truck
                        controller.arrTruck = VehicleData?.trucks ?? []
                            controller.modalPresentationStyle = .overCurrentContext
                            controller.modalTransitionStyle = .crossDissolve
                            controller.clickEdit = { (truck) in
                                let truck = truck as? TruckList
                                self.selectedTruck = "\(truck?.truckId ?? 0)"
                                self.btnTruck.setTitle(truck?.registrationNo, for: .normal)
                                self.btnTruck.setTitleColor(.black, for: .normal)
                            }
                            self.present(controller, animated: true, completion: nil)
                    }else{
                        Utilities.ShowAlertOfValidation(OfMessage: "noTruck".localized)
                    }
    }
}

//MARK: - WebService Methode
extension AssignVehicalVC {
    func getVehicleList(){
        self.assignVehicleViewModel.VC = self
        self.assignVehicleViewModel.callWebServiceForVehicleList()
    }
    
    func assignVehicle(){
        let reqModel = AssignVehicleReqModel()
        reqModel.driverId = self.driverId
        reqModel.truckId = self.selectedTruck
        reqModel.tractorId = self.selectedTractor
        self.assignVehicleViewModel.VC = self
        self.assignVehicleViewModel.callWebServiceToAssignVehicle(reqModel: reqModel)
    }
}
