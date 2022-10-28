//
//  RegisterTruckCell.swift
//  MyVagonDispatcher
//
//  Created by Tej P on 02/03/22.
//

import UIKit

class RegisterTruckCell: UITableViewCell {
    
    //MARK: - Propertise
    @IBOutlet weak var vWContainer: UIView!
    @IBOutlet weak var imgDelete: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblTitleTruckType: themeLabel!
    @IBOutlet weak var lblTitleTruckNumberPlate: themeLabel!
    @IBOutlet weak var lbltruckType: themeLabel!
    @IBOutlet weak var lblTruckNumber: themeLabel!
    @IBOutlet weak var imgDefault: UIImageView!
    
    var btnDeleteClick : (() -> ())?
    var btnDefaultAction : (() -> ())?
    var data : TractorList?
    //MARK: - Life cycle method
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setLocalization()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Custom method
    func setLocalization(){
        lblTitleTruckType.text = "tractor_brand".localized
        lblTitleTruckNumberPlate.text = "Tractor licence plat number".localized
    }
    
    func setupUI(){
        self.vWContainer.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.vWContainer.layer.masksToBounds = false
        self.vWContainer.layer.shadowRadius = 4
        self.vWContainer.layer.borderColor = UIColor.black.cgColor
        self.vWContainer.layer.cornerRadius = 15
        self.vWContainer.layer.shadowOpacity = 0.1
    }
    
    func setData(){
        self.lblTruckNumber.text = data?.registrationNo
        if let brand = SingletonClass.sharedInstance.TruckBrandList?.first(where: {$0.id == data?.brandId?.id ?? 0}){
            self.lbltruckType.text = brand.getName()
        }
    }
    
    //MARK: - IBAction method
    @IBAction func btnDefaultClick(_ sender: Any) {
        if let click = self.btnDefaultAction{
            click()
        }
    }
    @IBAction func btnDeleteAction(_ sender: Any) {
        if let click = self.btnDeleteClick{
            click()
        }
    }
}
