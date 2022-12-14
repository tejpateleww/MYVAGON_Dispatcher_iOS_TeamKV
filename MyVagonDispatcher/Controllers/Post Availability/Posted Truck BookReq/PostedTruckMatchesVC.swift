//
//  PostedTruckBidsViewController.swift
//  MyVagon
//
//  Created by Apple on 02/12/21.
//

import UIKit

class PostedTruckMatchesVC: BaseViewController {
    
    //MARK: - Propertise
    @IBOutlet weak var tblLocations: UITableView!
    
    var isLoading = true {
        didSet {
            tblLocations.isUserInteractionEnabled = !isLoading
            tblLocations.reloadData()
        }
    }
    var PostTruckID = ""
    var PageNumber = 0
    var driverId = ""
    var arrHomeData : [[SearchLoadsDatum]]?
    var isNeedToReload = false
    var postedTruckBidsViewModel = PostedTruckBidsViewModel()
    var arrStatus = ["All","Pending","Scheduled","In-Progress","Past"]
    var selectedIndex = 1
    var customTabBarController: CustomTabBarVC?
    var refreshControl = UIRefreshControl()
    var NumberOfCount = 0
    
    //MARK: - Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.customTabBarController?.hideTabBar()
    }
    
    //MARK: - Custom method
    func setUpUI(){
        self.isLoading = true
        if self.tabBarController != nil {
            self.customTabBarController = (self.tabBarController as! CustomTabBarVC)
        }
        self.tblLocations.register(UINib(nibName: "PickUpDropOffCell", bundle: nil), forCellReuseIdentifier: "PickUpDropOffCell")
        self.tblLocations.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: .leastNormalMagnitude))
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Reload_title".localized, leftImage: NavItemsLeft.back.value, rightImages: [], isTranslucent: true, ShowShadow: false,subTitleString: "")
        DispatchQueue.main.async {
            self.tblLocations.layoutIfNeeded()
            self.tblLocations.reloadData()
        }
        self.refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        self.refreshControl.tintColor = RefreshControlColor
        self.tblLocations.refreshControl = refreshControl
        self.CallWebSerive()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        PageNumber = 0
        CallWebSerive()
    }
}

//MARK: - TableView dataSource and delegate
extension PostedTruckMatchesVC : UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if arrHomeData?.count != 0{
            numOfSections = arrHomeData?.count ?? 0
            tableView.backgroundView = nil
        }
        else{
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No Loads Found".localized
            noDataLabel.font = CustomFont.PoppinsBold.returnFont(14)
            noDataLabel.textColor     = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHomeData?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "PickUpDropOffCell", for: indexPath) as! PickUpDropOffCell
        cell.PickUpDropOffData = arrHomeData?[indexPath.section][indexPath.row].trucks?.locations
        cell.BookingDetails = arrHomeData?[indexPath.section][indexPath.row]
//        cell.tblHeight = { (heightTBl) in
//            self.tblLocations.layoutIfNeeded()
//            self.tblLocations.layoutSubviews()
//        }
        cell.tblMultipleLocation.reloadData()
        cell.tblMultipleLocation.layoutIfNeeded()
        cell.tblMultipleLocation.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: SearchDetailVC.storyboardID) as! SearchDetailVC
        controller.hidesBottomBarWhenPushed = true
        controller.LoadDetails = arrHomeData?[indexPath.section][indexPath.row]
        UIApplication.topViewController()?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrHomeData?[section].first?.date?.ConvertDateFormat(FromFormat: "yyyy-MM-dd", ToFormat: DateFormatForDisplay)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = UIColor(hexString: "#FAFAFA")
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 5, width: headerView.frame.width, height: headerView.frame.height-10)
        label.center = CGPoint(x: headerView.frame.size.width / 2, y: headerView.frame.size.height / 2)
        label.text = arrHomeData?[section].first?.date?.ConvertDateFormat(FromFormat: "yyyy-MM-dd", ToFormat: DateFormatForDisplay)
        label.textAlignment = .center
        label.font = CustomFont.PoppinsMedium.returnFont(FontSize.size15.rawValue)
        label.textColor = UIColor(hexString: "#292929")
        label.drawLineOnBothSides(labelWidth: label.frame.size.width, color: #colorLiteral(red: 0.611544311, green: 0.2912456691, blue: 0.8909440637, alpha: 1))
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
        if tableView == tblLocations {
            if indexPath.row == ((arrHomeData?[indexPath.section].count ?? 0) - 1) && isNeedToReload == true{
                let spinner = UIActivityIndicatorView(style: .medium)
                spinner.tintColor = RefreshControlColor
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tblLocations.bounds.width, height: CGFloat(44))
                self.tblLocations.tableFooterView = spinner
                self.tblLocations.tableFooterView?.isHidden = false
                CallWebSerive()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

//MARK: - WebService method
extension PostedTruckMatchesVC{
    func CallWebSerive() {
        self.postedTruckBidsViewModel.postedTruckBidsViewController =  self
        let reqModel = PostTruckBidReqModel()
        reqModel.availability_id = PostTruckID
        reqModel.driver_id = driverId
        self.postedTruckBidsViewModel.PostedTruckBid(ReqModel: reqModel)
    }
}
