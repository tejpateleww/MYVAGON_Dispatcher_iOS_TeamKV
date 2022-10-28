//
//  AddDriverVC.swift
//  MyVagonDispatcher
//
//  Created by Harsh Dave on 26/01/22.
//

import UIKit
import SDWebImage

protocol Refresh{
    func refreshData()
}

class AddDriverVC: BaseViewController {
    
    //MARK: - Properties
    @IBOutlet weak var imgDriver: RoundedImageView!
    @IBOutlet weak var txtFirstName: themeTextfield!
    @IBOutlet weak var txtLastName: themeTextfield!
    @IBOutlet weak var txtMobileNumber: themeTextfield!
    @IBOutlet weak var txtEmail: themeTextfield!
    @IBOutlet weak var imgLicense: UIImageView!
    @IBOutlet weak var txtPassword: themeTextfield!
    @IBOutlet weak var imgIdentityProof: UIImageView!
    @IBOutlet weak var txtConfirmPassword: themeTextfield!
    @IBOutlet weak var lblIdentityProof: themeLabel!
    @IBOutlet weak var lblLicence: themeLabel!
    @IBOutlet weak var lblLicenceSubTitle: themeLabel!
    @IBOutlet weak var lblLiecnceBack: themeLabel!
    @IBOutlet weak var lblLicencebackSubtitle: themeLabel!
    @IBOutlet weak var lblUplodeProfilePhoto: themeLabel!
    @IBOutlet weak var btnAddDriver: themeButton!
    @IBOutlet weak var btnIdentityProof: UIButton!
    @IBOutlet weak var btnLicence: UIButton!
    @IBOutlet weak var btnLicenceBack: UIButton!
    @IBOutlet weak var btnProfileImage: UIButton!
    @IBOutlet weak var imgLicenceBack: UIImageView!
    @IBOutlet weak var viewMobileNumber: ThemeViewRounded!
    @IBOutlet weak var viewEmail: ThemeViewRounded!
    @IBOutlet weak var viewPassword: ThemeViewRounded!
    @IBOutlet weak var viewConfirmPassword: ThemeViewRounded!
    @IBOutlet weak var txtLicenseNumber: themeTextfield!
    @IBOutlet weak var txtLicenseExpiry: themeTextfield!
    @IBOutlet weak var txtCountryCode: themeTextfield!
    
