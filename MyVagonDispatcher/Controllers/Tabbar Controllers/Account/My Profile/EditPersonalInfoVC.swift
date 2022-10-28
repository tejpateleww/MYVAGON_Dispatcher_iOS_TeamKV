//
//  EditPersonalInfoVC.swift
//  MyVagonDispatcher
//
//  Created by Harshit K on 15/03/22.
//

import UIKit
import SDWebImage

class EditPersonalInfoVC: BaseViewController {
    
    //MARK: - Propertise
    @IBOutlet weak var ImageViewProfile: UIImageView!
    @IBOutlet weak var textFieldFirstName: themeTextfield!
    @IBOutlet weak var TextFieldMobileNumber: themeTextfield!
    @IBOutlet weak var TextFieldCountryCode: themeTextfield!
    @IBOutlet weak var txtFieldLastName: themeTextfield!
    @IBOutlet weak var btnProfieImage: UIButton!
    @IBOutlet weak var btnSave: themeButton!
    @IBOutlet weak var imgAddIcon: UIImageView!
    @IBOutlet weak var txtEmail: themeTextfield!
    @IBOutlet weak var lblTitle: themeLabel!
    @IBOutlet weak var btnVarifyNumber: UIButton!
    
    var CountryCodeArray: [String] = ["+30"]
    let GeneralPicker = GeneralPickerView()
    var editPersonalInfoModel = EditPersonalInfoModel()
    var profileImage = ""
    var Iseditable = false
    var IsPhoneVerify = true
    var verifiedPhone = ""
    var editPersonViewModel = EditPersonViewModel()
    
