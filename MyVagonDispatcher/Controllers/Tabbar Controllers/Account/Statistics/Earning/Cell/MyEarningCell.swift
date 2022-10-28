//
//  MyEarningCell.swift
//  MyVagonDispatcher
//
//  Created by Tej P on 28/01/22.
//

import UIKit

class MyEarningCell: UITableViewCell {
    
    //MARK: - Propertise
    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var lblCompanyNAme: themeLabel!
    @IBOutlet weak var lblAmount: themeLabel!
    @IBOutlet weak var lblTripID: themeLabel!
    @IBOutlet weak var lblTon: themeLabel!
    @IBOutlet weak var lblDeadhead: themeLabel!
    @IBOutlet weak var tblEarningLocation: UITableView!
    @IBOutlet weak var tblEarningLocationHeight: NSLayoutConstraint!
    @IBOutlet weak var vWStatus: UIView!
    @IBOutlet weak var lblStatus: themeLabel!
    
    var arrLocations : [MyLoadsNewLocation] = []
    var tblHeight:((CGFloat)->())?
    
    //MARK: - Life cycle method
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
    }
    override func layoutSubviews() {
        self.vWStatus.roundCornerssingleSide(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]{
                let newsize  = newvalue as! CGSize
                self.tblEarningLocationHeight.constant = newsize.height
                if let getHeight  = tblHeight.self {
                    self.tblEarningLocation.layoutSubviews()
                    self.tblEarningLocation.layoutIfNeeded()
                    getHeight(self.tblEarningLocation.contentSize.height)
                }
            }
        }
    }
    
    //MARK: - Custom method
    func registerNib(){
        let nib = UINib(nibName: EarningLocationCell.className, bundle: nil)
        self.tblEarningLocation.register(nib, forCellReuseIdentifier: EarningLocationCell.className)
    }
    
    func getStatusColor(status: String,paymentStatus: String){
        lblStatus.text = status.localized.capitalized
        var color = UIColor()
        switch status{
        case MyLoadesStatus.pending.Name:
            color = #colorLiteral(red: 0.8352941176, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        case MyLoadesStatus.inprocess.Name:
            color = #colorLiteral(red: 0.1753416657, green: 0.388015449, blue: 0.8075901866, alpha: 1)
        case MyLoadesStatus.completed.Name:
            color = #colorLiteral(red: 0.09411764706, green: 0.6078431373, blue: 0.1450980392, alpha: 1)
            if (paymentStatus != "pending"){
                color = #colorLiteral(red: 0.5529411765, green: 0.1254901961, blue: 1, alpha: 1)
                lblStatus.text = "Paid".localized
            }
        case MyLoadesStatus.past.Name:
            color = #colorLiteral(red: 0.8352941176, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        case MyLoadesStatus.canceled.Name:
            color = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.662745098, alpha: 1)
        case MyLoadesStatus.scheduled.Name:
            color = #colorLiteral(red: 0.8977488875, green: 0.6361243129, blue: 0.01851113513, alpha: 1)
        default:
            color = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.662745098, alpha: 1)
        }
        vWStatus.backgroundColor = color
    }
    
    func setUpUI(){
        self.viewContents.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.viewContents.layer.masksToBounds = false
        self.viewContents.layer.shadowRadius = 4
        self.viewContents.layer.borderColor = UIColor.black.cgColor
        self.viewContents.layer.cornerRadius = 15
        self.viewContents.layer.shadowOpacity = 0.1
        self.tblEarningLocation.delegate = self
        self.tblEarningLocation.dataSource = self
        self.tblEarningLocation.separatorStyle = .none
        self.tblEarningLocation.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.registerNib()
    }
}

//MARK: - UITableView Delegate and Data Source Methods
extension MyEarningCell : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblEarningLocation.dequeueReusableCell(withIdentifier: EarningLocationCell.className) as! EarningLocationCell
        cell.selectionStyle = .none
        cell.viewLine.isHidden = false
        cell.lblCompanyName.text = self.arrLocations[indexPath.row].companyName
        var StringForDateTime = ""
        StringForDateTime.append("\(self.arrLocations[indexPath.row].deliveredAt?.ConvertDateFormat(FromFormat: "yyyy-MM-dd", ToFormat: DateFormatForDisplay) ?? "")")
        StringForDateTime.append(" ")
        if(self.arrLocations[indexPath.row].deliveryTimeTo ?? "") == (self.arrLocations[indexPath.row].deliveryTimeFrom ?? ""){
            StringForDateTime.append("\(self.arrLocations[indexPath.row].deliveryTimeTo ?? "")")
        }else{
            StringForDateTime.append("\(self.arrLocations[indexPath.row].deliveryTimeFrom ?? "")-\(self.arrLocations[indexPath.row].deliveryTimeTo ?? "")")
        }
        cell.lblDateTime.text = StringForDateTime
        cell.lblAddress.text = self.arrLocations[indexPath.row].dropLocation
        if(indexPath.row == (self.arrLocations.count - 1)){
            cell.viewLine.isHidden = true
        }
        if(indexPath.row == 0){
            cell.imgLocation.image = UIImage(named: "ic_PickUp")
        }else if(indexPath.row == (self.arrLocations.count) - 1){
            cell.imgLocation.image = UIImage(named: "ic_DropOff")
        }else{
            cell.imgLocation.image = UIImage(named: "ic_pickDrop")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
