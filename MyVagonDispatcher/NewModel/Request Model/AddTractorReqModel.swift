//
//  AddTractorReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 21/07/22.
//

import Foundation
class AddTractorReqModel:Encodable{
    var brandId : String?
    var fuelType:String?
    var registrationNo:String?
    var tractorImage:String?
    var tractorId:String?
    var deleteImage:String?
    
    enum CodingKeys: String, CodingKey {
        case tractorId = "tractor_id"
        case brandId = "brand_id"
        case fuelType = "fuel_type"
        case registrationNo = "registration_no"
        case tractorImage = "tractor_image"
        case deleteImage = "delete_images"
    }
}
