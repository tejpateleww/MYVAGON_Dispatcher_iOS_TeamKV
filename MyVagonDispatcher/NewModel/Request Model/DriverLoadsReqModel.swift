//
//  DriverLoadsReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 06/09/22.
//

import Foundation
class DriverLoadsReqModel: Encodable{
    var driver_id : String?
    
    enum CodingKeys: String, CodingKey {
        case driver_id = "driver_id"
    }
}