    var imagselection = 0
    var selectedTextField : UITextField?
    let generalPicker = GeneralPickerView()
    var isProfileUpLoded = ""
    var isLicenseUpLoded = ""
    var isIdentityUpLoded = ""
    var licenceBack = ""
    var delegate : Refresh?
    var CountryCodeArray: [String] = ["+30"]
    var addDriverViewModel = AddDriverViewModel()
    var isFromEdit = false
    var isEditEnable = true
    var editData : DispaterDriver?
    //MARK: - LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "editprofile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileEdit), name: NSNotification.Name(rawValue: "editprofile"), object: nil)
    }
    //MARK: - Custom methods
    @objc func ProfileEdit(){
        self.isEditEnable = true
        self.seteditEnable()
        self.setUpNevigetionBar()
        self.setUpEditData()
    }
    
    func setupUI(){
        txtLicenseExpiry.addInputViewDatePicker(target: self, selector: #selector(btnDoneDatePickerClicked), PickerMode: .date, MinDate: true, MaxDate: false)
        self.setUpNevigetionBar()
        self.setLocalization()
        self.seteditEnable()
    }
    
    func setUpNevigetionBar(){
        if isFromEdit{
            self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: isEditEnable ? "edit_driver".localized : "driver_detail".localized, leftImage: NavItemsLeft.back.value , rightImages: isEditEnable ? [] : [NavItemsRight.editProfile.value] , isTranslucent: true)
        }else{
            setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Add_driver".localized, leftImage: NavItemsLeft.back.value, rightImages: [], isTranslucent: true, ShowShadow: true)
        }
    }
    
    func setLocalization(){
        self.lblUplodeProfilePhoto.text = "Upload Profile Picture".localized
        self.txtLastName.placeholder = "last_Name".localized
        self.txtFirstName.placeholder = "First_Name".localized
        self.txtMobileNumber.placeholder = "MobileNumber".localized
        self.txtEmail.placeholder = "Email".localized
        self.txtPassword.placeholder = "Password".localized
        self.txtConfirmPassword.placeholder = "ConfirmPassword".localized
        self.lblIdentityProof.text = "Identity Proof Document".localized
        self.lblLicence.text = "License Front".localized
        self.lblLicenceSubTitle.text = "licenceSubtitle".localized
        self.lblLiecnceBack.text = "License Back".localized
        self.lblLicencebackSubtitle.text = "licenceSubtitle".localized
        self.btnAddDriver.setTitle(isFromEdit ? "Save".localized : "Add_driver".localized, for: .normal)
        self.txtLicenseNumber.placeholder = "Enter license number".localized
        self.txtLicenseExpiry.placeholder = "Enter license expiry date".localized
    }
    
    func setupData(){
        self.txtMobileNumber.delegate = self
        self.txtLastName.delegate = self
        self.txtFirstName.delegate = self
        self.txtCountryCode.delegate = self
        self.generalPicker.dataSource = self
        self.generalPicker.delegate = self
        self.generalPicker.generalPickerDelegate = self
        self.txtCountryCode.text = self.CountryCodeArray.first
        if isFromEdit{
            self.setUpEditData()
        }
    }
    
    func setUpEditData(){
        txtFirstName.text = editData?.firstName
        txtLastName.text = editData?.lastName
        txtEmail.text = editData?.email
        isProfileUpLoded = editData?.profile ?? ""
        isIdentityUpLoded = editData?.driverVehicle?.idProof ?? ""
        isLicenseUpLoded = editData?.driverVehicle?.license ?? ""
        licenceBack = editData?.driverVehicle?.licenseBack ?? ""
        var strUrl = "\(APIEnvironment.dispatcherDriverImageURL)\(editData?.driverVehicle?.idProof ?? "")"
        imgIdentityProof.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgIdentityProof.sd_setImage(with: URL(string: strUrl), placeholderImage: UIImage(named: "ic_gallary"))
        strUrl = "\(APIEnvironment.dispatcherDriverImageURL)\(editData?.driverVehicle?.license ?? "")"
        imgLicense.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgLicense.sd_setImage(with: URL(string: strUrl), placeholderImage: UIImage(named: "ic_gallary"))
        strUrl = "\(APIEnvironment.dispatcherDriverImageURL)\(editData?.driverVehicle?.licenseBack ?? "")"
        imgLicenceBack.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgLicenceBack.sd_setImage(with: URL(string: strUrl), placeholderImage: UIImage(named: "ic_gallary"))
        txtLicenseNumber.text = editData?.licenceNumber
        txtLicenseExpiry.text = editData?.licenceExpiryDate
        txtMobileNumber.text = editData?.phone
        if (editData?.profile ?? "") == "" && !isEditEnable{
            let char = ("\(editData?.firstName?.first?.description ?? "")\(editData?.lastName?.first?.description ?? "")")
            if char != ""{
                self.imgDriver.addInitials(first: char)
            }
        }else{
            strUrl = "\(APIEnvironment.dispatcherDriverImageURL)\(editData?.profile ?? "")"
            imgDriver.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgDriver.sd_setImage(with: URL(string: strUrl), placeholderImage: UIImage(named: "ic_userIcon"))
        }
        if editData?.countryCode != "" {
            self.txtCountryCode.text = editData?.countryCode
        } else {
            self.txtCountryCode.text = self.CountryCodeArray.first
        }
    }
    
    func setImage(image: UIImage,name:String){
        switch imagselection{
        case 0:
            self.imgDriver.image = image
            self.isProfileUpLoded = name
        case 1:
            self.imgIdentityProof.image = image
            self.isIdentityUpLoded = name
        case 2:
            self.imgLicense.image = image
            self.isLicenseUpLoded = name
        case 3:
            self.imgLicenceBack.image = image
            self.licenceBack = name
        default:
            break
        }
    }
    
    func seteditEnable(){
        txtFirstName.isUserInteractionEnabled = isEditEnable
        txtLastName.isUserInteractionEnabled = isEditEnable
        btnProfileImage.isUserInteractionEnabled = isEditEnable
        btnLicence.isUserInteractionEnabled = isEditEnable
        btnIdentityProof.isUserInteractionEnabled = isEditEnable
        btnLicenceBack.isUserInteractionEnabled = isEditEnable
        viewEmail.isUserInteractionEnabled = !isFromEdit
        viewMobileNumber.isUserInteractionEnabled = !isFromEdit
        if isFromEdit{
            viewEmail.isHidden = isEditEnable
            viewMobileNumber.isHidden = isEditEnable
        }
        viewPassword.isHidden = isFromEdit
        viewConfirmPassword.isHidden = isFromEdit
        self.txtLicenseNumber.isUserInteractionEnabled = isEditEnable
        self.txtLicenseExpiry.isUserInteractionEnabled = isEditEnable
        self.btnAddDriver.isHidden = !isEditEnable
    }
    
    func validation() -> (Bool,String){
//        self.txtLicenseNumber.text = self.txtLicenseNumber.text?.trimmedString
        self.txtLastName.text = txtLastName.text?.trimmedString
        self.txtFirstName.text = txtFirstName.text?.trimmedString
        self.txtMobileNumber.text = txtMobileNumber.text?.trimmedString
        self.txtEmail.text = txtEmail.text?.trimmedString
        self.txtPassword.text = txtPassword.text?.trimmedString
        self.txtConfirmPassword.text = txtConfirmPassword.text?.trimmedString
//        let checkLicenseNumber = txtLicenseNumber.validatedText(validationType: ValidatorType.requiredField(field: "license number".localized))
        let checkFirstName = txtFirstName.validatedText(validationType: ValidatorType.username(field: "first_name".localized,MaxChar: 70))
        let checkLastName = txtLastName.validatedText(validationType: ValidatorType.username(field: "last_name".localized,MaxChar: 70))
        let checkMobileNumber = txtMobileNumber.validatedText(validationType: ValidatorType.phoneNo(MinDigit: 10, MaxDigit: 15))
        let checkEmail = txtEmail.validatedText(validationType: ValidatorType.email)
        let checkPassword = txtPassword.validatedText(validationType: ValidatorType.password(field: "password".localized))
        let checkConfirmPassword = txtConfirmPassword.validatedText(validationType: ValidatorType.requiredField(field: "confirm password".localized))
//        let checkLicenseExpiryDate = txtLicenseExpiry.validatedText(validationType: ValidatorType.requiredField(field: "license expiry date"))
        if (!checkFirstName.0){
            return checkFirstName
        } else if (!checkLastName.0){
            return checkLastName
        } else if (!checkEmail.0) && !isFromEdit{
            return checkEmail
        } else if (!checkMobileNumber.0) && !isFromEdit{
            return (false,"validNumberMSG".localized)
        }
//        else if !checkLicenseNumber.0{
//            return checkLicenseNumber
//        }else if (!checkLicenseExpiryDate.0){
//            return (checkLicenseExpiryDate.0,"Please_select_license_expiry_date".localized)
//        }
        else if(!checkPassword.0) && !isFromEdit{
            return (checkPassword.0,checkPassword.1)
        }else if(!checkConfirmPassword.0) && !isFromEdit{
            return (checkConfirmPassword.0,"Error_EnterConfirmPass".localized)
        }else if (txtPassword.text != txtConfirmPassword.text) && !isFromEdit{
            return (false,"Error_PassMatch".localized)
        }
//        else if isProfileUpLoded == ""{
//            return (false,"Please attach profile image".localized)
//        }
//        else if isIdentityUpLoded == ""{
//            return (false,"Please attach id proof document".localized)
//        }
//        else if isLicenseUpLoded == ""{
//            return (false,"Please_attach_license_front_image".localized)
//        }else if licenceBack == ""{
//            return (false,"Please_upload_drivers_license_back".localized)
//        }
        return (true,"")
    }
    
    func driverAdded(){
        delegate?.refreshData()
        navigationController?.popViewController(animated: true)
    }
    
    func openImagPicker(){
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            self.ImageUploadAPI(arrImages: [image], documentType: .Profile)
        }
    }
    
    @objc func btnDoneDatePickerClicked() {
        if let datePicker = self.txtLicenseExpiry.inputView as? UIDatePicker {
            datePicker.locale = Locale(identifier: UserDefaults.standard.string(forKey: LCLCurrentLanguageKey) ?? "el")
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormatterString.onlyDate.rawValue
            txtLicenseExpiry.text = formatter.string(from: datePicker.date)
        }
        self.txtLicenseExpiry.resignFirstResponder() // 2-5
    }
    
    //MARK: - UIButton Action methods
    @IBAction func btnActionAddDriver(_ sender: UIButton) {
        let validation = self.validation()
        if validation.0{
            self.saveDriverData()
        }else{
            Utilities.ShowAlertOfInfo(OfMessage: validation.1)
        }
    }
    
    @IBAction func btnActionLicenceBAck(_ sender: UIButton){
        self.imagselection = 3
        self.openImagPicker()
    }
    
    @IBAction func btnActionLicense(_ sender: UIButton){
        self.imagselection = 2
        self.openImagPicker()
    }
    
    @IBAction func btnActionProfile(_ sender: UIButton){
        self.imagselection = 0
        self.openImagPicker()
    }
    
    @IBAction func BtnActionIdentityProof(_ sender: UIButton){
        self.imagselection = 1
        self.openImagPicker()
    }
    
}

