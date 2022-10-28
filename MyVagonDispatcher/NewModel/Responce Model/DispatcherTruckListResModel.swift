//
//  DispatcherTruckListResModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 21/07/22.
//

import Foundation

struct DispatcherTruckListResModel: Codable {

    var status: Bool?
    var message: String?
    var data: [TruckList]?

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(Bool.self, forKey: .status)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        data = try? values.decodeIfPresent([TruckList].self, forKey: .data)
    }

}
struct TruckList: Codable {

    var truckId: Int?
    var userId: Int?
    var truckTypeId: TruckType?
    var truckSubCategoryId: [TruckSubCategoryId]?
    var overallTruckWeight: String?
    var overallTruckWeightUnit: OverallTruckWeightUnit?
    var cargoLoadCapacity: String?
    var cargoLoadCapacityUnit: CargoLoadCapacityUnit?
    var registrationNo: String?
    var truckImage: String?
    var truckFeatures: String?
    var hydraulicDoor: Int?
    var defaultTruck: Int?
    var isAssign: Int?
    var status: String?
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    var truckCapacity: [NewTruckCapacity]?

    private enum CodingKeys: String, CodingKey {
        case truckId = "truck_id"
        case userId = "user_id"
        case truckTypeId = "truck_type_id"
        case truckSubCategoryId = "truck_sub_category_id"
        case overallTruckWeight = "overall_truck_weight"
        case overallTruckWeightUnit = "overall_truck_weight_unit"
        case cargoLoadCapacity = "cargo_load_capacity"
        case cargoLoadCapacityUnit = "cargo_load_capacity_unit"
        case registrationNo = "registration_no"
        case truckImage = "truck_image"
        case truckFeatures = "truck_features"
        case hydraulicDoor = "hydraulic_door"
        case defaultTruck = "default_truck"
        case isAssign = "is_assign"
        case status = "status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case truckCapacity = "truck_capacity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        truckId = try? values.decodeIfPresent(Int.self, forKey: .truckId)
        userId = try? values.decodeIfPresent(Int.self, forKey: .userId)
        truckTypeId = try? values.decodeIfPresent(TruckType.self, forKey: .truckTypeId)
        truckSubCategoryId = try? values.decodeIfPresent([TruckSubCategoryId].self, forKey: .truckSubCategoryId)
        overallTruckWeight = try? values.decodeIfPresent(String.self, forKey: .overallTruckWeight)
        overallTruckWeightUnit = try? values.decodeIfPresent(OverallTruckWeightUnit.self, forKey: .overallTruckWeightUnit)
        cargoLoadCapacity = try? values.decodeIfPresent(String.self, forKey: .cargoLoadCapacity)
        cargoLoadCapacityUnit = try? values.decodeIfPresent(CargoLoadCapacityUnit.self, forKey: .cargoLoadCapacityUnit)
        registrationNo = try? values.decodeIfPresent(String.self, forKey: .registrationNo)
        truckImage = try? values.decodeIfPresent(String.self, forKey: .truckImage)
        truckFeatures = try? values.decodeIfPresent(String.self, forKey: .truckFeatures)
        hydraulicDoor = try? values.decodeIfPresent(Int.self, forKey: .hydraulicDoor)
        defaultTruck = try? values.decodeIfPresent(Int.self, forKey: .defaultTruck)
        isAssign = try? values.decodeIfPresent(Int.self, forKey: .isAssign)
        status = try? values.decodeIfPresent(String.self, forKey: .status)
        createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try? values.decodeIfPresent(String.self, forKey: .updatedAt)
        deletedAt = try? values.decodeIfPresent(String.self, forKey: .deletedAt)
        truckCapacity = try? values.decodeIfPresent([NewTruckCapacity].self, forKey: .truckCapacity)
    }

}
struct TruckSubCategoryId: Codable {

    var id: Int?
    var name: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
    }

}

struct OverallTruckWeightUnit: Codable {

    var id: Int?
    var name: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
    }
}
struct CargoLoadCapacityUnit: Codable {

    var id: Int?
    var name: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
    }

}

struct TruckCapacity: Codable {

    var truckCapacityId: Int?
    var truckId: Int?
    var capacity: Int?
    var packageId: Int?
    var createdAt: String?
    var updatedAt: String?

    private enum CodingKeys: String, CodingKey {
        case truckCapacityId = "truck_capacity_id"
        case truckId = "truck_id"
        case capacity = "capacity"
        case packageId = "package_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        truckCapacityId = try? values.decodeIfPresent(Int.self, forKey: .truckCapacityId)
        truckId = try? values.decodeIfPresent(Int.self, forKey: .truckId)
        capacity = try? values.decodeIfPresent(Int.self, forKey: .capacity)
        packageId = try? values.decodeIfPresent(Int.self, forKey: .packageId)
        createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try? values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
}

struct NewTruckCapacity: Codable {

    var truckCapacityId: Int?
    var truckId: Int?
    var capacity: Int?
    var packageId: Package?
    var createdAt: String?
    var updatedAt: String?

    private enum CodingKeys: String, CodingKey {
        case truckCapacityId = "truck_capacity_id"
        case truckId = "truck_id"
        case capacity = "capacity"
        case packageId = "package_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        truckCapacityId = try? values.decodeIfPresent(Int.self, forKey: .truckCapacityId)
        truckId = try? values.decodeIfPresent(Int.self, forKey: .truckId)
        capacity = try? values.decodeIfPresent(Int.self, forKey: .capacity)
        packageId = try? values.decodeIfPresent(Package.self, forKey: .packageId)
        createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try? values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
}

struct Package: Codable {

    var id: Int?
    var name: String?
    var greekName: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case greekName = "name_greek"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        greekName = try? values.decodeIfPresent(String.self, forKey: .greekName)
    }
}
