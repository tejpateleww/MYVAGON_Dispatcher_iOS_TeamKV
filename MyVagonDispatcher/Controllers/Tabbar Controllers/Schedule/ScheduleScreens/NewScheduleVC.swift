//
//  NewScheduleVC.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 02/02/22.
//

import UIKit
import DropDown
import FittedSheets

class NewScheduleVC: BaseViewController {
    //MARK: - Properties
    @IBOutlet weak var collectionOfHistory: UICollectionView!
    @IBOutlet weak var tblScheduleData: UITableView!
    @IBOutlet weak var heightPostaAvailabilityCont: NSLayoutConstraint!
    @IBOutlet weak var btnPostAvalibility: ThemeBidRequestButton!
    @IBOutlet weak var viewPostAvalibility: UIView!
    @IBOutlet weak var lblPostAvalibility: UILabel!
    
    var optionMenuDropDown = DropDown()
    var optionArray : [String] = ["All","Bid","Book","Posted truck"]
    var displayOptionArray = ["All".localized,"Bid".localized,"Book".localized,"Posted truck".localized]
    var arrStatus:[MyLoadesStatus] = [.all,.pending,.scheduled,.inprocess,.past]
    var selectedIndex = 0
    var PageNumber = 0
    var myScheduleViewModel = MyScheduleViewModel()
    var trashPostedTruckViewModel = TrashPostedTruckViewModel()
    var CurrentFilterStatus : MyLoadesStatus = .all
    var selectedOption = -1
    var customTabBarController: CustomTabBarVC?
    let refreshControl = UIRefreshControl()
    var isTblReload = false
    var isLoading = true {
        didSet {
            self.tblScheduleData.isUserInteractionEnabled = !isLoading
            self.tblScheduleData.reloadData()
        }
    }
    var isNeedToReload = true
    var arrMyScheduleData : [[NewMyLoadData]]?
    
