//
//  SearchLoadModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 21/06/22.
//

import Foundation
class SearchLoadModel : Codable {
    var date = ""
    var truck_type_id = ""
    var pickup_lat = ""
    var pickup_lng = ""
    var delivery_lat = ""
    var delivery_lng = ""
    var price_min = ""
    var price_max = ""
    var weight_min = ""
    var weight_max = ""
    var weight_min_unit = ""
    var weight_max_unit = ""
    var pickupAddressString = ""
    var dropoffAddressString = ""
    var journey_type = ""
}
