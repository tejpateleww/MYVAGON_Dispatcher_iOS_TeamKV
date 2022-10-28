//
//  MyEarningVC.swift
//  MyVagonDispatcher
//
//  Created by Tej P on 28/01/22.
//

import UIKit

class MyEarningVC: BaseViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tblEarning: UITableView!
    
    var arrDriver = [DispaterDriver]()
    var arrTruck = [TruckList]()
    var arrTractor = [TractorList]()
    var tabTypeSelection = SelectionBtn(rawValue: 0)
    var earningListViewModel = EarningListViewModel()
    var arrData : [NewLoadData] = []
    var strId : String = ""
    var pageTitle = ""
    var isTblReload = false
    var isLoading = true {
        didSet {
            self.tblEarning.isUserInteractionEnabled = !isLoading
            self.tblEarning.reloadData()
        }
    }
    let refreshControl = UIRefreshControl()
    
    // MARK: - LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    // MARK: - Custome methods
    func prepareView(){
        self.registerNib()
        self.addRefreshControl()
        self.setupUI()
        self.setupData()
    }
    
    func setupUI(){
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: pageTitle, leftImage: NavItemsLeft.back.value, rightImages: [], isTranslucent: true)
        self.tblEarning.delegate = self
        self.tblEarning.dataSource = self
        self.tblEarning.separatorStyle = .none
        self.tblEarning.showsHorizontalScrollIndicator = false
        self.tblEarning.showsVerticalScrollIndicator = false
    }
    
    func setupData(){
        self.callEarningListAPI()
    }
    
    func registerNib(){
        tblEarning.register(UINib(nibName: "VehiclesTableViewCell", bundle: nil), forCellReuseIdentifier: "VehiclesTableViewCell")
        tblEarning.register(UINib(nibName: "DriversTableViewCell", bundle: nil), forCellReuseIdentifier: "DriversTableViewCell")
        let nib = UINib(nibName: RegisterTruckCell.className, bundle: nil)
        self.tblEarning.register(nib, forCellReuseIdentifier: RegisterTruckCell.className)
        let earningShimmerCellNib = UINib(nibName: EarningShimmerCell.className, bundle: nil)
        self.tblEarning.register(earningShimmerCellNib, forCellReuseIdentifier: EarningShimmerCell.className)
        let noDataTableViewCellNib = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblEarning.register(noDataTableViewCellNib, forCellReuseIdentifier: NoDataTableViewCell.className)
    }
    
    func addRefreshControl(){
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.tintColor = #colorLiteral(red: 0.6078431373, green: 0.3176470588, blue: 0.8784313725, alpha: 1)
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.tblEarning.addSubview(self.refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.arrData = []
        self.isTblReload = false
        self.isLoading = true
        self.callEarningListAPI()
    }
}


//MARK: - UITableView Delegate and Data Source Methods
extension MyEarningVC : UITableViewDelegate, UITableViewDataSource {
    
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
                    cell.viewEdit.isHidden = true
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
        } else {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: UIColor.lightGray.withAlphaComponent(0.3))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(!isTblReload){
            return UITableView.automaticDimension
        }else{
            if self.arrData.count != 0 {
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        }
    }
}

//MARK: - WebService method
extension MyEarningVC{
    func callEarningListAPI() {
        self.earningListViewModel.myEarningVC = self
        switch tabTypeSelection{
        case .Drivers:
            self.earningListViewModel.getDriverList()
        case .Truck:
            self.earningListViewModel.getTruckList()
        case .Vehicles:
            self.earningListViewModel.getTractorList()
        case .none:
            break
        }
    }
}


