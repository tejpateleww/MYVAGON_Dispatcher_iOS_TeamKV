//
//  MyLoadsLoadsDatum.swift
//  MyVagonDispatcher
//
//  Created by Apple on 06/10/21.
//

import Foundation
struct SearchLoadsDatum : Codable {
    
    let amount : String?
    let bookingType : String?
    let cancellationCharge : String?
    let cancellationTerm : String?
    let createdAt : String?
    let date : String?
    let deletedAt : String?
    let distance : String?
    let emailOrNumber : String?
    let id : Int?
    let isBid : Int?
    let isPublic : Int?
    let isTracking : Int?
    let journey : String?
    let journeyType : String?
    let pickupAddress : String?
    let pickupLat : String?
    let pickupLng : String?
    let pickupNote : String?
    let pickupTimeFrom : String?
    let pickupTimeTo : String?
    let shipperDetails : SearchShipperDetail?
    let status : String?
    let totalWeight : String?
    let trucks : SearchTruck?
    let txnId : String?
    let updatedAt : String?
    let mapImage : String?
    let userId : Int?
    let availabilityId : Int?
    let vehicles : [TruckDetails]?
    
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case bookingType = "booking_type"
        case cancellationCharge = "cancellation_charge"
        case cancellationTerm = "cancellation_term"
        case createdAt = "created_at"
        case date = "date"
        case deletedAt = "deleted_at"
        case distance = "distance"
        case emailOrNumber = "email_or_number"
        case id = "id"
        case isBid = "is_bid"
        case isPublic = "is_public"
        case isTracking = "is_tracking"
        case journey = "journey"
        case journeyType = "journey_type"
        case pickupAddress = "pickup_address"
        case pickupLat = "pickup_lat"
        case pickupLng = "pickup_lng"
        case pickupNote = "pickup_note"
        case pickupTimeFrom = "pickup_time_from"
        case pickupTimeTo = "pickup_time_to"
        case shipperDetails = "shipper_details"
        case status = "status"
        case totalWeight = "total_weight"
        case trucks = "trucks"
        case txnId = "txn_id"
        case updatedAt = "updated_at"
        case mapImage = "map_image"
        case userId = "user_id"
        case availabilityId = "availability_id"
        case vehicles = "vehicles"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try? values.decodeIfPresent(String.self, forKey: .amount)
        bookingType = try? values.decodeIfPresent(String.self, forKey: .bookingType)
        cancellationCharge = try? values.decodeIfPresent(String.self, forKey: .cancellationCharge)
        cancellationTerm = try? values.decodeIfPresent(String.self, forKey: .cancellationTerm)
        createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        date = try? values.decodeIfPresent(String.self, forKey: .date)
        deletedAt = try? values.decodeIfPresent(String.self, forKey: .deletedAt)
        distance = try? values.decodeIfPresent(String.self, forKey: .distance)
        emailOrNumber = try? values.decodeIfPresent(String.self, forKey: .emailOrNumber)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        isBid = try? values.decodeIfPresent(Int.self, forKey: .isBid)
        isPublic = try? values.decodeIfPresent(Int.self, forKey: .isPublic)
        isTracking = try? values.decodeIfPresent(Int.self, forKey: .isTracking)
        journey = try? values.decodeIfPresent(String.self, forKey: .journey)
        journeyType = try? values.decodeIfPresent(String.self, forKey: .journeyType)
        pickupAddress = try? values.decodeIfPresent(String.self, forKey: .pickupAddress)
        pickupLat = try? values.decodeIfPresent(String.self, forKey: .pickupLat)
        pickupLng = try? values.decodeIfPresent(String.self, forKey: .pickupLng)
        pickupNote = try? values.decodeIfPresent(String.self, forKey: .pickupNote)
        pickupTimeFrom = try? values.decodeIfPresent(String.self, forKey: .pickupTimeFrom)
        pickupTimeTo = try? values.decodeIfPresent(String.self, forKey: .pickupTimeTo)
        shipperDetails = try? values.decodeIfPresent(SearchShipperDetail.self, forKey: .shipperDetails)
        status = try? values.decodeIfPresent(String.self, forKey: .status)
        totalWeight = try? values.decodeIfPresent(String.self, forKey: .totalWeight)
        trucks = try? values.decodeIfPresent(SearchTruck.self, forKey: .trucks)
        txnId = try? values.decodeIfPresent(String.self, forKey: .txnId)
        updatedAt = try? values.decodeIfPresent(String.self, forKey: .updatedAt)
        mapImage = try? values.decodeIfPresent(String.self, forKey: .mapImage)
        userId = try? values.decodeIfPresent(Int.self, forKey: .userId)
        availabilityId = try? values.decodeIfPresent(Int.self, forKey: .availabilityId)
        vehicles = try? values.decodeIfPresent([TruckDetails].self, forKey: .vehicles)
    }
    
}
