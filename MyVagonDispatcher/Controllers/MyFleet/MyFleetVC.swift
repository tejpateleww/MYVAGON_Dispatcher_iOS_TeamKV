//
//  MyFleetVC.swift
//  MyVagonDispatcher
//
//  Created by Harsh Dave on 25/01/22.
//

import UIKit
import FirebaseCoreInternal


enum SelectionBtn: Int {
    case Drivers
    case Vehicles
    case Truck
}

enum status : String{
    case Available = "Available"
    case loaded = "Loaded"
    case NotAssigned = "Not Assigned"
    func colourOfStatus(AvailableStatus:status) -> UIColor {
        switch AvailableStatus {
        case .Available:
            return UIColor(hexString: ThemeColor.themeGreen.rawValue)
        case .loaded:
            return UIColor(hexString: "#DBA539")
        case .NotAssigned:
            return UIColor(hexString: ThemeColor.themeRed.rawValue)
        }
    }
}

class DriversModel {
    var status : status!
    init(Status : status) {
        self.status = Status
    }
}

class MyFleetVC: BaseViewController {
    
    //MARK: - Propertise
    @IBOutlet weak var viewTabView: UIView!
    @IBOutlet weak var tblFleet: UITableView!
    @IBOutlet weak var leadingConstraintView: NSLayoutConstraint!
    @IBOutlet weak var btnDriver: UIButton!
    @IBOutlet weak var btnVehicle: UIButton!
    @IBOutlet weak var btnAddVehicle: themeButton!
    @IBOutlet weak var btnAddTruck: UIButton!
    
    var isLoading = true {
        didSet {
            self.tblFleet.isUserInteractionEnabled = !isLoading
            self.tblFleet.reloadData()
        }
    }
    var arrDriver = [DispaterDriver]()
    var arrTruck = [TruckList]()
    var arrTractor = [TractorList]()
    var myFleetViewModel = MyFleetViewModel()
    let refreshControl = UIRefreshControl()
    var tabTypeSelection = SelectionBtn(rawValue: 0)
    {
        didSet
        {
            switch tabTypeSelection {
            case .Drivers:
                btnAddVehicle.setTitle("+ \("add_driver".localized)", for: .normal)
            case .Vehicles:
                btnAddVehicle.setTitle("+ \("add_tractor".localized)", for: .normal)
            case .Truck:
                btnAddVehicle.setTitle("+ \("add_truck".localized)", for: .normal)
            default:break
            }
            self.tblFleet.reloadData()
        }
    }
    
