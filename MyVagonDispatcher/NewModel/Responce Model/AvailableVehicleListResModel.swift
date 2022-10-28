//
//  AvailableVehicleListResModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 27/07/22.
//

import Foundation
struct AvailableVehicleListResModel: Codable {

    let status: Bool?
    let message: String?
    let data: AvailableVehicle?

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(Bool.self, forKey: .status)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        data = try? values.decodeIfPresent(AvailableVehicle.self, forKey: .data)
    }

}
struct AvailableVehicle: Codable {

    let tractors: [TractorList]?
    let trucks: [TruckList]?

    private enum CodingKeys: String, CodingKey {
        case tractors = "tractors"
        case trucks = "trucks"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tractors = try? values.decodeIfPresent([TractorList].self, forKey: .tractors)
        trucks = try? values.decodeIfPresent([TruckList].self, forKey: .trucks)
    }

}
