//
//  DriverStateListResModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 06/07/22.
//

import Foundation
struct DriverStateListResModel: Codable {

    let status: Bool?
    let message: String?
    let data: [StateList]?

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(Bool.self, forKey: .status)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        data = try? values.decodeIfPresent([StateList].self, forKey: .data)
    }

}
struct StateList: Codable {

    let id: Int?
    let name: String?
    let greekName: String?
    let countryId: Int?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case greekName = "greekName"
        case countryId = "country_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        greekName = try? values.decodeIfPresent(String.self, forKey: .greekName)
        countryId = try? values.decodeIfPresent(Int.self, forKey: .countryId)
    }
    
    func getName() -> String{
        if (UserDefaults.standard.string(forKey: LCLCurrentLanguageKey) ?? "el" == "el"){
            return name ?? ""
        }else{
            return name ?? ""
        }
    }
}
