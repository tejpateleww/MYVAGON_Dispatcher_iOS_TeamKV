//
//  Payments.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 21/02/22.
//

import UIKit
import SafariServices
class PaymentsVC: BaseViewController {
    
    // MARK: - Properties
    @IBOutlet weak var redioBtnCash: UIButton!
    @IBOutlet weak var redioBtnBank: UIButton!
    @IBOutlet weak var redioBtnBoth: UIButton!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var imgCash: UIImageView!
    @IBOutlet weak var imgBank: UIImageView!
    @IBOutlet weak var imgBoth: UIImageView!
    @IBOutlet weak var btnSave: themeButton!
    @IBOutlet weak var txtIBAN: themeTextfield!
    @IBOutlet weak var txtAccountNumber: themeTextfield!
    @IBOutlet weak var txtBankName: themeTextfield!
    @IBOutlet weak var txtCountry: themeTextfield!
    @IBOutlet weak var lblCash: UILabel!
    @IBOutlet weak var lblBank: UILabel!
    @IBOutlet weak var lblBoth: UILabel!
    @IBOutlet weak var lblContrect: UILabel!
    @IBOutlet weak var btnTermsAndCondition: UIButton!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var viewBottum: UIView!
    
    var selectedPaymentMode = "0"
    var paymentViewModel = PaymentViewModel()
    var paymentDetailData : PaymentDetailData?
    var registerViewModel = RegistrationViewModel()
    var isFromEdit = false
    
