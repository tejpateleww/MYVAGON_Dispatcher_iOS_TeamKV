//
//  DriverPermissionResModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 25/07/22.
//

import Foundation
struct DriverPermissionResModel: Codable {

    var status: Bool?
    var message: String?
    var data: PermissionData?

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(Bool.self, forKey: .status)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        data = try? values.decodeIfPresent(PermissionData.self, forKey: .data)
    }

}
struct PermissionData: Codable {
    
    var id: Int?
    var userId: Int?
    var changeFrom: Int?
    var permissions: [DriverPermissions]?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case changeFrom = "change_from"
        case permissions = "permissions"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        userId = try? values.decodeIfPresent(Int.self, forKey: .userId)
        changeFrom = try? values.decodeIfPresent(Int.self, forKey: .changeFrom)
        permissions = try? values.decodeIfPresent([DriverPermissions].self, forKey: .permissions)
    }

}
struct DriverPermissions: Codable {

    var key: String?
    var value: Int?
    var name: String?

    private enum CodingKeys: String, CodingKey {
        case key = "key"
        case value = "value"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try? values.decodeIfPresent(String.self, forKey: .key)
        value = try? values.decodeIfPresent(Int.self, forKey: .value)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
    }

}
