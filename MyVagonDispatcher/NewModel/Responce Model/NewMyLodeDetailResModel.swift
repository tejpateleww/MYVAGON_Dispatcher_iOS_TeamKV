//
//  NewMyLodeDetailResModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 08/08/22.
//

import Foundation
struct NewMyLodeDetailResModel : Codable {
    
    let data : [NewMyLoadData]?
    let message : String?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try? values.decodeIfPresent([NewMyLoadData].self, forKey: .data)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        status = try? values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
struct NewMyLoadData : Codable {
    var bid : NewLoadData?
    var book : NewLoadData?
    let postedTruck : NewMyLoadsPostedTruck?
    let type : String?
    let date : String?
    
    enum CodingKeys: String, CodingKey {
        case bid = "bid"
        case book = "book"
        case postedTruck = "posted_truck"
        case type = "type"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bid = try? values.decodeIfPresent(NewLoadData.self, forKey: .bid)
        book = try? values.decodeIfPresent(NewLoadData.self, forKey: .book)
        postedTruck = try? values.decodeIfPresent(NewMyLoadsPostedTruck.self, forKey: .postedTruck)
        type = try? values.decodeIfPresent(String.self, forKey: .type)
        date = try? values.decodeIfPresent(String.self, forKey: .date)
    }
    
    init(PostedTruck:NewMyLoadsPostedTruck,Type:String,Date:String) {
        self.bid = nil
        self.book = nil
        self.postedTruck = PostedTruck
        self.type = Type
        self.date = Date
    }
}
struct NewLoadData: Codable {
    
    let id: Int?
    let status: String?
    let amount: String?
    let distance: String?
    let totalWeight: String?
    let paymentStatus: String?
    let date: String?
    let pickupDate: String?
    let isBid: Int?
    let displayPaymentStatus: String?
    let displayStatusMessage: String?
    let locations: [MyLoadsNewLocation]?
    let shipperDetails: ShipperDetails?
    var driverDetail: DriverDetail?
    var currentTime: String?
    let createdAt: String?
    let pickupTime: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case status = "status"
        case amount = "amount"
        case distance = "distance"
        case totalWeight = "total_weight"
        case paymentStatus = "payment_status"
        case date = "date"
        case pickupDate = "pickup_date"
        case isBid = "is_bid"
        case displayPaymentStatus = "display_payment_status"
        case displayStatusMessage = "display_status_message"
        case locations = "locations"
        case shipperDetails = "shipper_details"
        case driverDetail = "driver_detail"
        case createdAt = "created_at"
        case currentTime = "current_time"
        case pickupTime = "pickup_time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        status = try? values.decodeIfPresent(String.self, forKey: .status)
        amount = try? values.decodeIfPresent(String.self, forKey: .amount)
        distance = try? values.decodeIfPresent(String.self, forKey: .distance)
        totalWeight = try? values.decodeIfPresent(String.self, forKey: .totalWeight)
        paymentStatus = try? values.decodeIfPresent(String.self, forKey: .paymentStatus)
        date = try? values.decodeIfPresent(String.self, forKey: .date)
        pickupDate = try? values.decodeIfPresent(String.self, forKey: .pickupDate)
        isBid = try? values.decodeIfPresent(Int.self, forKey: .isBid)
        displayPaymentStatus = try? values.decodeIfPresent(String.self, forKey: .displayPaymentStatus)
        displayStatusMessage = try? values.decodeIfPresent(String.self, forKey: .displayStatusMessage)
        locations = try? values.decodeIfPresent([MyLoadsNewLocation].self, forKey: .locations)
        shipperDetails = try? values.decodeIfPresent(ShipperDetails.self, forKey: .shipperDetails)
        driverDetail = try? values.decodeIfPresent(DriverDetail.self, forKey: .driverDetail)
        createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        currentTime = try? values.decodeIfPresent(String.self, forKey: .currentTime)
        pickupTime = try? values.decodeIfPresent(String.self, forKey: .pickupTime)
    }
}

struct ShipperDetails: Codable {
    
    let companyName: String?
    let id: Int?
    