    // MARK: - LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setLocalization()
    }
    
    // MARK: - Custom methods
    @objc func changeLanguage(){
        self.setLocalization()
    }
    
    func setLocalization(){
        self.lblBank.text = "Bank".localized
        self.lblCash.text = "Cash".localized
        self.lblBoth.text = "Both".localized
        self.txtIBAN.placeholder = "IBAN".localized
        self.txtBankName.placeholder = "Bank Name".localized
        self.txtAccountNumber.placeholder = "acccount number".localized
        self.txtCountry.placeholder = "Country".localized
        self.btnSave.setTitle(!isFromEdit ? "Register".localized:"Save".localized, for: .normal)
        self.lblContrect.text = "terms&conditionMsg".localized
        self.btnTermsAndCondition.setTitle("Te  rms and Conditions".localized, for: .normal)
    }
    
    func prepareView(){
//        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Payments".localized, leftImage: NavItemsLeft.back.value, rightImages: isFromEdit ? [NavItemsRight.editPaymentDetails.value] : [NavItemsRight.none.value], isTranslucent: true)
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Payments".localized, leftImage: NavItemsLeft.back.value, rightImages: isFromEdit ? [NavItemsRight.none.value] : [NavItemsRight.none.value], isTranslucent: true)
        viewBottum.isHidden = isFromEdit
        isProfileEdit(allow: !isFromEdit)
        btnSave.isHidden = isFromEdit
        self.setupUI()
        isFromEdit ? self.setupDataAfterAPI() : self.setRegData()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "EditPaymentsDetails"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileEdit), name: NSNotification.Name(rawValue: "EditPaymentsDetails"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    @objc func ProfileEdit(){
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Payments".localized, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true)
        isProfileEdit(allow: true)
        btnSave.isHidden = false
    }
    
    func isProfileEdit(allow:Bool) {
        redioBtnCash.isUserInteractionEnabled = allow
        redioBtnBank.isUserInteractionEnabled = allow
        redioBtnBoth.isUserInteractionEnabled = allow
        txtIBAN.isUserInteractionEnabled = allow
        txtAccountNumber.isUserInteractionEnabled = allow
        txtBankName.isUserInteractionEnabled = allow
    }
    
    func previewDocument(strURL : String){
        guard let url = URL(string: strURL) else {return}
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    func setupUI(){
        self.redioBtnBank.setTitle("", for: .normal)
        self.redioBtnCash.setTitle("", for: .normal)
        self.detailStackView.isHidden = true
        txtCountry.text = "Greece".localized
        txtCountry.isUserInteractionEnabled = false
        // hide terms and condition
        self.viewBottum.isHidden = true
    }
    
    func setRegData(){
        self.selectedPaymentMode = SingletonClass.sharedInstance.DispetcherRegisterData.paymentType != "" ? SingletonClass.sharedInstance.DispetcherRegisterData.paymentType : "0"
        if selectedPaymentMode != "0"{
            self.txtIBAN.text = SingletonClass.sharedInstance.DispetcherRegisterData.iban
            self.txtAccountNumber.text = SingletonClass.sharedInstance.DispetcherRegisterData.accountNumber
            self.txtBankName.text = SingletonClass.sharedInstance.DispetcherRegisterData.bankName
        }
        self.setRedioBtn(selectedPaymentMode)
    }
    
    func setRedioBtn(_ mode: String){
        ///o = case 1 = Bank 2 = Both
        self.selectedPaymentMode = mode
        self.redioBtnCash.isSelected = false
        self.redioBtnBank.isSelected = false
        self.redioBtnBoth.isSelected = false
        self.imgCash.image = UIImage(named: "ic_radio_unselected")
        self.imgBank.image = UIImage(named: "ic_radio_unselected")
        self.imgBoth.image = UIImage(named: "ic_radio_unselected")
        switch selectedPaymentMode{
        case "0":
            self.redioBtnCash.isSelected = true
            self.imgCash.image = UIImage(named: "ic_radio_selected")
            break
        case "1":
            self.redioBtnBank.isSelected = true
            self.imgBank.image = UIImage(named: "ic_radio_selected")
            break
        case "2":
            self.redioBtnBoth.isSelected = true
            self.imgBoth.image = UIImage(named: "ic_radio_selected")
            break
        default:
            self.redioBtnCash.isSelected = true
            self.imgCash.image = UIImage(named: "ic_radio_selected")
        }
        self.setView(view: detailStackView, hidden: self.redioBtnCash.isSelected)
    }
    
    func setupDataAfterAPI(){
        self.selectedPaymentMode = "\(SingletonClass.sharedInstance.DispatcherProfileData?.paymentType ?? 0)"
        if selectedPaymentMode != "0"{
            self.txtIBAN.text = SingletonClass.sharedInstance.DispatcherProfileData?.iban
            self.txtAccountNumber.text = SingletonClass.sharedInstance.DispatcherProfileData?.accountNumber
            self.txtBankName.text = SingletonClass.sharedInstance.DispatcherProfileData?.bankName
        }
        self.setRedioBtn(selectedPaymentMode)
    }
    
    func setView(view: UIView, hidden: Bool) {
        view.alpha = hidden ? 0 : 1
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        }, completion: { _ in
            view.alpha = 1
        })
    }
    
    func Validate() -> (Bool,String) {
//        if !btnCheckBox.isSelected && !isFromEdit{
//            return(false,"Accept Terms and Condition".localized)
//        }
        if(self.selectedPaymentMode != "0"){
            self.txtIBAN.text = self.txtIBAN.text?.trimmedString
            self.txtAccountNumber.text = self.txtAccountNumber.text?.trimmedString
            self.txtBankName.text = self.txtBankName.text?.trimmedString
            self.txtCountry.text = self.txtCountry.text?.trimmedString
            let checkIBAN = self.txtIBAN.validatedText(validationType: ValidatorType.requiredField(field: "IBAN"))
            let checkAccount = self.txtAccountNumber.validatedText(validationType: ValidatorType.requiredField(field: "acccount number".localized))
            let checkBank = self.txtBankName.validatedText(validationType: ValidatorType.requiredField(field: "bank name".localized))
            let checkCountry = self.txtCountry.validatedText(validationType: ValidatorType.requiredField(field: "country"))
            if (!checkIBAN.0){
                return (checkIBAN.0,checkIBAN.1)
            }else if (!checkAccount.0){
                return (checkAccount.0,checkAccount.1)
            }else if (!checkBank.0){
                return (checkBank.0,checkBank.1)
            }else if (!checkCountry.0){
                return (checkCountry.0,checkCountry.1)
            }
        }
        return (true,"")
    }
    
    func checkChanges() -> Bool{
        if self.selectedPaymentMode != "\(SingletonClass.sharedInstance.DispatcherProfileData?.paymentType ?? 0)" {
            return true
        }
        if selectedPaymentMode != "0"{
            if self.txtIBAN.text != SingletonClass.sharedInstance.DispatcherProfileData?.iban ?? ""{
                return true
            }else if self.txtAccountNumber.text != SingletonClass.sharedInstance.DispatcherProfileData?.accountNumber ?? ""{
                return true
            }else if self.txtBankName.text != SingletonClass.sharedInstance.DispatcherProfileData?.bankName ?? ""{
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    private func popBack(){
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            Utilities.ShowAlertOfSuccess(OfMessage: "profileUpdateSucces".localized)
        })
    }
    
    func saveData(){
        SingletonClass.sharedInstance.DispetcherRegisterData.paymentType = self.selectedPaymentMode
        if selectedPaymentMode != "0"{
            SingletonClass.sharedInstance.DispetcherRegisterData.iban = self.txtIBAN.text ?? ""
            SingletonClass.sharedInstance.DispetcherRegisterData.accountNumber = self.txtAccountNumber.text ?? ""
            SingletonClass.sharedInstance.DispetcherRegisterData.bankName = self.txtBankName.text ?? ""
        }else{
            SingletonClass.sharedInstance.DispetcherRegisterData.iban = ""
            SingletonClass.sharedInstance.DispetcherRegisterData.accountNumber = ""
            SingletonClass.sharedInstance.DispetcherRegisterData.bankName = ""
        }
        UserDefault.SetRegiterData()
        UserDefault.synchronize()
        self.callRegisterDriver()
    }
    
    // MARK: - IBaAtion methods
    @IBAction func btnCashAction(_ sender: Any) {
        self.setRedioBtn("0")
    }
    
    @IBAction func btnBnakAction(_ sender: Any) {
        self.setRedioBtn("1")
    }
    
    @IBAction func btnBothAction(_ sender: Any) {
        self.setRedioBtn("2")
    }
    
    @IBAction func btnTermsAndConditionClicked(_ sender: Any) {
        btnCheckBox.isSelected = !btnCheckBox.isSelected
    }
    
    @IBAction func btnViewTermsAdnConditionClick(_ sender: Any) {
        let Link = SingletonClass.sharedInstance.initResModel?.termsAndCondition ?? ""
        self.previewDocument(strURL: Link)
    }
    
    
    @IBAction func btnSaveAction(_ sender: Any) {
        let CheckValidation = Validate()
        if CheckValidation.0 {
            if isFromEdit {
                if checkChanges(){
                    self.callPaymentDetailUpdateAPI()
                }else{
                    self.popBack()
                }
            }else{
                self.saveData()
            }
        } else {
            Utilities.ShowAlertOfInfo(OfMessage: CheckValidation.1)
        }
    }
}

//MARK: - API method
extension PaymentsVC{
    
    func callPaymentDetailUpdateAPI() {
        self.paymentViewModel.VC =  self
        let reqModel = PaymentDetailUpdateReqModel()
        reqModel.payment_type = selectedPaymentMode
        if selectedPaymentMode != "0"{
            reqModel.iban = txtIBAN.text
            reqModel.account_number = txtAccountNumber.text
            reqModel.bank_name = txtBankName.text
        }else{
            reqModel.iban = ""
            reqModel.account_number = ""
            reqModel.bank_name = ""
        }
        reqModel.country = txtCountry.text
        self.paymentViewModel.WebServiceForPaymentDeatilUpdate(ReqModel: reqModel)
    }
    
    func callRegisterDriver(){
        let reqModel = RegistrationReqModel()
        reqModel.setData(data: SingletonClass.sharedInstance.DispetcherRegisterData)
        registerViewModel.paymantVC = self
        registerViewModel.callWebServicforDispatcherDriverRegister(reqModel: reqModel)
    }
}
