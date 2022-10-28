//
//  CompanyDetailsVC.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 05/07/22.
//

import UIKit
import GoogleMaps
import GooglePlaces

class CompanyDetailsVC: BaseViewController {
    
    //MARK: - Properties
    @IBOutlet weak var txtCompanyName: themeTextfield!
    @IBOutlet weak var txtAddress: themeTextfield!
    @IBOutlet weak var txtCity: themeTextfield!
    @IBOutlet weak var txtState: themeTextfield!
    @IBOutlet weak var txtCountry: themeTextfield!
    @IBOutlet weak var txtPostalCode: themeTextfield!
    @IBOutlet weak var txtCompanyVATNumber: themeTextfield!
    @IBOutlet weak var txtPhoneNumber: themeTextfield!
    @IBOutlet weak var txtCountryCode: themeTextfield!
    @IBOutlet weak var btnRegister: themeButton!
    
    let generalPicker = GeneralPickerView()
    var selectedTextField : UITextField?
    var selectedStateID = 0
    var isFromEdit = false
    var isEditEnable = true
    var CountryCodeArray: [String] = ["+30"]
    var updateDetailViewModel = UpdateCompanyViewModel()
    //MARK: - Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setLocalization()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "editprofile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileEdit), name: NSNotification.Name(rawValue: "editprofile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    //MARK: - Custom method
    @objc func changeLanguage(){
        self.setLocalization()
    }
    
    func prepareView(){
        if isFromEdit{
            self.isEditEnable = false
            self.setEditValue()
        }else{
            self.setValue()
        }
        self.setUpData()
        self.setUpUI()
        self.enableEdit()
        self.setupNavigationBar()
    }
    
    func setUpData(){
        self.txtAddress.delegate = self
        self.txtState.delegate = self
        self.generalPicker.dataSource = self
        self.generalPicker.delegate = self
        self.txtPhoneNumber.delegate = self
        self.generalPicker.generalPickerDelegate = self
        self.txtCompanyName.delegate = self
        self.txtCompanyVATNumber.delegate = self
        self.txtPostalCode.delegate = self
        self.txtCountryCode.delegate = self
    }
    
    func setupNavigationBar(){
        if isFromEdit{
            if isEditEnable {
                setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Edit_Company_Detail".localized, leftImage: NavItemsLeft.back.value, rightImages: [], isTranslucent: true, ShowShadow: true)
            }else{
                setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Company_Detail".localized, leftImage: NavItemsLeft.back.value, rightImages: [], isTranslucent: true, ShowShadow: true)
            }
        }
    }
    
    func setLocalization(){
        txtCompanyName.placeholder = "Company_name".localized
        txtAddress.placeholder = "Address".localized
        txtCity.placeholder = "City".localized
        txtState.placeholder = "State".localized
//        txtCountry.placeholder = "".localized
        txtPostalCode.placeholder = "Postal_code".localized
        txtCompanyVATNumber.placeholder = "Company_VAT_number".localized
        txtPhoneNumber.placeholder = "MobileNumber".localized
        btnRegister.setTitle("Next".localized, for: .normal)
    }
    
    func setValue(){
        txtCompanyName.text = SingletonClass.sharedInstance.DispetcherRegisterData.companyName
        txtAddress.text = SingletonClass.sharedInstance.DispetcherRegisterData.address
        txtCity.text = SingletonClass.sharedInstance.DispetcherRegisterData.city
        let index = Int(SingletonClass.sharedInstance.DispetcherRegisterData.state)
        if let DummyFirst = SingletonClass.sharedInstance.stateList?.firstIndex(where: {$0.id == index ?? 0}){
            txtState.text = SingletonClass.sharedInstance.stateList?[DummyFirst].getName()
            selectedStateID = index ?? 0
        }
        txtCountry.text = "Greece".localized
        txtPostalCode.text = SingletonClass.sharedInstance.DispetcherRegisterData.postCode
        txtCompanyVATNumber.text = SingletonClass.sharedInstance.DispetcherRegisterData.vat
        txtPhoneNumber.text = SingletonClass.sharedInstance.DispetcherRegisterData.companyPhone
        if SingletonClass.sharedInstance.DispetcherRegisterData.countryCode != "" {
            self.txtCountryCode.text = SingletonClass.sharedInstance.DispetcherRegisterData.countryCode
        } else {
            self.txtCountryCode.text = self.CountryCodeArray.first
        }
    }
    
