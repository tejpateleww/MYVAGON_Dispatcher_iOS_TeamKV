//
//  ShipmentDetailResModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 05/08/22.
//

import Foundation
struct ShipmentDetailResModel: Codable {

    var status: Bool?
    var message: String?
    var data: MyLoadsNewBid?

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(Bool.self, forKey: .status)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        data = try? values.decodeIfPresent(MyLoadsNewBid.self, forKey: .data)
    }

}
