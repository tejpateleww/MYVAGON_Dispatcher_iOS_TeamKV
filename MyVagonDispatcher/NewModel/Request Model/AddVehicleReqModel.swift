//
//  AddTruckReqModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 20/07/22.
//

import Foundation
class DispatcherAddTruckReqModel:Encodable {
    var truckId :String?
    var truckTypeId : String?
    var truckSubCategoryId:String?
    var overallTruckWeight:String?
    var overallTruckWeightUnit:String?
    var cargoLoadCapacity:String?
    var cargoLoadCapacityUnit:String?
    var registrationNo:String?
    var truckImages:String?
    var truckFeatures: String?
    var deleteImage:String?
    var pallets: String?//[DispatcherPallets]?
    
    enum CodingKeys: String, CodingKey {
        case truckId = "id"
        case truckTypeId = "truck_type_id"
        case truckSubCategoryId = "truck_subcategory_id"
        case overallTruckWeight = "overall_truck_weight"
        case overallTruckWeightUnit = "overall_truck_weight_unit"
        case cargoLoadCapacity = "cargo_load_capacity"
        case cargoLoadCapacityUnit = "cargo_load_capacity_unit"
        case registrationNo = "registration_no"
        case truckImages = "truck_images"
        case pallets = "pallets"
        case truckFeatures = "truck_features"
        case deleteImage = "delete_images"
    }
}

class DispatcherPallets:Encodable{
    var value:String?
    var id:Int?
    
    init(Capacity:String,Type:Int) {
        self.value = Capacity
        self.id = Type
    }
    
    private enum CodingKeys : String, CodingKey {
        case value = "value"
        case id = "id"
    }
}