    //MARK: - Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setLocalization()
    }
    
    //MARK: - Custom method
    func setUI(){
        self.TextFieldCountryCode.delegate = self
        self.addObserver()
        self.SetValue()
        self.setupDelegateForPickerView()
    }
    
    func addObserver(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "EditPersonalInfo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileEdit), name: NSNotification.Name(rawValue: "EditPersonalInfo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    @objc func changeLanguage(){
        self.setLocalization()
    }
    
    func setLocalization(){
        self.txtEmail.placeholder = "Email".localized
        self.textFieldFirstName.placeholder = "First_Name".localized
        self.txtFieldLastName.placeholder = "last_Name".localized
        self.TextFieldMobileNumber.placeholder = "MobileNumber".localized
        self.btnSave.setTitle("Save".localized, for: .normal)
        self.btnVarifyNumber.setImage(UIImage(named: "Verified"), for: .selected)
        self.btnVarifyNumber.setImage(UIImage(named: "Verify"), for: .normal)
    }
    
    func setupDelegateForPickerView() {
        GeneralPicker.dataSource = self
        GeneralPicker.delegate = self
        GeneralPicker.generalPickerDelegate = self
    }
    
    @objc func ProfileEdit(){
        Iseditable = true
        SetValue()
    }
    
    func SetValue() {
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: Iseditable ? "Edit Personal Info".localized : "Personal Info".localized, leftImage: NavItemsLeft.back.value, rightImages: Iseditable ? [NavItemsRight.none.value] : [NavItemsRight.none.value], isTranslucent: true)
        self.isProfileEdit(allow: Iseditable)
        self.btnSave.isHidden = !Iseditable
        self.imgAddIcon.isHidden = false
        self.lblTitle.text = Iseditable ? "Upload Profile Picture".localized : "Profile Picture".localized
        if (SingletonClass.sharedInstance.DispatcherProfileData?.profile ?? "") == ""{
            let char = ("\(SingletonClass.sharedInstance.DispatcherProfileData?.firstName?.first?.description ?? "")\(SingletonClass.sharedInstance.DispatcherProfileData?.LastName?.first?.description ?? "")")
            if char != ""{
                self.ImageViewProfile.addInitials(first: char )
            }
        }else{
            self.profileImage = (SingletonClass.sharedInstance.DispatcherProfileData?.profile ?? "")
            let StringURLForProfile = "\(APIEnvironment.DriverImageURL)\(SingletonClass.sharedInstance.DispatcherProfileData?.profile ?? "")"
            self.ImageViewProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.ImageViewProfile.sd_setImage(with: URL(string: StringURLForProfile), placeholderImage: UIImage(named: "ic_userIcon"))
        }
        self.textFieldFirstName.text = SingletonClass.sharedInstance.DispatcherProfileData?.firstName ?? ""
        self.txtFieldLastName.text = SingletonClass.sharedInstance.DispatcherProfileData?.LastName ?? ""
        self.TextFieldMobileNumber.text = SingletonClass.sharedInstance.DispatcherProfileData?.mobileNumber ?? ""
        self.verifiedPhone = SingletonClass.sharedInstance.DispatcherProfileData?.mobileNumber ?? ""
        self.btnVarifyNumber.isSelected = true
        self.TextFieldMobileNumber.delegate = self
        self.txtEmail.text = SingletonClass.sharedInstance.DispatcherProfileData?.email ?? ""
        if SingletonClass.sharedInstance.ProfileData.Reg_country_code != "" {
            self.TextFieldCountryCode.text = SingletonClass.sharedInstance.ProfileData.Reg_country_code
        } else {
            self.TextFieldCountryCode.text = self.CountryCodeArray.first
        }
    }
    
    func isProfileEdit(allow:Bool) {
        self.textFieldFirstName.isUserInteractionEnabled = allow
        self.TextFieldMobileNumber.isUserInteractionEnabled = allow
        self.TextFieldCountryCode.isUserInteractionEnabled = allow
        self.txtFieldLastName.isUserInteractionEnabled = allow
        self.ImageViewProfile.isUserInteractionEnabled = true
        self.btnProfieImage.isUserInteractionEnabled = true
        self.btnSave.isUserInteractionEnabled = allow
    }
    
    func PhoneVerify() {
        self.editPersonViewModel.editPersonalInfoVC = self
        let ReqModelForMobileVerify = MobileVerifyReqModel()
        ReqModelForMobileVerify.mobile_number = "\(TextFieldCountryCode.text ?? "")\(TextFieldMobileNumber.text ?? "")"
        self.editPersonViewModel.VerifyPhone(ReqModel: ReqModelForMobileVerify)
    }
    
    func checkChanges() -> Bool{
        if (SingletonClass.sharedInstance.DispatcherProfileData?.profile ?? "") != profileImage{
            return true
        }else if textFieldFirstName.text != SingletonClass.sharedInstance.DispatcherProfileData?.firstName ?? ""{
            return true
        }else if txtFieldLastName.text != SingletonClass.sharedInstance.DispatcherProfileData?.LastName ?? ""{
            return true
        }else if TextFieldMobileNumber.text != SingletonClass.sharedInstance.DispatcherProfileData?.mobileNumber ?? ""{
            return true
        }else if txtEmail.text != SingletonClass.sharedInstance.DispatcherProfileData?.email ?? ""{
            return true
        }else{
            return false
        }
    }
    
    func Validate() -> (Bool,String) {
        let checkFullName = textFieldFirstName.validatedText(validationType: ValidatorType.username(field: "First_Name".localized,MaxChar: 70))
        let checkLastName = txtFieldLastName.validatedText(validationType: ValidatorType.username(field: "First_Name".localized,MaxChar: 70))
        let checkMobileNumber = TextFieldMobileNumber.validatedText(validationType: ValidatorType.phoneNo(MinDigit: 10, MaxDigit: 15))
        if (!checkFullName.0){
            return checkFullName
        }else if (!checkLastName.0){
            return checkLastName
        }else if (!checkMobileNumber.0){
            return checkMobileNumber
        }else if ImageViewProfile.image == nil {
            return (false,"Please attach profile image".localized)
        }else if !btnVarifyNumber.isSelected{
            return (false,"Error_VerifyMobile".localized)
        }
        return (true,"")
    }
    
    private func popBack(){
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            Utilities.ShowAlertOfSuccess(OfMessage: "profileUpdateSucces".localized)
        })
    }
    
    //MARK: - IBAction method
    @IBAction func btnVarifyClick(_ sender: UIButton) {
        if !sender.isSelected {
            let checkMobileNumber = TextFieldMobileNumber.validatedText(validationType: ValidatorType.phoneNo(MinDigit: 10, MaxDigit: 10))
            if (!checkMobileNumber.0){
                Utilities.ShowAlertOfInfo(OfMessage: checkMobileNumber.1)
            } else {
                PhoneVerify()
            }
        }
    }
    
    @IBAction func btnProfileClick(_ sender: UIButton){
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            for i in self.ImageViewProfile.subviews{
                i.removeFromSuperview()
            }
            self.ImageViewProfile.contentMode = .scaleAspectFill
            self.ImageUploadAPI(arrImages: [image], documentType: .Profile)
        }
    }
    
    @IBAction func btnUpdateClick(_ sender: UIButton){
        let CheckValidation = Validate()
        if CheckValidation.0 {
            if checkChanges(){
                callEditPersonalInfoUpdateAPI()
            }else{
                self.popBack()
            }
        } else {
            Utilities.ShowAlertOfInfo(OfMessage: CheckValidation.1)
        }
    }
}

