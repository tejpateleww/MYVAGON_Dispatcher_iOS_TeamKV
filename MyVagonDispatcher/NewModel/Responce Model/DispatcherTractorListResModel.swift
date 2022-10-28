//
//  DispatcherTractorListResModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 21/07/22.
//

import Foundation
struct DispatcherTractorListResModel: Codable {

    var status: Bool?
    var message: String?
    var data: [TractorList]?

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(Bool.self, forKey: .status)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        data = try? values.decodeIfPresent([TractorList].self, forKey: .data)
    }
}
struct TractorList: Codable {

    var id: Int?
    var userId: Int?
    var fuelType: String?
    var brandId: Brand?
    var registrationNo: String?
    var tractorImage: String?
    var isAssign: Int?
    var status: Int?
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case fuelType = "fuel_type"
        case brandId = "brand_id"
        case registrationNo = "registration_no"
        case tractorImage = "tractor_image"
        case isAssign = "is_assign"
        case status = "status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        userId = try? values.decodeIfPresent(Int.self, forKey: .userId)
        fuelType = try? values.decodeIfPresent(String.self, forKey: .fuelType)
        brandId = try? values.decodeIfPresent(Brand.self, forKey: .brandId)
        registrationNo = try? values.decodeIfPresent(String.self, forKey: .registrationNo)
        tractorImage = try? values.decodeIfPresent(String.self, forKey: .tractorImage)
        isAssign = try? values.decodeIfPresent(Int.self, forKey: .isAssign)
        status = try? values.decodeIfPresent(Int.self, forKey: .status)
        createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try? values.decodeIfPresent(String.self, forKey: .updatedAt)
        deletedAt = try? values.decodeIfPresent(String.self, forKey: .deletedAt)
    }

}
