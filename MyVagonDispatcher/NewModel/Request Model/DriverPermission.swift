//
//  DriverPermission.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 25/07/22.
//

import Foundation
class DriverPermissionReqModel :Encodable{
    var driverId : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
    }
}
