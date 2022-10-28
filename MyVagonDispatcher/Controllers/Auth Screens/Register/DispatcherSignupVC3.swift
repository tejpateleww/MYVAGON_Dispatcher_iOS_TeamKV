//
//  FreelancerDriverSignupVC3.swift
//  MyVagonDispatcher
//
//  Created by Admin on 26/07/21.
//

import UIKit

class DispatcherSignupVC3: BaseViewController {
    
    //MARK: - Properties
    @IBOutlet weak var TextFieldFirstName: themeTextfield!
    @IBOutlet weak var txtFieldLastName: themeTextfield!
    @IBOutlet weak var TextFieldCountryCode: themeTextfield!
    @IBOutlet weak var TextFieldMobileNumber: themeTextfield!
    @IBOutlet weak var TextFieldEmail: themeTextfield!
    @IBOutlet weak var TextFieldPassword: themeTextfield!
    @IBOutlet weak var TextFieldConfirmPassword: themeTextfield!
    @IBOutlet weak var BtnVerifyEmail: ThemeButtonVerify!
    @IBOutlet weak var BtnVerifyPhoneNumber: ThemeButtonVerify!
    @IBOutlet weak var btnJoin: themeButton!
    @IBOutlet weak var btnSignIn: themeButton!
    
    var signUpViewModel = SignUpViewModel()
    var CountryCodeArray: [String] = ["+30"]
    let GeneralPicker = GeneralPickerView()
    var IsPhoneVerify : Bool = false
    var IsEmailVerify : Bool = false
    var VerifiedEmail = ""
    var verifiedPhone = ""
    
    override func viewWillAppear(_ animated: Bool) {
        self.setLocalization()
    }
    
    //MARK: - Life-cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BtnVerifyPhoneNumber.titleLabel?.numberOfLines = 0
        self.BtnVerifyEmail.titleLabel?.numberOfLines = 0
        self.TextFieldFirstName.delegate = self
        self.TextFieldPassword.delegate = self
        self.TextFieldConfirmPassword.delegate = self
        self.TextFieldCountryCode.delegate = self
        self.TextFieldEmail.delegate = self
        self.TextFieldMobileNumber.delegate = self
        self.setupDelegateForPickerView()
        self.setValue()
        self.setNavigationBarInViewController(controller: self, naviColor: UIColor.white, naviTitle: "", leftImage: NavItemsLeft.back.value, rightImages: [], isTranslucent: true, setSegment: true)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    @objc func changeLanguage(){
        self.setLocalization()
    }
    
    //MARK: - Custom Methods
    func setLocalization() {
        self.TextFieldFirstName.placeholder = "First_Name".localized
        self.txtFieldLastName.placeholder = "last_Name".localized
        self.TextFieldMobileNumber.placeholder = "MobileNumber".localized
        self.TextFieldEmail.placeholder = "Work_Email".localized
        self.TextFieldPassword.placeholder = "Password".localized
        self.TextFieldConfirmPassword.placeholder = "ConfirmPassword".localized
        self.btnJoin.setTitle("JoinForFree!".localized, for: .normal)
        self.btnSignIn.setTitle("Sign In".localized, for: .normal)
        self.BtnVerifyPhoneNumber.setImage(UIImage(named: "Verified"), for: .selected)
        self.BtnVerifyPhoneNumber.setImage(UIImage(named: "Verify"), for: .normal)
        self.BtnVerifyEmail.setImage(UIImage(named: "Verified"), for: .selected)
        self.BtnVerifyEmail.setImage(UIImage(named: "Verify"), for: .normal)
    }
    