    //MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: Notification.Name(rawValue: "refreshmyfleet"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "refreshmyfleet"), object: nil)
    }
    
    //MARK: - Custom method
    @objc func changeLanguage(){
        self.reloadData()
    }
    
    func btnSelectionSetup(){
        btnDriver.isSelected = false
        btnDriver.setTitleColor(UIColor.lightGray, for: .normal)
        btnDriver.titleLabel?.font = CustomFont.PoppinsSemiBold.returnFont(16.0)
        btnVehicle.isSelected = false
        btnVehicle.setTitleColor(UIColor.lightGray, for: .normal)
        btnVehicle.titleLabel?.font = CustomFont.PoppinsSemiBold.returnFont(16.0)
        btnAddTruck.isSelected = false
        btnAddTruck.setTitleColor(UIColor.lightGray, for: .normal)
        btnAddTruck.titleLabel?.font = CustomFont.PoppinsSemiBold.returnFont(16.0)
        var btnSelected : UIButton?
        var flagRefresh = false
        switch tabTypeSelection {
        case .Drivers:
            btnSelected = btnDriver
            if arrDriver.count <= 0{
                flagRefresh = true
            }
        case .Vehicles:
            btnSelected = btnVehicle
            if arrTractor.count <= 0{
                flagRefresh = true
            }
        case .Truck:
            btnSelected = btnAddTruck
            if arrTruck.count <= 0{
                flagRefresh = true
            }
        default:break
        }
        if flagRefresh{
            refreshData()
        }else{
            isLoading = false
        }
        btnSelected?.isSelected = true
        btnSelected?.setTitleColor(UIColor(hexString: "#1F1F3F"), for: .normal)
        btnSelected?.titleLabel?.font = CustomFont.PoppinsSemiBold.returnFont(16.0)
        self.tblFleet.scrollToTop()
        self.leadingConstraintView.constant = btnSelected?.superview?.frame.origin.x ?? 0.0
        UIView.animate(withDuration: 0.3) {
            self.viewTabView.layoutIfNeeded()
        }
    }
    
    func setUpUI(){
        self.setUpTable()
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "My Fleet", leftImage: "", rightImages:[], isTranslucent: true, ShowShadow: true,isHomeTitle: true)
        tabTypeSelection = .Drivers
        btnSelectionSetup()
        self.addRefreshControl()
        self.setUpLocalisation()
        self.btnAddTruck.titleLabel?.numberOfLines = 0
    }
    
    func setUpLocalisation(){
        btnAddTruck.setTitle("Truck".localized, for: .normal)
        btnDriver.setTitle("drivers".localized, for: .normal)
        btnVehicle.setTitle("Tractor".localized, for: .normal)
    }
    
    func setUpTable(){
        tblFleet.register(UINib(nibName: "VehiclesTableViewCell", bundle: nil), forCellReuseIdentifier: "VehiclesTableViewCell")
        tblFleet.register(UINib(nibName: "DriversTableViewCell", bundle: nil), forCellReuseIdentifier: "DriversTableViewCell")
        let nib = UINib(nibName: RegisterTruckCell.className, bundle: nil)
        self.tblFleet.register(nib, forCellReuseIdentifier: RegisterTruckCell.className)
        let earningShimmerCellNib = UINib(nibName: EarningShimmerCell.className, bundle: nil)
        self.tblFleet.register(earningShimmerCellNib, forCellReuseIdentifier: EarningShimmerCell.className)
        let noDataTableViewCellNib = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblFleet.register(noDataTableViewCellNib, forCellReuseIdentifier: NoDataTableViewCell.className)
        tblFleet.separatorStyle = .none
    }
    
    func addRefreshControl(){
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.tintColor = #colorLiteral(red: 0.6078431373, green: 0.3176470588, blue: 0.8784313725, alpha: 1)
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.tblFleet.addSubview(self.refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.reloadData()
    }
    
    func reloadData(){
        switch tabTypeSelection {
        case .Drivers:
            arrDriver.removeAll()
            isLoading = true
            self.getDriverList()
        case .Vehicles:
            arrTractor.removeAll()
            isLoading = true
            self.getTractorList()
        case .Truck:
            arrTruck.removeAll()
            isLoading = true
            self.getTruckList()
        case .none:
            break
        }
    }
    
    //MARK: - IBAction Method
    @IBAction func btnActionDriver(_ sender: UIButton) {
        self.tabTypeSelection = .Drivers
        btnSelectionSetup()
    }
    
    @IBAction func btnActionTractor(_ sender: UIButton) {
        self.tabTypeSelection = .Vehicles
        btnSelectionSetup()
    }
    
    @IBAction func btnActionTruck(_ sender: UIButton) {
        self.tabTypeSelection = .Truck
        btnSelectionSetup()
    }
    
    @IBAction func btnActionAddVehicle(_ sender: UIButton) {
        switch tabTypeSelection {
        case .Drivers:
            let addDriverVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: AddDriverVC.storyboardID) as! AddDriverVC
            addDriverVC.hidesBottomBarWhenPushed = true
            addDriverVC.delegate = self
            self.navigationController?.pushViewController(addDriverVC, animated: true)
        case .Vehicles:
            let addTractor = AppStoryboard.Auth.instance.instantiateViewController(withIdentifier: TractorDetailVC.storyboardID) as! TractorDetailVC
            addTractor.delegate = self
            addTractor.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(addTractor, animated: true)
        case .Truck:
            let addTruck = AppStoryboard.Auth.instance.instantiateViewController(withIdentifier: AddTruckVC.storyboardID) as! AddTruckVC
            addTruck.delegate = self
            addTruck.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(addTruck, animated: true)
        default:
            break
        }
    }
}

extension MyFleetVC: Refresh{
    func refreshData() {
        self.reloadData()
    }
}

