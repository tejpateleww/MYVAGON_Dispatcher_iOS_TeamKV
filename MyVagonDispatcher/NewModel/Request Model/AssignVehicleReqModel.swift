//
//  AssignVehicleReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 30/07/22.
//

import Foundation
class AssignVehicleReqModel:Encodable{
    var driverId : String?
    var tractorId : String?
    var truckId : String?
    
    enum CodingKeys: String, CodingKey {
            case driverId = "driver_id"
            case tractorId = "tractor_id"
            case truckId = "truck_id"
        }
}