    func setValue() {
        self.TextFieldFirstName.text = SingletonClass.sharedInstance.DispetcherRegisterData.firstName
        self.txtFieldLastName.text = SingletonClass.sharedInstance.DispetcherRegisterData.lastName
        self.TextFieldMobileNumber.text = SingletonClass.sharedInstance.DispetcherRegisterData.phone
        self.TextFieldEmail.text = SingletonClass.sharedInstance.DispetcherRegisterData.email
        self.TextFieldPassword.text = SingletonClass.sharedInstance.DispetcherRegisterData.password
        self.TextFieldConfirmPassword.text = SingletonClass.sharedInstance.DispetcherRegisterData.password
        if SingletonClass.sharedInstance.DispetcherRegisterData.phone != "" {
            self.BtnVerifyPhoneNumber.isSelected = true
            self.verifiedPhone = SingletonClass.sharedInstance.DispetcherRegisterData.phone
        }
        if SingletonClass.sharedInstance.DispetcherRegisterData.email != "" {
            self.BtnVerifyEmail.isSelected = true
            self.VerifiedEmail = SingletonClass.sharedInstance.DispetcherRegisterData.email
        }
        if SingletonClass.sharedInstance.DispetcherRegisterData.countryCode != "" {
            self.TextFieldCountryCode.text = SingletonClass.sharedInstance.DispetcherRegisterData.countryCode
        } else {
            self.TextFieldCountryCode.text = self.CountryCodeArray.first
        }
    }
    
    func setupDelegateForPickerView() {
        GeneralPicker.dataSource = self
        GeneralPicker.delegate = self
        GeneralPicker.generalPickerDelegate = self
    }
    
    func phoneVerify() {
        self.signUpViewModel.freelancerDriverSignupVC3 = self
        let ReqModelForMobileVerify = MobileVerifyReqModel()
        ReqModelForMobileVerify.mobile_number = "\(TextFieldCountryCode.text ?? "")\(TextFieldMobileNumber.text ?? "")"
        self.signUpViewModel.VerifyPhone(ReqModel: ReqModelForMobileVerify)
    }
    
    func emailVerify() {
        self.signUpViewModel.freelancerDriverSignupVC3 = self
        let ReqModelForEmailVerify = EmailVerifyReqModel()
        ReqModelForEmailVerify.email = TextFieldEmail.text ?? ""
        self.signUpViewModel.VerifyEmail(ReqModel: ReqModelForEmailVerify)
    }
    
    func validate() -> (Bool,String) {
        self.TextFieldFirstName.text = TextFieldFirstName.text?.trimmedString
        self.txtFieldLastName.text = txtFieldLastName.text?.trimmedString
        self.TextFieldMobileNumber.text = self.TextFieldMobileNumber.text?.trimmedString
        self.TextFieldEmail.text = self.TextFieldEmail.text?.trimmedString
        self.TextFieldPassword.text = self.TextFieldPassword.text?.trimmedString
        self.TextFieldConfirmPassword.text = self.TextFieldConfirmPassword.text?.trimmedString
        let checkFirstName = TextFieldFirstName.validatedText(validationType: ValidatorType.username(field: "first_name".localized,MaxChar: 70))
        let checkLastName = txtFieldLastName.validatedText(validationType: ValidatorType.username(field: "last_name".localized,MaxChar: 70))
        let checkMobileNumber = TextFieldMobileNumber.validatedText(validationType: ValidatorType.phoneNo(MinDigit: 10, MaxDigit: 15))
        let checkEmail = TextFieldEmail.validatedText(validationType: ValidatorType.email)
        let checkPassword = TextFieldPassword.validatedText(validationType: ValidatorType.password(field: "password".localized))
        let checkConfirmPassword = TextFieldConfirmPassword.validatedText(validationType: ValidatorType.requiredField(field: "confirm password".localized))
        if (!checkFirstName.0){
            return checkFirstName
        } else if (!checkLastName.0){
            return checkLastName
        } else if (!checkEmail.0){
            return checkEmail
        } else if (!checkMobileNumber.0){
            return checkMobileNumber
        } else if(!checkPassword.0){
            return (checkPassword.0,checkPassword.1)
        }else if(!checkConfirmPassword.0){
            return (checkConfirmPassword.0,"Error_EnterConfirmPass".localized)
        }else if TextFieldPassword.text != TextFieldConfirmPassword.text{
            return (false,"Error_PassMatch".localized)
        } else if !BtnVerifyPhoneNumber.isSelected {
            return (false,"Error_VerifyMobile".localized)
        } else if !BtnVerifyEmail.isSelected {
            return (false,"Error_VerifyEmail".localized)
        }
        return (true,"")
    }
    
