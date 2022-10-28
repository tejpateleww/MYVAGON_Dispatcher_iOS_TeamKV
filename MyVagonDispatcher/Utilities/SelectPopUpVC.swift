//
//  SelectPopUpVC.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 29/07/22.
//

import UIKit
import SDWebImage

class SelectPopUpVC: BaseViewController {
    
    //MARK: - Properties
    @IBOutlet weak var mainView: ThemeView!
    @IBOutlet weak var tblData: UITableView!
    @IBOutlet weak var tblHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    
    var arrDriver = [DispaterDriver]()
    var arrTruck = [TruckList]()
    var arrTractor = [TractorList]()
    var clickEdit : ((Any)->())?
    var tabTypeSelection = SelectionBtn(rawValue: 0)
    var dismiss : (()->())?
    var pageTitle = ""
    
    //MARK: - Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let clickDismiss = dismiss {
            clickDismiss()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]{
                let newsize  = newvalue as! CGSize
                let height = newsize.height + 100
                if height > self.view.frame.height{
                    self.tblHeightConstant.constant = self.view.frame.height - 180
                    self.tblData.isScrollEnabled = true
                }else{
                    self.tblHeightConstant.constant = newsize.height
                    self.tblData.isScrollEnabled = false
                }   
            }
        }
    }
    
    //MARK: - Custom method
    
    func setUpUI(){
        self.registerNib()
        self.lblTitle.text = pageTitle
    }
    
    func registerNib(){
        tblData.register(UINib(nibName: "DriversTableViewCell", bundle: nil), forCellReuseIdentifier: "DriversTableViewCell")
        tblData.dataSource = self
        tblData.delegate = self
        self.tblData.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        tblData.register(UINib(nibName: "VehiclesTableViewCell", bundle: nil), forCellReuseIdentifier: "VehiclesTableViewCell")
        let nib = UINib(nibName: RegisterTruckCell.className, bundle: nil)
        self.tblData.register(nib, forCellReuseIdentifier: RegisterTruckCell.className)
    }
    
    // MARK: - IBAction methods
    @IBAction func BtnClosePopupAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK: - Table view datasource and delegate method
extension SelectPopUpVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tabTypeSelection {
        case .Drivers:
            if arrDriver.count > 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DriversTableViewCell", for: indexPath) as! DriversTableViewCell
                cell.data = arrDriver[indexPath.row]
                cell.setData()
                cell.viewEdit.isHidden = true
                return cell
            }
        case .Vehicles:
            if self.arrTractor.count > 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTruckCell.className) as! RegisterTruckCell
                cell.selectionStyle = .none
                cell.data = self.arrTractor[indexPath.row]
                cell.setData()
                return cell
            }
        case .Truck:
            if self.arrTruck.count > 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "VehiclesTableViewCell", for: indexPath) as! VehiclesTableViewCell
                cell.data = arrTruck[indexPath.row]
                cell.setData()
                return cell
            }
        default :
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let clicked = clickEdit {
            let cell = tableView.cellForRow(at: indexPath)
            UIView.animate(withDuration: 0.1) {
                cell?.transform = CGAffineTransform(scaleX: 0, y: 0)
            } completion: { _ in
                cell?.transform = .identity
                switch self.tabTypeSelection {
                case .Drivers:
                    clicked(self.arrDriver[indexPath.row])
                case .Vehicles:
                    clicked(self.arrTractor[indexPath.row])
                case .Truck:
                    clicked(self.arrTruck[indexPath.row])
                default:break
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
