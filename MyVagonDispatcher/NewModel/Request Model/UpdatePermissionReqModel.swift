//
//  UpdatePermissionReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 28/07/22.
//

import Foundation
class UpdatePermissionReqModel:Encodable{
    var driverId : String?
    var permissionKey : String?
    var permissionValue : String?
    
    enum CodingKeys: String, CodingKey {
            case driverId = "driver_id"
            case permissionKey = "permission_key"
            case permissionValue = "permission_value"
        }
}