//MARK: - UITextFieldDelegate methods
extension AddDriverVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFirstName {
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 35, range: range, string: string)
            return CheckWritting
        }else  if textField == self.txtLastName{
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 35, range: range, string: string)
            return CheckWritting
        }else  if textField == self.txtMobileNumber{
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 10, range: range, string: string)
            return CheckWritting
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtCountryCode {
            selectedTextField = txtCountryCode
            txtCountryCode.inputView = generalPicker
            txtCountryCode.inputAccessoryView = generalPicker.toolbar
            if let DummyFirst = CountryCodeArray.first(where: {$0 == txtCountryCode.text ?? ""}) {
                let indexOfA = CountryCodeArray.firstIndex(of: DummyFirst) ?? 0
                generalPicker.selectRow(indexOfA, inComponent: 0, animated: false)
                self.generalPicker.reloadAllComponents()
            }
        }
    }
    
    func ImageUploadAPI(arrImages:[UIImage],documentType:DocumentType) {
        self.addDriverViewModel.VC = self
        self.addDriverViewModel.WebServiceImageUpload(images: arrImages, uploadFor: documentType)
    }
    
    func saveDriverData(){
        let reqModel = AddDriverReqModel()
        reqModel.firstName = txtFirstName.text
        reqModel.lastName = txtLastName.text
        reqModel.profileImage = isProfileUpLoded
        reqModel.idProof = isIdentityUpLoded
        reqModel.licenceBack = licenceBack
        reqModel.licence = isLicenseUpLoded
        reqModel.licenceNumber = self.txtLicenseNumber.text
        reqModel.licenceExpiryDate = self.txtLicenseExpiry.text
        self.addDriverViewModel.VC = self
        if !isFromEdit{
            reqModel.email = txtEmail.text
            reqModel.phone = txtMobileNumber.text
            reqModel.password = txtPassword.text
            self.addDriverViewModel.callApiToAddDriver(reqModel: reqModel)
        }else{
            reqModel.driverId = "\(editData?.id ?? 0)"
            self.addDriverViewModel.callWebServiceToUpdateDriver(reqModel: reqModel)
        }
    }
}
//MARK: - GeneralPickerView Delegate
extension AddDriverVC: GeneralPickerViewDelegate{
    
    func didTapCancel() {}
    
    func didTapDone() {
         if selectedTextField == txtCountryCode {
            let item = CountryCodeArray[generalPicker.selectedRow(inComponent: 0)]
            self.txtCountryCode.text = item
            self.txtCountryCode.resignFirstResponder()
        }
    }
    
}
extension AddDriverVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch selectedTextField{
        case txtCountryCode:
            return CountryCodeArray.count
        default:
            return 0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch selectedTextField{
        case txtCountryCode:
            return CountryCodeArray[row]
        default:
            return ""
        }
    }
}
