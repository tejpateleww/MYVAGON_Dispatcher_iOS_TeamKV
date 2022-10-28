//
//  DriverPermissionVC.swift
//  MyVagonDispatcher
//
//  Created by Harsh Dave on 27/01/22.
//

import UIKit

class DriverPermissionVC: BaseViewController {

    //MARK: - Propertise
    @IBOutlet weak var tblDriverPermission: UITableView!
    @IBOutlet weak var btnRemoveVehicle: themeButton!
    @IBOutlet weak var btnAssignVehicle: themeButton!
    var arrPermission : PermissionData?
    var viewModel = DriverPermissionViewModel()
    var removeVehicleViewModel = RemoveVehicleViewModel()
    var driverId = ""
    var driverName = ""
    var driverVehicle : DriverVehicle?
    var isAssign = 0
    var rating = 0.0
    
    //MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setLocalization()
    }
    
    //MARK: - Custom method
    func setLocalization(){
        self.btnRemoveVehicle.setTitle("remove_vehicle".localized, for: .normal)
        self.btnAssignVehicle.setTitle("assign_vehicle".localized, for: .normal)
    }
    //MARK: - Custom method
    func setUpUI(){
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "driver_permission".localized, leftImage: NavItemsLeft.back.value, rightImages:[], isTranslucent: true, ShowShadow: true)
        self.getPermission()
        btnRemoveVehicle.isHidden = (driverVehicle?.isAssing == 0) ? true : false
    }
    
    //MARK: - IBAction Method
    @IBAction func btnAssignVehicle(_ sender: Any) {
        let addDriverVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: AssignVehicalVC.storyboardID) as! AssignVehicalVC
        addDriverVC.driverId = driverId
        addDriverVC.driverName = driverName
        addDriverVC.rating = rating
        self.navigationController?.pushViewController(addDriverVC, animated: true)
    }
    
    @IBAction func btnRemoveVehicle(_ sender: Any) {
        Utilities.showAlertWithTitleFromVC(vc: self, title: AppName, message: "Are you sure want to Remove Vehicle?".localized, buttons: ["Cancel".localized, "OK".localized]) { index in
            if index == 1 {
                let reqModel = RemoveVehicleReqModel()
                reqModel.driver_id = self.driverId
                reqModel.dispatcherVehicleId = "\(self.driverVehicle?.dispatcherVehicleId ?? Int())"
                self.removeVehicleViewModel.vc = self
                self.removeVehicleViewModel.removeVehicle(reqModel: reqModel)
            }
        }
    }
}

//MARK: === TableView DataSource and Delegte  ======
extension DriverPermissionVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPermission?.permissions?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PermissionTblCell", for: indexPath) as! PermissionTblCell
        cell.lblTitle.text = arrPermission?.permissions?[indexPath.row].name
        cell.btnSwitch.isOn = self.arrPermission?.permissions?[indexPath.row].value ?? 0 == 0 ? false : true
        cell.getSelectedStatus = {
            let value = self.arrPermission?.permissions?[indexPath.row].value ?? 0 == 0 ? 1 : 0
            self.updatePermission(key: self.arrPermission?.permissions?[indexPath.row].key ?? "", val: value)
        }
        return cell
    }
}

//MARK: - WebService Methode
extension DriverPermissionVC{
    func getPermission(){
        let reqModel = DriverPermissionReqModel()
        reqModel.driverId = driverId
        self.viewModel.VC = self
        self.viewModel.callWebServiceToGetPermmision(reqModel: reqModel)
    }
    
    func updatePermission(key:String,val:Int){
        let reqModel = UpdatePermissionReqModel()
        reqModel.driverId = driverId
        reqModel.permissionKey = key
        reqModel.permissionValue = "\(val)"
        self.viewModel.callWebServiceToUpdatePermmision(reqModel: reqModel)
    }
}

// MARK: - Setting TblCell
class PermissionTblCell : UITableViewCell {
    
    //MARK:- ===== Outlets =======
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSwitch: ThemeSwitch!
    
    var getSelectedStatus : (()->())?
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnActionSwitch(_ sender: UISwitch) {
        if let selected = getSelectedStatus {
            selected()
        }
    }
}
