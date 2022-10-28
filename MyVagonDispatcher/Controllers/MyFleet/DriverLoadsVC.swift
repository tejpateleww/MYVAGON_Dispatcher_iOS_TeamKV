//
//  DriverLoadsVC.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 05/09/22.
//

import UIKit

class DriverLoadsVC: BaseViewController {
    
    //MARK: - properties
    @IBOutlet weak var tblDriverData: UITableView!
    @IBOutlet weak var tblDriverLoads: UITableView!
    @IBOutlet weak var lblDriverLoads: UILabel!
    @IBOutlet weak var heightConstantTblDriver: NSLayoutConstraint!
    
    var driverData: DispaterDriver?
    var isLoading = true {
        didSet {
            self.tblDriverLoads.isUserInteractionEnabled = !isLoading
            self.tblDriverLoads.reloadData()
        }
    }
    var driverLoadsViewModel = DriverLoadViewModel()
    var arrDriverLoads : [NewLoadData] = []
    let refreshControl = UIRefreshControl()
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]{
                let newsize  = newvalue as! CGSize
                self.heightConstantTblDriver.constant = newsize.height
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "editdriver"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileEdit), name: NSNotification.Name(rawValue: "editdriver"), object: nil)
    }
    
    //MARK: - Custom method
    func setUpUI(){
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "driver_loads".localized, leftImage: NavItemsLeft.back.value, rightImages: [], isTranslucent: true, ShowShadow: true)
        self.tblDriverData.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        registerNib()
        setLocalisation()
        addRefreshControl()
        self.tblDriverLoads.separatorStyle = .none
    }
    
    func setLocalisation(){
        lblDriverLoads.text = "driver_loads".localized
    }
    
    @objc func ProfileEdit(){
        let addDriverVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: AddDriverVC.storyboardID) as! AddDriverVC
        addDriverVC.isFromEdit = true
        addDriverVC.isEditEnable = true
        addDriverVC.editData = driverData
        addDriverVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addDriverVC, animated: true)
    }
    
    func setUpData(){
        tblDriverData.dataSource = self
        tblDriverData.delegate = self
        tblDriverLoads.dataSource = self
        tblDriverLoads.delegate = self
        self.getDriverDetail()
    }
    
    func registerNib(){
        tblDriverData.register(UINib(nibName: "DriversTableViewCell", bundle: nil), forCellReuseIdentifier: "DriversTableViewCell")
        let nib = UINib(nibName: MyEarningCell.className, bundle: nil)
        self.tblDriverLoads.register(nib, forCellReuseIdentifier: MyEarningCell.className)
        let earningShimmerCellNib = UINib(nibName: EarningShimmerCell.className, bundle: nil)
        self.tblDriverLoads.register(earningShimmerCellNib, forCellReuseIdentifier: EarningShimmerCell.className)
        let noDataTableViewCellNib = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblDriverLoads.register(noDataTableViewCellNib, forCellReuseIdentifier: NoDataTableViewCell.className)
    }
    
    func addRefreshControl(){
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.tintColor = #colorLiteral(red: 0.6078431373, green: 0.3176470588, blue: 0.8784313725, alpha: 1)
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.tblDriverLoads.addSubview(self.refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
        self.getDriverDetail()
    }
}

//MARK: - WebService method
extension DriverLoadsVC{
    func getDriverDetail(){
        let reqModel = DriverLoadsReqModel()
        reqModel.driver_id = "\(self.driverData?.id ?? Int())"
        driverLoadsViewModel.vc = self
        driverLoadsViewModel.getDriverLoads(reqModel: reqModel)
    }
}

//MARK: - Table view datasource and delegate method
extension DriverLoadsVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblDriverData{
            return 1
        }else{
            if isLoading{
                return 10
            }else{
                let count: Int = arrDriverLoads.count
                return (count == 0) ? 1 : count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblDriverData{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DriversTableViewCell", for: indexPath) as! DriversTableViewCell
            cell.data = driverData
            cell.setData()
            cell.clickEdit = {
                let driverPermissionVC = DriverPermissionVC.instantiate(fromAppStoryboard: .Home)
                driverPermissionVC.driverId = "\(self.driverData?.id ?? 0)"
                driverPermissionVC.driverVehicle = self.driverData?.driverVehicle
                driverPermissionVC.driverName = self.driverData?.name ?? ""
                driverPermissionVC.rating = Double(self.driverData?.driverRating ?? "0") ?? 0.0
                self.navigationController?.pushViewController(driverPermissionVC, animated: true)
            }
            return cell
        }else{
            if isLoading{
                let cell = tableView.dequeueReusableCell(withIdentifier: "EarningShimmerCell", for: indexPath) as! EarningShimmerCell
                cell.selectionStyle = .none
                return cell
            }else{
                if arrDriverLoads.count > 0{
                    let cell = tblDriverLoads.dequeueReusableCell(withIdentifier: MyEarningCell.className) as! MyEarningCell
                    cell.selectionStyle = .none
                    cell.lblCompanyNAme.text = self.arrDriverLoads[indexPath.row].shipperDetails?.companyName
                    let amount: String = self.arrDriverLoads[indexPath.row].amount ?? ""
                    cell.lblAmount.text = Currency + amount
                    cell.lblTripID.text = "#\(self.arrDriverLoads[indexPath.row].id ?? 0 )"
                    cell.lblTon.text =   "\(self.arrDriverLoads[indexPath.row].totalWeight ?? "" ) , \(self.arrDriverLoads[indexPath.row].distance ?? "") miles"
                    cell.arrLocations = self.arrDriverLoads[indexPath.row].locations ?? []
                    cell.tblEarningLocation.reloadData()
                    cell.tblEarningLocation.layoutIfNeeded()
                    cell.tblEarningLocation.layoutSubviews()
                    cell.tblHeight = { (heightTBl) in
                        self.tblDriverLoads.layoutIfNeeded()
                        self.tblDriverLoads.layoutSubviews()
                    }
                    cell.getStatusColor(status: self.arrDriverLoads[indexPath.row].status ?? "", paymentStatus: self.arrDriverLoads[indexPath.row].paymentStatus ?? "")
                    return cell
                }else{
                    let NoDatacell = self.tblDriverLoads.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                    NoDatacell.lblNoDataTitle.text = "No Loads Found".localized
                    return NoDatacell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tblDriverData{
            let addDriverVC = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: AddDriverVC.storyboardID) as! AddDriverVC
            addDriverVC.isFromEdit = true
            addDriverVC.isEditEnable = false
            //            addDriverVC.delegate = self
            addDriverVC.editData = driverData
            addDriverVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(addDriverVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView != tblDriverData{
            if #available(iOS 13.0, *) {
                cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
            } else {
                cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: UIColor.lightGray.withAlphaComponent(0.3))
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (isLoading){
            return UITableView.automaticDimension
        }else{
            if tableView == tblDriverLoads{
                if arrDriverLoads.count == 0{
                    return tblDriverLoads.frame.height
                }
            }
            return UITableView.automaticDimension
        }
    }
}
