//
//  AssignDriverReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 29/08/22.
//

import Foundation

import Foundation
class AssignDriverReqModel: Encodable{
    var driver_id : String?
    var booking_id : String?
    
    enum CodingKeys: String, CodingKey {
        case driver_id = "driver_id"
        case booking_id = "booking_id"
    }
}