    func setEditValue(){
        txtCompanyName.text = SingletonClass.sharedInstance.DispatcherProfileData?.companyName
        txtAddress.text = SingletonClass.sharedInstance.DispatcherProfileData?.address
        txtCity.text = SingletonClass.sharedInstance.DispatcherProfileData?.city
        let index = SingletonClass.sharedInstance.DispatcherProfileData?.state ?? 0
        if let DummyFirst = SingletonClass.sharedInstance.stateList?.firstIndex(where: {$0.id == index}){
            txtState.text = SingletonClass.sharedInstance.stateList?[DummyFirst].getName()
            selectedStateID = index
        }
        txtCountry.text = "Greece".localized
        txtPostalCode.text = SingletonClass.sharedInstance.DispatcherProfileData?.postcode
        txtCompanyVATNumber.text = SingletonClass.sharedInstance.DispatcherProfileData?.vAT
        txtPhoneNumber.text = SingletonClass.sharedInstance.DispatcherProfileData?.companyPhone
    }
    
    func setUpUI(){
        
    }
    
    func checkChanges() -> Bool{
        if SingletonClass.sharedInstance.DispatcherProfileData?.companyName != txtCompanyName.text{
            return true
        }else if txtAddress.text != SingletonClass.sharedInstance.DispatcherProfileData?.address{
            return true
        }else if txtCity.text != SingletonClass.sharedInstance.DispatcherProfileData?.city{
            return true
        }else if selectedStateID != SingletonClass.sharedInstance.DispatcherProfileData?.state ?? 0{
            return true
        }else if txtPostalCode.text != SingletonClass.sharedInstance.DispatcherProfileData?.postcode{
            return true
        }else if txtCompanyVATNumber.text != SingletonClass.sharedInstance.DispatcherProfileData?.vAT{
            return true
        }else if txtPhoneNumber.text != SingletonClass.sharedInstance.DispatcherProfileData?.companyPhone{
            return true
        }else {
            return false
        }
    }
    
    @objc func ProfileEdit(){
        self.isEditEnable = true
        self.enableEdit()
        self.setupNavigationBar()
    }
    
    func enableEdit(){
        txtCompanyName.isUserInteractionEnabled = isEditEnable
        txtAddress.isUserInteractionEnabled = isEditEnable
        txtCity.isUserInteractionEnabled = isEditEnable
        txtState.isUserInteractionEnabled = isEditEnable
        txtPostalCode.isUserInteractionEnabled = isEditEnable
        txtCompanyVATNumber.isUserInteractionEnabled = isEditEnable
        txtPhoneNumber.isUserInteractionEnabled = isEditEnable
        btnRegister.isHidden = !isEditEnable
        self.txtCountry.rightImage = isEditEnable ? UIImage(named: "ic_dropdown") : UIImage()
        self.txtState.rightImage = isEditEnable ? UIImage(named: "ic_dropdown") : UIImage()
    }
    
    func validation()-> (Bool,String) {
        self.txtCompanyName.trim()
        self.txtAddress.trim()
        self.txtCity.trim()
        self.txtState.trim()
        self.txtCountry.trim()
        self.txtPostalCode.trim()
        self.txtCompanyVATNumber.trim()
        self.txtPhoneNumber.trim()
        let checkCompnyName = txtCompanyName.validatedText(validationType: .requiredField(field: "company_name".localized.localized))
        let checkAddress = txtAddress.validatedText(validationType: .requiredField(field: "address".localized))
        let checkCity = txtCity.validatedText(validationType: .requiredField(field: "city".localized))
        let checkState = txtState.validatedText(validationType: .requiredField(field: "state".localized))
        let checkCountry = txtCountry.validatedText(validationType: .requiredField(field: "country".localized))
        let checkPostal = txtPostalCode.validatedText(validationType: .requiredField(field: "postal_code".localized))
        let checkVat = txtCompanyVATNumber.validatedText(validationType: .requiredField(field: "company_VAT_number".localized))
        let checkPhone = txtPhoneNumber.validatedText(validationType: .requiredField(field: "company_phone_number".localized))
        if !checkCompnyName.0{
            return checkCompnyName
        }else if !checkAddress.0{
            return checkAddress
        }else if !checkCity.0{
            return checkCity
        }else if !checkState.0{
            return checkState
        }else if !checkCountry.0{
            return checkCountry
        }else if !checkPostal.0{
            return checkPostal
        }else if !checkVat.0{
            return checkVat
        }else if !checkPhone.0{
            return checkPhone
        }
        return (true,"")
    }
    
    func OpenPlacePicker() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.autocompleteFilter?.type = .city
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func saveData(){
        SingletonClass.sharedInstance.DispetcherRegisterData.companyName = txtCompanyName.text ?? ""
        SingletonClass.sharedInstance.DispetcherRegisterData.address = txtAddress.text ?? ""
        SingletonClass.sharedInstance.DispetcherRegisterData.city = txtCity.text ?? ""
        SingletonClass.sharedInstance.DispetcherRegisterData.state = "\(selectedStateID)"
        SingletonClass.sharedInstance.DispetcherRegisterData.country = txtCountry.text ?? ""
        SingletonClass.sharedInstance.DispetcherRegisterData.postCode = txtPostalCode.text ?? ""
        SingletonClass.sharedInstance.DispetcherRegisterData.vat = txtCompanyVATNumber.text ?? ""
        SingletonClass.sharedInstance.DispetcherRegisterData.companyPhone = txtPhoneNumber.text ?? ""
        UserDefault.SetRegiterData()
    }
    
