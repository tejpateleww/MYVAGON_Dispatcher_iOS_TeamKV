//
//  VehiclesTableViewCell.swift
//  MyVagonDispatcher
//
//  Created by Harsh Dave on 25/01/22.
//

import UIKit

class VehiclesTableViewCell: UITableViewCell {

    //MARK: - Propertise
    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var lblTruckTypeHint: themeLabel!
    @IBOutlet weak var lblTruckType: themeLabel!
    @IBOutlet weak var lblCargoHint: themeLabel!
    @IBOutlet weak var lblCargo: themeLabel!
    @IBOutlet weak var lblTruckPlateHint: themeLabel!
    @IBOutlet weak var lblTruckPlateNumber: themeLabel!
    @IBOutlet weak var lblTruckWeightHint: themeLabel!
    @IBOutlet weak var lblTruckWeight: themeLabel!
    
    var data : TruckList?
    
    //MARK: - LifeCycle method
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setLocalization()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setLocalization(){
        lblTruckTypeHint.text = "Truck Type".localized
        lblCargoHint.text = "Cargo Load Capacity".localized
        lblTruckPlateHint.text = "truck_plate_number".localized
        lblTruckWeightHint.text = "Overall Truck Weight".localized
    }
    
    func setData(){
        if let truck = SingletonClass.sharedInstance.TruckTypeList?.first(where: {$0.id == data?.truckTypeId?.id ?? 0}){
            self.lblTruckType.text = truck.getName()
        }
        lblCargo.text = "---"
        lblTruckWeight.text = "---"
        for i in SingletonClass.sharedInstance.TruckunitList ?? []{
            if i.id == data?.cargoLoadCapacityUnit?.id{
                lblCargo.text = "\(data?.cargoLoadCapacity ?? "0") \(i.getName())"
            }
            if i.id == data?.overallTruckWeightUnit?.id{
                lblTruckWeight.text = "\(data?.overallTruckWeight ?? "0") \(i.getName())"
            }
        }
        self.lblTruckPlateNumber.text = data?.registrationNo
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //viewContainer is the parent of viewContents
        //viewContents contains all the UI which you want to show actually.
        self.viewContents.layoutIfNeeded()
        self.viewContents.layer.cornerRadius = 15
        self.viewContents.layer.masksToBounds = true

        let bezierPath = UIBezierPath.init(roundedRect: self.viewContents.bounds, cornerRadius: 15)
        self.viewContents.layer.shadowPath = bezierPath.cgPath
        self.viewContents.layer.masksToBounds = false
        self.viewContents.layer.shadowColor = UIColor.black.cgColor
        self.viewContents.layer.shadowRadius = 3.0
        self.viewContents.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        self.viewContents.layer.shadowOpacity = 0.3

        // sending viewContainer color to the viewContents.
       // let backgroundCGColor =
        //You can set your color directly if you want by using below two lines. In my case I'm copying the color.
        self.viewContents.backgroundColor = nil
        self.viewContents.layer.backgroundColor =  UIColor.white.cgColor

       // self.tblMultipleLocation.contentInset = UIEdgeInsets(top: -11, left: 0, bottom: 0, right: 0)
      }
    
}
