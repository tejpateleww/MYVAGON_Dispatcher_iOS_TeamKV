//
//  EditPersonalInfoReqModel.swift
//  MyVagonDispatcher
//
//  Created by Harshit K on 15/03/22.
//

import Foundation


class EditPersonalInfoReqModel : Encodable {
    var firstName: String?
    var LastName: String?
//    var country_code: String?
    var mobile_number: String?
    var profile_image: String?
    

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case LastName = "last_name"
//        case country_code = "country_code"
        case mobile_number = "phone"
        case profile_image = "profile_image"
    }
}