    private func popBack(){
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            Utilities.ShowAlertOfSuccess(OfMessage: "profileUpdateSucces".localized)
        })
    }
    
    //MARK: - IBAction method
    @IBAction func btnNextClick(_ sender: Any) {
        
        let validation = validation()
        if validation.0{
            if isFromEdit{
                if checkChanges(){
                    self.callWebService()
                }else{
                    self.popBack()
                }
            }else{
                self.saveData()
                UserDefault.setValue(1, forKey: UserDefaultsKey.UserDefaultKeyForRegister.rawValue)
                let RegisterMainVC = self.navigationController?.viewControllers.last as! RegisterAllInOneViewController
                let x = self.view.frame.size.width * 2
                RegisterMainVC.MainScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
                RegisterMainVC.viewDidLayoutSubviews()
            }
        }else{
            Utilities.ShowAlertOfInfo(OfMessage: validation.1)
        }
    }
}

//MARK: - Text Filed Delegate
extension CompanyDetailsVC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtAddress {
            OpenPlacePicker()
            return false
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtState {
            selectedTextField = txtState
            txtState.inputView = generalPicker
            txtState.inputAccessoryView = generalPicker.toolbar
            if let DummyFirst = SingletonClass.sharedInstance.stateList?.firstIndex(where: {$0.getName() == txtState.text ?? ""}){
                generalPicker.selectRow(DummyFirst, inComponent: 0, animated: false)
            }
            self.generalPicker.reloadAllComponents()
        }else if textField == txtCountryCode {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPhoneNumber {
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 10, range: range, string: string)
            return CheckWritting
        }else  if textField == self.txtCompanyName{
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 70, range: range, string: string)
            return CheckWritting
        }else  if textField == self.txtCompanyVATNumber{
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 11, range: range, string: string)
            return CheckWritting
        }else  if textField == self.txtPostalCode{
            let CheckWritting =  textField.StopWrittingAtCharactorLimit(CharLimit: 8, range: range, string: string)
            return CheckWritting
        }
        return true
    }
}

// MARK: - GMAutoComplete delegate methods
extension CompanyDetailsVC: GMSAutocompleteViewControllerDelegate{
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let tempAddres:String = "\(place.formattedAddress ?? "")"
        self.txtAddress.text = tempAddres
        self.txtCity.text = ""
        self.txtPostalCode.text = ""
        let array = place.addressComponents
        for i in array ?? []{
            let key:String = "\(i.value(forKey: "type") ?? "")"
            let name:String = "\(i.value(forKey: "name") ?? "")"
            if key == "locality" || key == "administrative_area_level_2"{
                self.txtCity.text = name
            }else if key == "postal_code"{
                self.txtPostalCode.text = name
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: \(error)")
//        dismiss(animated: true, completion: nil)
    }
}

extension CompanyDetailsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch selectedTextField{
        case txtState:
            return SingletonClass.sharedInstance.TruckBrandList?.count ?? 0
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
        case txtState:
            return SingletonClass.sharedInstance.stateList?[row].getName()
        case txtCountryCode:
            return CountryCodeArray[row]
        default:
            return ""
        }
    }
}

//MARK: - GeneralPickerView Delegate
extension CompanyDetailsVC: GeneralPickerViewDelegate{
    
    func didTapCancel() {}
    
    func didTapDone() {
        if selectedTextField == txtState {
            let item = SingletonClass.sharedInstance.stateList?[generalPicker.selectedRow(inComponent: 0)]
            self.txtState.text = item?.getName()
            self.selectedStateID = item?.id ?? 0
            self.txtState.resignFirstResponder()
        }else if selectedTextField == txtCountryCode {
            let item = CountryCodeArray[generalPicker.selectedRow(inComponent: 0)]
            self.txtCountryCode.text = item
            self.txtCountryCode.resignFirstResponder()
        }
    }
    
}

//MARK: - Web Service Metode
extension CompanyDetailsVC{
    func callWebService(){
        let reqModel = UpdateCompanyDetailReqModel()
        reqModel.companyName = txtCompanyName.text
        reqModel.address = txtAddress.text
        reqModel.city = txtCity.text
        reqModel.state = "\(selectedStateID)"
        reqModel.country = txtCountry.text
        reqModel.postCode = txtPostalCode.text
        reqModel.vat = txtCompanyVATNumber.text
        reqModel.companyPhone = txtPhoneNumber.text
        updateDetailViewModel.callWebServiceForUpdateCompany(reqModel: reqModel)
    }
}
