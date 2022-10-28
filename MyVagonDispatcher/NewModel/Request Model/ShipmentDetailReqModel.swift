//
//  ShipmentDetailReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 05/08/22.
//

import Foundation

class ShipmentDetailReqModel: Encodable{
    
    var bookingId : String?
    var driverId : String?
    
    enum CodingKeys: String, CodingKey {
            case bookingId = "booking_id"
            case driverId = "driver_id"
        }
}

