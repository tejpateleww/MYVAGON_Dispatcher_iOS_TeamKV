//
//  UpdateCompanyDetailReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 08/07/22.
//

import Foundation
class UpdateCompanyDetailReqModel: Encodable{
   
    var companyName : String?
    var address : String?
    var city : String?
    var state : String?
    var country : String?
    var companyPhone : String?
    var postCode : String?
    var vat : String?
    
    enum CodingKeys: String, CodingKey {
            case companyName = "company_name"
            case address = "address"
            case city = "city"
            case state = "state"
            case country = "country"
            case companyPhone = "company_phone"
            case postCode = "postcode"
            case vat = "vat"
        }
}
