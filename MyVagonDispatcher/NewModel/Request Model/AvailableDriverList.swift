//
//  AvailableDriverList.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 04/10/22.
//

import Foundation
class AvailableDriverList : Encodable{
    
    var bookingId : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
    }
}