    private enum CodingKeys: String, CodingKey {
        case companyName = "company_name"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        companyName = try? values.decodeIfPresent(String.self, forKey: .companyName)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
    }
}
struct NewMyLoadsPostedTruck : Codable {
    
    let bidAmount : String?
    let bookingId : String?
    let bookingInfo : NewLoadData?
    let createdAt : String?
    let date : String?
    let driverId : String?
    let endLat : String?
    let endLng : String?
    let displayStatusMessage : String?
    let fromAddress : String?
    let id : Int?
    let isBid : Int?
    let loadStatus : String?
    let startLat : String?
    let startLng : String?
    let time : String?
    let toAddress : String?
    let truckTypeId : Int?
    let updatedAt : String?
    let bookingRequestCount : Int?
    let matchesCount: Int?
    let count : Int?
    let shipperId : Int?
    let time_difference : Int?
    let offerPrice : String?
    var driverDetail: DriverDetail?
    
    enum CodingKeys: String, CodingKey {
        case bidAmount = "bid_amount"
        case bookingId = "booking_id"
        case bookingInfo = "booking_info"
        case createdAt = "created_at"
        case date = "date"
        case driverId = "driver_id"
        case endLat = "end_lat"
        case endLng = "end_lng"
        case fromAddress = "from_address"
        case id = "id"
        case isBid = "is_bid"
        case loadStatus = "load_status"
        case startLat = "start_lat"
        case startLng = "start_lng"
        case time = "time"
        case toAddress = "to_address"
        case truckTypeId = "truck_type_id"
        case updatedAt = "updated_at"
        case matchesCount = "matches_found"
        case bookingRequestCount = "booking_request_count"
        case count = "count"
        case shipperId = "shipper_id"
        case time_difference = "time_difference"
        case offerPrice = "offer_price"
        case displayStatusMessage = "display_status_message"
        case driverDetail = "driver_details"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bidAmount = try? values.decodeIfPresent(String.self, forKey: .bidAmount)
        bookingId = try? values.decodeIfPresent(String.self, forKey: .bookingId)
        bookingInfo = try? values.decodeIfPresent(NewLoadData.self, forKey: .bookingInfo)
        createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        date = try? values.decodeIfPresent(String.self, forKey: .date)
        driverId = try? values.decodeIfPresent(String.self, forKey: .driverId)
        endLat = try? values.decodeIfPresent(String.self, forKey: .endLat)
        endLng = try? values.decodeIfPresent(String.self, forKey: .endLng)
        fromAddress = try? values.decodeIfPresent(String.self, forKey: .fromAddress)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        isBid = try? values.decodeIfPresent(Int.self, forKey: .isBid)
        loadStatus = try? values.decodeIfPresent(String.self, forKey: .loadStatus)
        startLat = try? values.decodeIfPresent(String.self, forKey: .startLat)
        startLng = try? values.decodeIfPresent(String.self, forKey: .startLng)
        time = try? values.decodeIfPresent(String.self, forKey: .time)
        toAddress = try? values.decodeIfPresent(String.self, forKey: .toAddress)
        truckTypeId = try? values.decodeIfPresent(Int.self, forKey: .truckTypeId)
        displayStatusMessage = try? values.decodeIfPresent(String.self, forKey: .displayStatusMessage)
        updatedAt = try? values.decodeIfPresent(String.self, forKey: .updatedAt)
        matchesCount = try? values.decodeIfPresent(Int.self, forKey: .matchesCount)
        bookingRequestCount = try? values.decodeIfPresent(Int.self, forKey: .bookingRequestCount)
        count = try? values.decodeIfPresent(Int.self, forKey: .count)
        shipperId = try? values.decodeIfPresent(Int.self, forKey: .shipperId)
        time_difference = try? values.decodeIfPresent(Int.self, forKey: .time_difference)
        offerPrice = try? values.decodeIfPresent(String.self, forKey: .offerPrice)
        driverDetail = try? values.decodeIfPresent(DriverDetail.self, forKey: .driverDetail)
    }
}
struct DriverDetail: Codable {
    
    var name: String?
    var id: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
    }
    init(id:Int?,name:String?){
        self.id = id
        self.name = name
    }
}
