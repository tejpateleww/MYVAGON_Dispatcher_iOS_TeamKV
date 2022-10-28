//
//  RemoveVehicleReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 27/09/22.
//

import Foundation
class RemoveVehicleReqModel : Encodable{
    
    var driver_id : String?
    var dispatcherVehicleId : String?
    
    enum CodingKeys: String, CodingKey {
        case driver_id = "driver_id"
        case dispatcherVehicleId = "dispatcher_vehicle_id"
    }
}
