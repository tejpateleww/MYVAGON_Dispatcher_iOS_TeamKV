//
//  EditTractorDetailReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 16/03/22.
//

import Foundation
class EditTractorDetailReqModel: Encodable{
    var fuel_type : String?
    var brand : String?
    var plate_number : String?
    var images: String?
    
    enum CodingKeys: String, CodingKey {
        case fuel_type = "fuel_type"
        case brand = "brand"
        case plate_number = "plate_number"
        case images = "images"
    }
    
}
