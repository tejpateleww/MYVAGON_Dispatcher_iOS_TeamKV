//
//  AddDriverReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 19/07/22.
//

import Foundation
class AddDriverReqModel :Encodable{
    var firstName : String?
    var lastName : String?
    var email : String?
    var password : String?
    var phone : String?
    var countryCode = "+30"
    var profileImage : String?
    var idProof : String?
    var licence : String?
    var licenceBack : String?
    var driverId : String?
    var licenceNumber : String?
    var licenceExpiryDate : String?
    
    enum CodingKeys: String, CodingKey {
        case licenceNumber = "license_number"
        case licenceExpiryDate = "license_expiry_date"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case password = "password"
        case phone = "phone"
        case countryCode = "country_code"
        case profileImage = "profile_image"
        case idProof = "id_proof"
        case licence = "license"
        case licenceBack = "license_back"
        case driverId = "driver_id"
    }
}