    //MARK: - IBAction Methods
    @IBAction func btnActionEmailVerify(_ sender: UIButton) {
        if sender.isSelected == false {
            let checkEmail = TextFieldEmail.validatedText(validationType: ValidatorType.email)
            if (!checkEmail.0){
                Utilities.ShowAlertOfInfo(OfMessage: checkEmail.1)
            } else {
                emailVerify()
            }
        }
    }
    
    @IBAction func btnActionMobileVerify(_ sender: UIButton) {
        if sender.isSelected == false {
            let checkMobileNumber = TextFieldMobileNumber.validatedText(validationType: ValidatorType.phoneNo(MinDigit: 10, MaxDigit: 10))
            if (!checkMobileNumber.0){
                Utilities.ShowAlertOfInfo(OfMessage: checkMobileNumber.1)
            } else {
                phoneVerify()
            }
        }
    }
    
    @IBAction func btnSignInAction(_ sender: Any) {
        appDel.NavigateToLogin()
    }
    
    @IBAction func btnJoinForFreeAction(_ sender: Any) {
        let CheckValidation = validate()
        if CheckValidation.0 {
            SingletonClass.sharedInstance.DispetcherRegisterData.firstName = TextFieldFirstName.text ?? ""
            SingletonClass.sharedInstance.DispetcherRegisterData.lastName = txtFieldLastName.text ?? ""
            SingletonClass.sharedInstance.DispetcherRegisterData.email = TextFieldEmail.text ?? ""
            SingletonClass.sharedInstance.DispetcherRegisterData.phone = TextFieldMobileNumber.text ?? ""
            SingletonClass.sharedInstance.DispetcherRegisterData.password = TextFieldPassword.text ?? ""
            UserDefault.SetRegiterData()
            UserDefault.setUserData()
            UserDefault.synchronize()
            UserDefault.setValue(0, forKey: UserDefaultsKey.UserDefaultKeyForRegister.rawValue)
            let RegisterMainVC = self.navigationController?.viewControllers.last as! RegisterAllInOneViewController
            let x = self.view.frame.size.width * 1
            RegisterMainVC.MainScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
            RegisterMainVC.viewDidLayoutSubviews()
//            let controller = AppStoryboard.Auth.instance.instantiateViewController(withIdentifier: CompanyDetailsVC.storyboardID) as! CompanyDetailsVC
//            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            Utilities.ShowAlertOfInfo(OfMessage: CheckValidation.1)
        }
    }
}

//MARK: - UITextFieldDelegate Methods
extension DispatcherSignupVC3: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            if textField == TextFieldEmail {
                if textField.text == VerifiedEmail {
                    BtnVerifyEmail.isSelected = true
                } else {
                    BtnVerifyEmail.isSelected = false
                }
            } else if textField == TextFieldMobileNumber {
                if textField.text == verifiedPhone {
                    BtnVerifyPhoneNumber.isSelected = true
                } else {
                    BtnVerifyPhoneNumber.isSelected = false
                }
            }
        }
    }
    
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == TextFieldPassword {
            if textField.text == "" {
                if (string == " ") {
                    return false
                }
                return true
            } else {
                return true
            }
        } else if textField == TextFieldConfirmPassword {
            if textField.text == "" {
                if (string == " ") {
                    return false
                }
                return true
            } else {
                return true
            }
        } else if textField == TextFieldMobileNumber {
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 10, range: range, string: string)
            return CheckWritting
        }  else if textField == TextFieldPassword {
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 20, range: range, string: string)
            return CheckWritting
        } else if textField == TextFieldConfirmPassword {
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 20, range: range, string: string)
            return CheckWritting
        }else if textField == TextFieldFirstName{
            if let _ = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) {
                return false
            } else {
                return true
            }
        }else if textField == TextFieldEmail{
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 256, range: range, string: string)
            return CheckWritting
        }
        return true
    }
}

//MARK: - GeneralPickerViewDelegate Methods
extension DispatcherSignupVC3: GeneralPickerViewDelegate {
    
    func didTapDone() {
        let item = CountryCodeArray[GeneralPicker.selectedRow(inComponent: 0)]
        self.TextFieldCountryCode.text = item
        self.TextFieldCountryCode.resignFirstResponder()
    }
    
    func didTapCancel() {}
}

//MARK: - UIPickerViewDelegate Methods
extension DispatcherSignupVC3 : UIPickerViewDelegate, UIPickerViewDataSource {
    
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