//MARK: - TextField delegate
extension EditPersonalInfoVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == TextFieldCountryCode {
            TextFieldCountryCode.inputView = GeneralPicker
            TextFieldCountryCode.inputAccessoryView = GeneralPicker.toolbar
            if let DummyFirst = CountryCodeArray.first(where: {$0 == TextFieldCountryCode.text ?? ""}) {
                let indexOfA = CountryCodeArray.firstIndex(of: DummyFirst) ?? 0
                GeneralPicker.selectRow(indexOfA, inComponent: 0, animated: false)
                self.GeneralPicker.reloadAllComponents()
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == TextFieldMobileNumber{
            if textField.text == verifiedPhone{
                btnVarifyNumber.isSelected = true
            }else{
                btnVarifyNumber.isSelected = false
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.TextFieldMobileNumber{
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 10, range: range, string: string)
            return CheckWritting
        }else if textField == self.txtFieldLastName{
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 70, range: range, string: string)
            return CheckWritting
        }else if textField == self.textFieldFirstName{
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 70, range: range, string: string)
            return CheckWritting
        }
        
        return true
    }
}

//MARK: - GeneralPickerViewDelegate Methods
extension EditPersonalInfoVC: GeneralPickerViewDelegate {
    
    func didTapDone() {
        let item = CountryCodeArray[GeneralPicker.selectedRow(inComponent: 0)]
        self.TextFieldCountryCode.text = item
        self.TextFieldCountryCode.resignFirstResponder()
    }
    
    func didTapCancel() {}
}

//MARK: - UIPickerViewDelegate Methods
extension EditPersonalInfoVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CountryCodeArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CountryCodeArray[row]
    }
}

//MARK: - WebService method
extension EditPersonalInfoVC{
    
    func callEditPersonalInfoUpdateAPI() {
        self.editPersonalInfoModel.VC =  self
        let reqModel = EditPersonalInfoReqModel()
        reqModel.firstName = textFieldFirstName.text
        reqModel.LastName = txtFieldLastName.text
        //        reqModel.country_code = TextFieldCountryCode.text
        reqModel.mobile_number = TextFieldMobileNumber.text
        reqModel.profile_image = profileImage
        self.editPersonalInfoModel.WebServiceForPersonalInfoUpdate(ReqModel: reqModel)
    }
    
    func ImageUploadAPI(arrImages:[UIImage],documentType:DocumentType) {
        self.editPersonalInfoModel.VC = self
        self.editPersonalInfoModel.WebServiceImageUpload(images: arrImages, uploadFor: documentType)
    }
}