    //MARK: - Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.customTabBarController?.showTabBar()
        if self.tabBarController != nil {
            self.customTabBarController = (self.tabBarController as! CustomTabBarVC)
        }
        self.addObserver()
        self.setLocalization()
    }
    
    //MARK: - Custom methods
    @objc func changeLanguage(){
        self.tblScheduleData.reloadData()
        self.setLocalization()
    }
    
    func setLocalization() {
        self.lblPostAvalibility.text = "Post Availability".localized
        displayOptionArray = ["All".localized,"Bid".localized,"Book".localized,"Posted truck".localized]
        self.setupOptionMenu()
        self.collectionOfHistory.reloadData()
        if optionMenuDropDown.selectedItem ?? "" == "All".localized{
            setNavigationBar(subTitle: "")
        }else{
            setNavigationBar(subTitle: optionMenuDropDown.selectedItem ?? "")
        }
    }
    
    func prepareView(){
        self.setupUI()
        self.setupData()
    }
    
    func setupUI(){
        setNavigationBar(subTitle: "")
        self.lblPostAvalibility.font = CustomFont.PoppinsMedium.returnFont(FontSize.size12.rawValue)
        self.viewPostAvalibility.layer.borderWidth = 1
        self.viewPostAvalibility.layer.borderColor = hexStringToUIColor(hex: "#9B51E0").cgColor
        self.viewPostAvalibility.layer.cornerRadius = 10
        self.viewPostAvalibility.clipsToBounds = true
        self.tblScheduleData.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: .leastNormalMagnitude))
        self.tblScheduleData.delegate = self
        self.tblScheduleData.dataSource = self
        self.tblScheduleData.separatorStyle = .none
        self.tblScheduleData.showsHorizontalScrollIndicator = false
        self.tblScheduleData.showsVerticalScrollIndicator = false
        self.heightPostaAvailabilityCont.constant = 80
        self.registerNib()
        self.addRefreshControl()
    }
    
    func setupData(){
        self.collectionOfHistory.dataSource = self
        self.collectionOfHistory.delegate = self
        self.setupOptionMenu()
        CallWebSerive(status: self.CurrentFilterStatus)
        self.btnOptionClosour = {
            self.optionMenuDropDown.show()
        }
    }
    
    func registerNib(){
        let scheduleDataCellNib = UINib(nibName: ScheduleDataCell.className, bundle: nil)
        self.tblScheduleData.register(scheduleDataCellNib, forCellReuseIdentifier: ScheduleDataCell.className)
        let earningShimmerCellNib = UINib(nibName: EarningShimmerCell.className, bundle: nil)
        self.tblScheduleData.register(earningShimmerCellNib, forCellReuseIdentifier: EarningShimmerCell.className)
        let noDataTableViewCellNib = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblScheduleData.register(noDataTableViewCellNib, forCellReuseIdentifier: NoDataTableViewCell.className)
    }
    
    func addObserver(){
        NotificationCenter.default.removeObserver(self, name: .PostCompleteTrip, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PostCompleteTrip), name: .PostCompleteTrip, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "RefreshViewForPostTruck"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RefreshViewForPostTruck), name: NSNotification.Name(rawValue: "RefreshViewForPostTruck"), object: nil)
    }
    
    func setupOptionMenu(){
        self.optionMenuDropDown.anchorView = btnOption
        self.optionMenuDropDown.dataSource = displayOptionArray
        self.optionMenuDropDown.selectRow(at: selectedOption >= 0 ? selectedOption : 0 )
        self.optionMenuDropDown.selectionAction = { [] (index, item) in
            self.selectedOption = index
            self.optionArray[index] == "All" ? self.setNavigationBar(subTitle: "") : self.setNavigationBar(subTitle: self.optionArray[index].localized)
            self.reloadSearchData()
        }
    }
    
    func addRefreshControl(){
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.tintColor = #colorLiteral(red: 0.6078431373, green: 0.3176470588, blue: 0.8784313725, alpha: 1)
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.tblScheduleData.addSubview(self.refreshControl)
    }
    
    func reloadSearchData(){
        self.PageNumber = 0
        self.arrMyScheduleData = []
        self.isTblReload = false
        self.isLoading = true
        self.CallWebSerive(status: CurrentFilterStatus)
    }
    
    func setNavigationBar(subTitle:String){
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "My Loads".localized, leftImage: NavItemsLeft.none.value, rightImages:  [NavItemsRight.option.value], isTranslucent: true, ShowShadow: true,subTitleString: subTitle, isHomeTitle: true)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.reloadSearchData()
    }
    
    @objc func PostCompleteTrip(){
        self.selectedIndex = 4
        self.CurrentFilterStatus = .past
        self.collectionOfHistory.reloadData()
        self.reloadSearchData()
    }
    
    @objc func RefreshViewForPostTruck() {
        self.reloadSearchData()
    }
    
    //MARK: - UIButton Action methods
    @IBAction func btnPostTruck(_ sender: Any) {
        let controller = PostTruckViewController.instantiate(fromAppStoryboard: .Home)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

//MARK: - Api Methods
extension NewScheduleVC{
    
    func CallWebSerive(status:MyLoadesStatus) {
        self.PageNumber = self.PageNumber + 1
        self.myScheduleViewModel.scheduleViewController =  self
        let ReqModelForMyLoades = MyLoadsReqModel()
        ReqModelForMyLoades.page_num = "\(self.PageNumber)"
        ReqModelForMyLoades.status = status.Name
        let index = displayOptionArray.firstIndex(of: self.optionMenuDropDown.selectedItem ?? "")
        ReqModelForMyLoades.type = optionArray[index ?? 0].lowercased().replacingOccurrences(of: " ", with: "_")
        self.myScheduleViewModel.getMyloads(ReqModel: ReqModelForMyLoades)
    }
    
    func callWebServiceToAssignDriver(index: IndexPath,driver:DispaterDriver?){
        let viewModel = AssignDriverViewModel()
        let reqModel = AssignDriverReqModel()
        let data = self.arrMyScheduleData?[index.section][index.row]
        reqModel.driver_id = "\(driver?.id ?? 0)"
        switch data?.type{
        case MyLoadType.Bid.Name:
            reqModel.booking_id = "\(data?.bid?.id ?? 0)"
        case MyLoadType.Book.Name:
            reqModel.booking_id = "\(data?.book?.id ?? 0)"
        case MyLoadType.PostedTruck.Name:
            reqModel.booking_id = "\(data?.postedTruck?.id ?? 0)"
        default :
            break
        }
        viewModel.callApiToAssignDriver(reqModel: reqModel){
            let driverDetail = DriverDetail(id: driver?.id, name: driver?.name)
            switch data?.type{
            case MyLoadType.Bid.Name:
                self.arrMyScheduleData?[index.section][index.row].bid?.driverDetail = driverDetail
            case MyLoadType.Book.Name:
                self.arrMyScheduleData?[index.section][index.row].book?.driverDetail = driverDetail
            case MyLoadType.PostedTruck.Name:
                self.arrMyScheduleData?[index.section][index.row].bid?.driverDetail = driverDetail
            default :
                break
            }
            self.tblScheduleData.reloadData()
        }
    }
    
    func callWebServiceToDeletePostedTruck(truckId : String){
        let reqestmodel = TrashPostedTruck()
        reqestmodel.postedTruckId = truckId
        trashPostedTruckViewModel.newScheduleVC = self
        trashPostedTruckViewModel.webServiceToDelatePostedTruck(req: reqestmodel)
    }
    
}
//MARK: - UICollectionView Delegate and Data Source Methods
extension NewScheduleVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrStatus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatusListCell", for: indexPath) as! StatusListCell
        if arrStatus[indexPath.row] == .scheduled{
            cell.lblStatus.text = "scheduled2".localized.capitalized
        }else{
            cell.lblStatus.text = arrStatus[indexPath.row].Name.localized.capitalized
        }
        cell.lblStatus.textColor =  selectedIndex == indexPath.row ? UIColor(hexString: "#9B51E0") : UIColor(hexString: "#9A9AA9")
        cell.viewBG.backgroundColor = selectedIndex == indexPath.row ? UIColor(hexString: "#9B51E0") : UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((arrStatus[indexPath.row].Name.localized.capitalized).sizeOfString(usingFont: CustomFont.PoppinsRegular.returnFont(14)).width) + 30, height: collectionOfHistory.frame.size.height - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.CurrentFilterStatus = arrStatus[indexPath.row]
        self.reloadSearchData()
        self.selectedIndex = indexPath.row
        self.collectionOfHistory.reloadData()
        self.tblScheduleData.scrollToTop()
    }
    
}
//MARK: - UITableView Delegate and Data Source Methods
extension NewScheduleVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isLoading {
            return 1
        }
        return (arrMyScheduleData?.count ?? 0 == 0) ? 1 : arrMyScheduleData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.arrMyScheduleData?.count ?? 0 > 0){
            return self.arrMyScheduleData?[section].count ?? 0
        }else{
            return (!self.isTblReload) ? 10 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (!self.isTblReload){
            let cell = tableView.dequeueReusableCell(withIdentifier: "EarningShimmerCell", for: indexPath) as! EarningShimmerCell
            cell.selectionStyle = .none
            return cell
        }else{
            if arrMyScheduleData?.count ?? 0 > 0{
                let cell = self.tblScheduleData.dequeueReusableCell(withIdentifier: "ScheduleDataCell", for: indexPath) as! ScheduleDataCell
                cell.selectionStyle = .none
                var bookingId = 0
                cell.btnDelete.isUserInteractionEnabled = false
                cell.btnDelete.isHidden = true
                cell.tblData = arrMyScheduleData?[indexPath.section][indexPath.row]
                switch arrMyScheduleData?[indexPath.section][indexPath.row].type{
                case MyLoadType.Bid.Name:
                    cell.lblScheduleType.text = "Bid".localized
                    cell.arrLocations = arrMyScheduleData?[indexPath.section][indexPath.row].bid?.locations ?? []
                    cell.setData(data: arrMyScheduleData?[indexPath.section][indexPath.row].bid)
                    bookingId = arrMyScheduleData?[indexPath.section][indexPath.row].bid?.id ?? 0
                case MyLoadType.Book.Name:
                    cell.lblScheduleType.text = "Book".localized
                    cell.arrLocations = arrMyScheduleData?[indexPath.section][indexPath.row].book?.locations ?? []
                    cell.setData(data: arrMyScheduleData?[indexPath.section][indexPath.row].book)
                    bookingId = arrMyScheduleData?[indexPath.section][indexPath.row].book?.id ?? 0
                case MyLoadType.PostedTruck.Name:
                    cell.lblScheduleType.text = "Posted Truck".localized
                    cell.setPostedTruck(lodeData: arrMyScheduleData?[indexPath.section][indexPath.row].postedTruck)
                    cell.btnDelete.isUserInteractionEnabled = true
                default :
                    break
                }
                cell.btnMatchTapCousure = {
                    self.handalMatchAction(myloadDetails: self.arrMyScheduleData?[indexPath.section][indexPath.row])
                }
                cell.btnDeleteTap = {
                    self.deleteShipment("\(self.arrMyScheduleData?[indexPath.section][indexPath.row].postedTruck?.id ?? 0)")
                }
                cell.btnAssignDriverTap = {
                    SingletonClass.sharedInstance.getAvailableDriverList(bookingId: "\(bookingId)") { data in
                        let controller = AppStoryboard.Popup.instance.instantiateViewController(withIdentifier: SelectPopUpVC.storyboardID) as! SelectPopUpVC
                        controller.tabTypeSelection = .Drivers
                        controller.pageTitle = "empty_driver_massage".localized
                        let filterData = data?.filter({$0.driverVehicle?.isAssing == 1 && $0.blockStatus != "0"})
                        if filterData?.count ?? 0 > 0 {
                            controller.arrDriver = filterData ?? [DispaterDriver]()
                            controller.modalPresentationStyle = .overCurrentContext
                            controller.modalTransitionStyle = .crossDissolve
                            controller.clickEdit = { (driver) in
                                let driver = driver as? DispaterDriver
                                self.callWebServiceToAssignDriver(index: indexPath, driver: driver)
                            }
                            controller.dismiss = {
                                self.customTabBarController?.showTabBar()
                            }
                            self.customTabBarController?.hideTabBar()
                            self.present(controller, animated: true, completion: nil)
                        }else{
                            Utilities.ShowAlertOfValidation(OfMessage: "no_driver_found_msg".localized)
                        }
                    }
                }
                return cell
            }else{
                let NoDatacell = self.tblScheduleData.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                NoDatacell.lblNoDataTitle.text = "No Loads Found".localized
                return NoDatacell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isLoading {return UIView()}
        if self.arrMyScheduleData?.count ?? 0 > 0 {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
            headerView.backgroundColor = UIColor(hexString: "#FAFAFA")
            let label = UILabel()
            label.frame = headerView.frame
            label.text = arrMyScheduleData?[section].first?.date?.ConvertDateFormat(FromFormat: "yyyy-MM-dd", ToFormat: DateFormatForDisplay)
            label.textAlignment = .center
            label.font = CustomFont.PoppinsMedium.returnFont(FontSize.size15.rawValue)
            label.textColor = UIColor(hexString: "#292929")
            label.drawLineOnBothSides(labelWidth: label.frame.size.width, color: #colorLiteral(red: 0.611544311, green: 0.2912456691, blue: 0.8909440637, alpha: 1))
            headerView.addSubview(label)
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isLoading {return 0}
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
        } else {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: UIColor.lightGray.withAlphaComponent(0.3))
        }
        if !isLoading{
            if indexPath.section == ((arrMyScheduleData?.count ?? 0) - 1){
                if indexPath.row == ((arrMyScheduleData?[indexPath.section].count ?? 0) - 1) && isNeedToReload {
                    let spinner = UIActivityIndicatorView(style: .medium)
                    spinner.tintColor = RefreshControlColor
                    spinner.startAnimating()
                    spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tblScheduleData.bounds.width, height: CGFloat(44))
                    self.tblScheduleData.tableFooterView = spinner
                    self.tblScheduleData.tableFooterView?.isHidden = false
                    CallWebSerive(status: CurrentFilterStatus)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (!isTblReload){
            return UITableView.automaticDimension
        }else{
            if(arrMyScheduleData?.count ?? 0 > 0){
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.goToDeatilScreen(indexPath: indexPath)
    }
    
    func goToDeatilScreen(indexPath : IndexPath){
        if(arrMyScheduleData?.count ?? 0 > 0){
            if arrMyScheduleData?[indexPath.section][indexPath.row].type == MyLoadType.PostedTruck.Name {
                let myloadDetails = arrMyScheduleData?[indexPath.section][indexPath.row]
                if myloadDetails?.postedTruck?.bookingInfo != nil {
                    if !isLoading {
                        self.openDetailPage(status: "Posted Truck", bookingId:  "\(self.arrMyScheduleData?[indexPath.section][indexPath.row].postedTruck?.bookingInfo?.id ?? 0)", driverId: "\(self.arrMyScheduleData?[indexPath.section][indexPath.row].postedTruck?.bookingInfo?.driverDetail?.id ?? 0)")
                    }
                }else if myloadDetails?.postedTruck?.bookingRequestCount != 0 && myloadDetails?.postedTruck?.isBid != 1{
                    self.openBidReqDetail(myloadDetails: myloadDetails)
                }
            } else {
                if !isLoading {
                    if (self.arrMyScheduleData?[indexPath.section][indexPath.row].type == MyLoadType.Bid.Name) {
                        openDetailPage(status: MyLoadType.Bid.Name.localized, bookingId:  "\(self.arrMyScheduleData?[indexPath.section][indexPath.row].bid?.id ?? 0)", driverId: "\(self.arrMyScheduleData?[indexPath.section][indexPath.row].bid?.driverDetail?.id ?? 0)")
                    } else {
                        openDetailPage(status: MyLoadType.Book.Name.localized, bookingId: "\(self.arrMyScheduleData?[indexPath.section][indexPath.row].book?.id ?? 0)", driverId: "\(self.arrMyScheduleData?[indexPath.section][indexPath.row].book?.driverDetail?.id ?? 0)")
                    }
                }
            }
        }
    }
    
    func openDetailPage(status:String,bookingId:String,driverId: String){
        WebServiceSubClass.SystemDateTime { (_, _, _, _) in
            let viewControler = ShipmentDetailViewModel()
            let reqModel = ShipmentDetailReqModel()
            reqModel.bookingId = bookingId
            reqModel.driverId = driverId
            viewControler.getShipmentDetail(reqModel: reqModel,DisplayStatus: status)
        }
    }
    
    func openBidReqDetail(myloadDetails :NewMyLoadData?){
        let postTruckBidsViewModel = BidRequestViewModel()
        postTruckBidsViewModel.scheduleVC = self
        let reqModel = PostTruckBidReqModel()
        reqModel.availability_id = "\(myloadDetails?.postedTruck?.id ?? 0)"
        //        reqModel.driver_id = "\(SingletonClass.sharedInstance.UserProfileData?.id ?? 0)"
        postTruckBidsViewModel.BidRequest(ReqModel: reqModel)
    }
    
    func deleteShipment(_ id:String){
        let controller = AppStoryboard.Popup.instance.instantiateViewController(withIdentifier: DeleteConfirmPopupVC.storyboardID) as! DeleteConfirmPopupVC
        controller.hidesBottomBarWhenPushed = true
        controller.titleText = "Are you sure you want to delete it?".localized
        let sheetController = SheetViewController(controller: controller,sizes: [.fixed(CGFloat(170) + appDel.GetSafeAreaHeightFromBottom())])
        sheetController.allowPullingPastMaxHeight = false
        self.present(sheetController, animated: true, completion: nil)
        controller.btnPositiveAction = {
            self.callWebServiceToDeletePostedTruck(truckId: id)
        }
    }
    
    func handalMatchAction(myloadDetails :NewMyLoadData?){
        if (myloadDetails?.postedTruck?.bookingRequestCount ?? 0) != 0 {
            if myloadDetails?.postedTruck?.isBid == 1{
                let controller = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: PostedTruckBidRequestVC.storyboardID) as! PostedTruckBidRequestVC
                controller.BidsData = myloadDetails
                controller.hidesBottomBarWhenPushed = true
                controller.PostTruckID = "\(myloadDetails?.postedTruck?.id ?? 0)"
                self.navigationController?.pushViewController(controller, animated: true)
            }else{
                self.openBidReqDetail(myloadDetails: myloadDetails)
            }
        }else{
            if (myloadDetails?.postedTruck?.matchesCount ?? 0) != 0 {
                let controller = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: PostedTruckMatchesVC.storyboardID) as! PostedTruckMatchesVC
                controller.driverId = myloadDetails?.postedTruck?.driverId ?? ""
                controller.NumberOfCount = myloadDetails?.postedTruck?.matchesCount ?? 0
                controller.hidesBottomBarWhenPushed = true
                controller.PostTruckID = "\(myloadDetails?.postedTruck?.id ?? 0)"
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}
