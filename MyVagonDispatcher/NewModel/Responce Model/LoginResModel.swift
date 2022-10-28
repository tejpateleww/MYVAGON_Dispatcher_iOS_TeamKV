//
//  LoginResModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 07/07/22.
//

import Foundation
struct LoginResModel: Codable {

    var status: Bool?
    var message: String?
    var data: DispatcherLoginData?

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(Bool.self, forKey: .status)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        data = try? values.decodeIfPresent(DispatcherLoginData.self, forKey: .data)
    }
}
struct DispatcherLoginData: Codable {

    var id: Int?
    var firstName: String?
    var LastName: String?
    var email: String?
    var profile: String?
    var type: String?
    var mobileNumber: String?
    var companyName: String?
    var companyPhone: String?
    var city: String?
    var state: Int?
    var postcode: String?
    var country: Int?
    var countryCode: String?
    var permissions: DispatcherPermissions?
    var token: String?
    var address: String?
    var vAT: String?
    var paymentType : Int?
    var iban : String?
    var accountNumber : String?
    var bankName : String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case LastName = "last_name"
        case email = "email"
        case profile = "profile"
        case type = "type"
        case mobileNumber = "mobile_number"
        case companyName = "company_name"
        case companyPhone = "company_phone"
        case city = "city"
        case state = "state"
        case postcode = "postcode"
        case country = "country"
        case countryCode = "country_code"
        case permissions = "permissions"
        case token = "token"
        case address = "address"
        case vAT = "vat"
        case paymentType = "payment_type"
        case iban = "iban"
        case accountNumber = "account_number"
        case bankName = "bank_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        firstName = try? values.decodeIfPresent(String.self, forKey: .firstName)
        LastName = try? values.decodeIfPresent(String.self, forKey: .LastName)
        email = try? values.decodeIfPresent(String.self, forKey: .email)
        profile = try? values.decodeIfPresent(String.self, forKey: .profile)
        type = try? values.decodeIfPresent(String.self, forKey: .type)
        mobileNumber = try? values.decodeIfPresent(String.self, forKey: .mobileNumber)
        companyName = try? values.decodeIfPresent(String.self, forKey: .companyName)
        companyPhone = try? values.decodeIfPresent(String.self, forKey: .companyPhone)
        city = try? values.decodeIfPresent(String.self, forKey: .city)
        state = try? values.decodeIfPresent(Int.self, forKey: .state)
        postcode = try? values.decodeIfPresent(String.self, forKey: .postcode)
        country = try? values.decodeIfPresent(Int.self, forKey: .country)
        countryCode = try? values.decodeIfPresent(String.self, forKey: .countryCode)
        permissions = try? values.decodeIfPresent(DispatcherPermissions.self, forKey: .permissions)
        token = try? values.decodeIfPresent(String.self, forKey: .token)
        address = try? values.decodeIfPresent(String.self, forKey: .address)
        paymentType = try? values.decodeIfPresent(Int.self, forKey: .paymentType)
        iban = try? values.decodeIfPresent(String.self, forKey: .iban)
        accountNumber = try? values.decodeIfPresent(String.self, forKey: .accountNumber)
        bankName = try? values.decodeIfPresent(String.self, forKey: .bankName)
        vAT = try? values.decodeIfPresent(String.self, forKey: .vAT)
    }

}
struct DispatcherPermissions: Codable {
    
    var id: Int?
    var userId: Int?
    var searchLoads: Int?
    var myLoads: Int?
    var myProfile: Int?
    var setting: Int?
    var statistics: Int?
    var changePassword: Int?
    var allowBid: Int?
    var viewPrice: Int?
    var postAvailibility: Int?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case searchLoads = "search_loads"
        case myLoads = "my_loads"
        case myProfile = "my_profile"
        case setting = "setting"
        case statistics = "statistics"
        case changePassword = "change_password"
        case allowBid = "allow_bid"
        case viewPrice = "view_price"
        case postAvailibility = "post_availibility"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        searchLoads = try values.decodeIfPresent(Int.self, forKey: .searchLoads)
        myLoads = try values.decodeIfPresent(Int.self, forKey: .myLoads)
        myProfile = try values.decodeIfPresent(Int.self, forKey: .myProfile)
        setting = try values.decodeIfPresent(Int.self, forKey: .setting)
        statistics = try values.decodeIfPresent(Int.self, forKey: .statistics)
        changePassword = try values.decodeIfPresent(Int.self, forKey: .changePassword)
        allowBid = try values.decodeIfPresent(Int.self, forKey: .allowBid)
        viewPrice = try values.decodeIfPresent(Int.self, forKey: .viewPrice)
        postAvailibility = try values.decodeIfPresent(Int.self, forKey: .postAvailibility)
    }

}
