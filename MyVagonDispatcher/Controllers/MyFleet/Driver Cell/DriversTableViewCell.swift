//
//  DriversTableViewCell.swift
//  MyVagonDispatcher
//
//  Created by Harsh Dave on 26/01/22.
//

import UIKit
import SDWebImage

class DriversTableViewCell: UITableViewCell {
    
    //MARK: Propertise
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewEdit: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblLoaded: themeLabel!
    @IBOutlet weak var lblAssigned: themeLabel!
    @IBOutlet weak var lblAvailable: themeLabel!
    @IBOutlet weak var lblDriverName: themeLabel!
    @IBOutlet weak var lblInactive: themeLabel!
    @IBOutlet weak var lblAddress: themeLabel!
    @IBOutlet weak var lblRating: themeLabel!
    @IBOutlet weak var lblTruckType: themeLabel!
    @IBOutlet weak var lblDriverEditNAme: themeLabel!
    @IBOutlet weak var lblTruckPlateHint: themeLabel!
    @IBOutlet weak var lblTractorPlateHint: themeLabel!
    @IBOutlet weak var imgDriver: UIImageView!
    
    var data : DispaterDriver?
    var clickEdit : (()->())?
    
    //MARK: - LifeCycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.viewContent.layoutIfNeeded()
        self.viewContent.layer.cornerRadius = 15
        self.viewContent.layer.masksToBounds = true
        let bezierPath = UIBezierPath.init(roundedRect: self.viewContent.bounds, cornerRadius: 15)
        self.viewContent.layer.shadowPath = bezierPath.cgPath
        self.viewContent.layer.masksToBounds = false
        self.viewContent.layer.shadowColor = UIColor.darkGray.cgColor
        self.viewContent.layer.shadowRadius = 3.0
        self.viewContent.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        self.viewContent.layer.shadowOpacity = 0.2
        self.viewContent.backgroundColor = nil
        self.viewContent.layer.backgroundColor =  UIColor.white.cgColor
        self.viewTop.layoutIfNeeded()
        self.viewTop.layer.cornerRadius = 15
        self.viewTop.layer.masksToBounds = true
        let bezierPathTop = UIBezierPath.init(roundedRect: self.viewTop.bounds, cornerRadius: 15)
        self.viewTop.layer.shadowPath = bezierPathTop.cgPath
        self.viewTop.layer.masksToBounds = false
        self.viewTop.layer.shadowColor = UIColor.darkGray.cgColor
        self.viewTop.layer.shadowRadius = 3.0
        self.viewTop.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        self.viewTop.layer.shadowOpacity = 0.2
        self.viewTop.backgroundColor = nil
        self.viewTop.layer.backgroundColor =  UIColor.white.cgColor
        imgDriver.layer.cornerRadius = imgDriver.frame.height / 2
    }
    
    //MARK: - Custom method
    func setData(){
        btnEdit.setTitle("edit".localized, for: .normal)
        self.lblDriverName.text = data?.name
        self.lblDriverEditNAme.text = data?.name
        if (data?.profile ?? "") == "" {
            let char = ("\(data?.firstName?.first?.description ?? "")\(data?.lastName?.first?.description ?? "")")
            if char != ""{
                self.imgDriver.addInitials(first: char)
            }
        }else{
            imgDriver.subviews.forEach { view in
                view.removeFromSuperview()
            }
            let strUrl = "\(APIEnvironment.dispatcherDriverImageURL)\(data?.profile ?? "")"
            imgDriver.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgDriver.sd_setImage(with: URL(string: strUrl), placeholderImage: UIImage(named: "ic_userIcon"))
        }
        let rating: Double = Double(data?.driverRating ?? "0") ?? 0.0
        let numberOfRating: Int = data?.noOfDriverRated ?? 0
        lblRating.text = "\(rating) (\(numberOfRating))"
        var status = 0
        if data?.driverVehicle?.isAssing == 0{
            status = 0
            lblTruckType.isHidden = true
            lblTruckPlateHint.isHidden = true
            lblTractorPlateHint.isHidden = true
            lblTruckPlateHint.text = ""
            lblTractorPlateHint.text = ""
        }else{
            lblTruckType.isHidden = false
            lblTruckType.text = data?.driverVehicle?.truckType?.getName()
            lblTruckPlateHint.text = "\("Truck Plate".localized) : \(data?.driverVehicle?.trailerRegistrationNo ?? "")"
            lblTractorPlateHint.text = "\("Tractor Plate".localized) : \(data?.driverVehicle?.registrationNo ?? "")"
            lblTruckPlateHint.isHidden = false
            lblTractorPlateHint.isHidden = false
            status = 1
        }
        if data?.busy == 1{
            status = 2
        }
        if data?.blockStatus == "0"{
            status = 3
            viewEdit.isHidden = true
        }else{
            viewEdit.isHidden = false
        }
        setStatus(status)
    }
    
    func setStatus(_ status:Int){
        lblAvailable.isHidden = true
        lblAssigned.isHidden = true
        lblLoaded.isHidden = true
        lblInactive.isHidden = true
        switch status{
        case 1:
            lblAvailable.isHidden = false
            lblAvailable.text = "Available".localized
        case 0:
            lblAssigned.isHidden = false
            lblAssigned.text = "Not Assigned".localized
        case 2:
            lblLoaded.isHidden = false
            lblLoaded.text = "Loaded".localized
        case 3:
            lblInactive.isHidden = false
            lblInactive.text = "Inactive".localized
        default:break
        }
    }
    
    @IBAction func btnActionEdit(_ sender: UIButton) {
        if let clicked = clickEdit {
            clicked()
        }
    }
}