//MARK: - Table view datasource and delegate method
extension MyFleetVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading{
            return 10
        }else{
            switch tabTypeSelection {
            case .Drivers:
                return (arrDriver.count == 0) ? 1 : arrDriver.count
            case .Vehicles:
                return (arrTractor.count == 0) ? 1 : arrTractor.count
            case .Truck:
                return (arrTruck.count == 0) ? 1 : arrTruck.count
            default :
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EarningShimmerCell", for: indexPath) as! EarningShimmerCell
            cell.selectionStyle = .none
            return cell
        }else{
            switch tabTypeSelection {
            case .Drivers:
                if arrDriver.count > 0{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DriversTableViewCell", for: indexPath) as! DriversTableViewCell
                    cell.data = arrDriver[indexPath.row]
                    cell.setData()
                    cell.clickEdit = {
                        let driverPermissionVC = DriverPermissionVC.instantiate(fromAppStoryboard: .Home)
                        driverPermissionVC.driverId = "\(self.arrDriver[indexPath.row].id ?? 0)"
                        driverPermissionVC.driverName = self.arrDriver[indexPath.row].name ?? ""
                        driverPermissionVC.rating = Double(self.arrDriver[indexPath.row].driverRating ?? "0.0") ?? 0.0
                        driverPermissionVC.driverVehicle = self.arrDriver[indexPath.row].driverVehicle
                        self.navigationController?.pushViewController(driverPermissionVC, animated: true)
                    }
                    return cell
                }else{
                    let NoDatacell = tableView.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                    NoDatacell.lblNoDataTitle.text = "no_driver_found".localized
                    return NoDatacell
                }
            case .Vehicles:
                if self.arrTractor.count > 0{
                    let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTruckCell.className) as! RegisterTruckCell
                    cell.selectionStyle = .none
                    cell.data = self.arrTractor[indexPath.row]
                    cell.setData()
                    return cell
                }else{
                    let NoDatacell = tableView.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                    NoDatacell.lblNoDataTitle.text = "no_tractor_found".localized
                    return NoDatacell
                }
            case .Truck:
                if self.arrTruck.count > 0{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "VehiclesTableViewCell", for: indexPath) as! VehiclesTableViewCell
                    cell.data = arrTruck[indexPath.row]
                    cell.setData()
                    return cell
                }else{
                    let NoDatacell = tableView.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                    NoDatacell.lblNoDataTitle.text = "No_truck_found".localized
                    return NoDatacell
                }
            default :
                break
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tabTypeSelection{
        case .Drivers:
            if arrDriver.count > 0{
                if arrDriver[indexPath.row].blockStatus == "0"{
                    let addDriverVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: AddDriverVC.storyboardID) as! AddDriverVC
                    addDriverVC.isFromEdit = true
                    addDriverVC.isEditEnable = false
                    addDriverVC.delegate = self
                    addDriverVC.editData = arrDriver[indexPath.row]
                    addDriverVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(addDriverVC, animated: true)
                }else{
                    let addDriverVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: DriverLoadsVC.storyboardID) as! DriverLoadsVC
                    addDriverVC.driverData = arrDriver[indexPath.row]
                    addDriverVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(addDriverVC, animated: true)
                }
            }
        case .Vehicles:
            if arrTractor.count > 0{
                let addTractor = AppStoryboard.Auth.instance.instantiateViewController(withIdentifier: TractorDetailVC.storyboardID) as! TractorDetailVC
                addTractor.isFromEdit = true
                addTractor.isEditEnable = false
                addTractor.delegate = self
                addTractor.editData = arrTractor[indexPath.row]
                addTractor.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(addTractor, animated: true)
            }
        case .Truck:
            if arrTruck.count > 0{
                let addTruck = AppStoryboard.Auth.instance.instantiateViewController(withIdentifier: AddTruckVC.storyboardID) as! AddTruckVC
                addTruck.isFromEdit = true
                addTruck.isEditEnable = false
                addTruck.delegate = self
                addTruck.editData = arrTruck[indexPath.row]
                addTruck.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(addTruck, animated: true)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
        } else {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: UIColor.lightGray.withAlphaComponent(0.3))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (isLoading){
            return UITableView.automaticDimension
        }else{
            var count = 0
            switch tabTypeSelection{
            case .Drivers:
                count = arrDriver.count
            case .Vehicles:
                count = arrTractor.count
            case .Truck:
                count = arrTruck.count
            default:
                break
            }
            if(count > 0){
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        }
    }
}

//MARK: - Web service method
extension MyFleetVC{
    func getDriverList(){
        self.myFleetViewModel.VC = self
        self.myFleetViewModel.getDriverList()
    }
    
    func getTruckList(){
        self.myFleetViewModel.VC = self
        self.myFleetViewModel.getTruckList()
    }
    
    func getTractorList(){
        self.myFleetViewModel.VC = self
        self.myFleetViewModel.getTractorList()
    }
}
