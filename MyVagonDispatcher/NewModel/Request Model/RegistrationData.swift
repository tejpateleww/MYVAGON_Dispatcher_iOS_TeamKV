//
//  RegistrationReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 06/07/22.
//

import Foundation
class RegistrationData: Codable{
    var deviceName = ""
    var deviceToken = ""
    var deviceType = ""
    var firstName = ""
    var lastName = ""
    var email = ""
    var password = ""
    var phone = ""
    var companyName = ""
    var address = ""
    var city = ""
    var state = ""
    var country = ""
    var companyPhone = ""
    var postCode = ""
    var vat = ""
    var paymentType = "0"
    var iban = ""
    var accountNumber = ""
    var bankName = ""
    var countryCode = ""
}

class RegistrationReqModel :Encodable{
    var deviceName : String?
    var deviceToken : String?
    var deviceType : String?
    var appVersion: String?
    var firstName : String?
    var lastName : String?
    var email : String?
    var password : String?
    var phone : String?
    var companyName : String?
    var address : String?
    var city : String?
    var state : String?
    var country : String?
    var companyPhone : String?
    var postCode : String?
    var vat : String?
    var paymentType : String?
    var iban : String?
    var accountNumber : String?
    var bankName : String?
    
    enum CodingKeys: String, CodingKey {
            case deviceName = "device_name"
            case deviceToken = "device_token"
            case deviceType = "device_type"
            case firstName = "first_name"
            case lastName = "last_name"
            case email = "email"
            case password = "password"
            case phone = "phone"
            case companyName = "company_name"
            case address = "address"
            case city = "city"
            case state = "state"
            case country = "country"
            case companyPhone = "company_phone"
            case postCode = "postcode"
            case vat = "vat"
            case paymentType = "payment_type"
            case iban = "iban"
            case accountNumber = "account_number"
            case bankName = "bank_name"
            case appVersion = "app_version"
        }
    
    func setData(data:RegistrationData){
        self.deviceName = SingletonClass.sharedInstance.DeviceName
        self.deviceToken = SingletonClass.sharedInstance.DeviceToken
        self.deviceType = SingletonClass.sharedInstance.DeviceType
        self.appVersion = SingletonClass.sharedInstance.AppVersion
        self.firstName = data.firstName
        self.lastName = data.lastName
        self.email = data.email
        self.password = data.password
        self.phone = data.phone
        self.companyName = data.companyName
        self.address = data.address
        self.city = data.city
        self.state = data.state
        self.country = data.country
        self.companyPhone = data.companyPhone
        self.postCode = data.postCode
        self.vat = data.vat
        self.paymentType = data.paymentType
        self.iban = data.iban
        self.accountNumber = data.accountNumber
        self.bankName = data.bankName
    }
}
