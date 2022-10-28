//
//  DriverListResModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 19/07/22.
//

import Foundation
struct DispatcherDriverListResModel: Codable {

    let status: Bool?
    let message: String?
    let data: [DispaterDriver]?

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(Bool.self, forKey: .status)
        message = try? values.decodeIfPresent(String.self, forKey: .message)
        data = try? values.decodeIfPresent([DispaterDriver].self, forKey: .data)
    }

}
struct DispaterDriver: Codable {

    let id: Int?
    let name: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let profile: String?
    let phone: String?
    let countryCode: String?
    let selfDes: String?
    let type: String?
    let companyRefId: Int?
    let companyName: String?
    let postcode: String?
    let city: String?
    let state: String?
    let country: Int?
    let companyPhone: String?
    let emailVerifiedAt: String?
    let status: Int?
    let blockStatus: String?
    let stage: String?
    let licenceNumber: String?
    let licenceExpiryDate: String?
    let busy: Int?
    let isAssing: Int?
    let paymentType: Int?
    let companyAddress: String?
    let lng: String?
    let createdAt: String?
    let updatedAt: String?
    let lastSession: String?
    let vat: String?
    let ssn: String?
    let emailVerify: Int?
    let phoneVerify: Int?
    let commissionFee: String?
    let shipperRating: Int?
    let noOfShipperRated: Int?
    let driverRating: String?
    let noOfDriverRated: Int?
    let driverVehicle: DriverVehicle?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case profile = "profile"
        case phone = "phone"
        case countryCode = "country_code"
        case selfDes = "self_des"
        case type = "type"
        case companyRefId = "company_ref_id"
        case companyName = "company_name"
        case postcode = "postcode"
        case city = "city"
        case state = "state"
        case country = "country"
        case companyPhone = "company_phone"
        case emailVerifiedAt = "email_verified_at"
        case status = "status"
        case blockStatus = "block_status"
        case stage = "stage"
        case licenceNumber = "licence_number"
        case licenceExpiryDate = "licence_expiry_date"
        case busy = "busy"
        case isAssing = "is_assing"
        case paymentType = "payment_type"
        case companyAddress = "company_address"
        case lng = "lng"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lastSession = "last_session"
        case vat = "vat"
        case ssn = "ssn"
        case emailVerify = "email_verify"
        case phoneVerify = "phone_verify"
        case commissionFee = "commission_fee"
        case shipperRating = "shipper_rating"
        case noOfShipperRated = "no_of_shipper_rated"
        case driverRating = "driver_rating"
        case noOfDriverRated = "no_of_driver_rated"
        case driverVehicle = "driver_vehicle"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        firstName = try? values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try? values.decodeIfPresent(String.self, forKey: .lastName)
        email = try? values.decodeIfPresent(String.self, forKey: .email)
        profile = try? values.decodeIfPresent(String.self, forKey: .profile)
        phone = try? values.decodeIfPresent(String.self, forKey: .phone)
        countryCode = try? values.decodeIfPresent(String.self, forKey: .countryCode)
        selfDes = try? values.decodeIfPresent(String.self, forKey: .selfDes)
        type = try? values.decodeIfPresent(String.self, forKey: .type)
        companyRefId = try? values.decodeIfPresent(Int.self, forKey: .companyRefId)
        companyName = try? values.decodeIfPresent(String.self, forKey: .companyName)
        postcode = try? values.decodeIfPresent(String.self, forKey: .postcode)
        city = try? values.decodeIfPresent(String.self, forKey: .city)
        state = try? values.decodeIfPresent(String.self, forKey: .state)
        country = try? values.decodeIfPresent(Int.self, forKey: .country)
        companyPhone = try? values.decodeIfPresent(String.self, forKey: .companyPhone)
        emailVerifiedAt = try? values.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
        status = try? values.decodeIfPresent(Int.self, forKey: .status)
        blockStatus = try? values.decodeIfPresent(String.self, forKey: .blockStatus)
        stage = try? values.decodeIfPresent(String.self, forKey: .stage)
        licenceNumber = try? values.decodeIfPresent(String.self, forKey: .licenceNumber)
        licenceExpiryDate = try? values.decodeIfPresent(String.self, forKey: .licenceExpiryDate)
        busy = try? values.decodeIfPresent(Int.self, forKey: .busy)
        isAssing = try? values.decodeIfPresent(Int.self, forKey: .isAssing)
        paymentType = try? values.decodeIfPresent(Int.self, forKey: .paymentType)
        companyAddress = try? values.decodeIfPresent(String.self, forKey: .companyAddress)
        lng = try? values.decodeIfPresent(String.self, forKey: .lng)
        createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try? values.decodeIfPresent(String.self, forKey: .updatedAt)
        lastSession = try? values.decodeIfPresent(String.self, forKey: .lastSession)
        vat = try? values.decodeIfPresent(String.self, forKey: .vat)
        ssn = try? values.decodeIfPresent(String.self, forKey: .ssn)
        emailVerify = try? values.decodeIfPresent(Int.self, forKey: .emailVerify)
        phoneVerify = try? values.decodeIfPresent(Int.self, forKey: .phoneVerify)
        commissionFee = try? values.decodeIfPresent(String.self, forKey: .commissionFee)
        shipperRating = try? values.decodeIfPresent(Int.self, forKey: .shipperRating)
        noOfShipperRated = try? values.decodeIfPresent(Int.self, forKey: .noOfShipperRated)
        driverRating = try? values.decodeIfPresent(String.self, forKey: .driverRating)
        noOfDriverRated = try? values.decodeIfPresent(Int.self, forKey: .noOfDriverRated)
        driverVehicle = try? values.decodeIfPresent(DriverVehicle.self, forKey: .driverVehicle)
    }

}
struct DriverVehicle: Codable {

    let id: Int?
    let userId: Int?
    let dispatcherVehicleId: Int?
    let tractorId: Int?
    let truckId: Int?
    let truckType: TruckType?
    let truckSubCategory: TruckSubCategory?
    let weight: String?
    let weightUnit: WeightUnit?
    let loadCapacity: String?
    let loadCapacityUnit: LoadCapacityUnit?
    let brand: Brand?
    let capacityPallets: String?
    let pallets: Int?
    let fuelType: String?
    let truckFeatures: String?
    let registrationNo: String?
    let trailerRegistrationNo: String?
    let images: String?
    let idProof: String?
    let license: String?
    let licenseBack: String?
    let isAssing: Int?
    let createdAt: String?
    let vehicleCapacity: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case dispatcherVehicleId = "dispatcher_vehicle_id"
        case tractorId = "tractor_id"
        case truckId = "truck_id"
        case truckType = "truck_type"
        case truckSubCategory = "truck_sub_category"
        case weight = "weight"
        case weightUnit = "weight_unit"
        case loadCapacity = "load_capacity"
        case loadCapacityUnit = "load_capacity_unit"
        case brand = "brand"
        case capacityPallets = "capacity_pallets"
        case pallets = "pallets"
        case fuelType = "fuel_type"
        case truckFeatures = "truck_features"
        case registrationNo = "registration_no"
        case trailerRegistrationNo = "trailer_registration_no"
        case images = "images"
        case idProof = "id_proof"
        case license = "license"
        case licenseBack = "license_back"
        case isAssing = "is_assing"
        case createdAt = "created_at"
        case vehicleCapacity = "vehicle_capacity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        userId = try? values.decodeIfPresent(Int.self, forKey: .userId)
        dispatcherVehicleId = try? values.decodeIfPresent(Int.self, forKey: .dispatcherVehicleId)
        tractorId = try? values.decodeIfPresent(Int.self, forKey: .tractorId)
        truckId = try? values.decodeIfPresent(Int.self, forKey: .truckId)
        truckType = try? values.decodeIfPresent(TruckType.self, forKey: .truckType)
        truckSubCategory = try? values.decodeIfPresent(TruckSubCategory.self, forKey: .truckSubCategory)
        weight = try? values.decodeIfPresent(String.self, forKey: .weight)
        weightUnit = try? values.decodeIfPresent(WeightUnit.self, forKey: .weightUnit)
        loadCapacity = try? values.decodeIfPresent(String.self, forKey: .loadCapacity)
        loadCapacityUnit = try? values.decodeIfPresent(LoadCapacityUnit.self, forKey: .loadCapacityUnit)
        brand = try? values.decodeIfPresent(Brand.self, forKey: .brand)
        capacityPallets = try? values.decodeIfPresent(String.self, forKey: .capacityPallets)
        pallets = try? values.decodeIfPresent(Int.self, forKey: .pallets)
        fuelType = try? values.decodeIfPresent(String.self, forKey: .fuelType)
        truckFeatures = try? values.decodeIfPresent(String.self, forKey: .truckFeatures)
        registrationNo = try? values.decodeIfPresent(String.self, forKey: .registrationNo)
        trailerRegistrationNo = try? values.decodeIfPresent(String.self, forKey: .trailerRegistrationNo)
        images = try? values.decodeIfPresent(String.self, forKey: .images)
        idProof = try? values.decodeIfPresent(String.self, forKey: .idProof)
        license = try? values.decodeIfPresent(String.self, forKey: .license)
        licenseBack = try? values.decodeIfPresent(String.self, forKey: .licenseBack)
        isAssing = try? values.decodeIfPresent(Int.self, forKey: .isAssing)
        createdAt = try? values.decodeIfPresent(String.self, forKey: .createdAt)
        vehicleCapacity = try? values.decodeIfPresent(String.self, forKey: .vehicleCapacity)
    }

}

struct WeightUnit: Codable {

    let id: Int?
    let n: String?
    let name: String?
    let nameGreek: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case n = "n"
        case name = "name"
        case nameGreek = "name_greek"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        n = try? values.decodeIfPresent(String.self, forKey: .n)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        nameGreek = try? values.decodeIfPresent(String.self, forKey: .nameGreek)
    }
    
    func getName() -> String{
        if (UserDefaults.standard.string(forKey: LCLCurrentLanguageKey) ?? "el" == "el"){
            return nameGreek ?? ""
        }else{
            return name ?? ""
        }
    }

}
struct LoadCapacityUnit: Codable {

    let id: Int?
    let n: String?
    let name: String?
    let nameGreek: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case n = "n"
        case name = "name"
        case nameGreek = "name_greek"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        n = try? values.decodeIfPresent(String.self, forKey: .n)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        nameGreek = try? values.decodeIfPresent(String.self, forKey: .nameGreek)
    }
    
    func getName() -> String{
        if (UserDefaults.standard.string(forKey: LCLCurrentLanguageKey) ?? "el" == "el"){
            return nameGreek ?? ""
        }else{
            return name ?? ""
        }
    }

}
struct Brand: Codable {

    let id: Int?
    let name: String?
    let nameGreek: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case nameGreek = "name_greek"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        nameGreek = try? values.decodeIfPresent(String.self, forKey: .nameGreek)
    }
    
    func getName() -> String{
        if (UserDefaults.standard.string(forKey: LCLCurrentLanguageKey) ?? "el" == "el"){
            return nameGreek ?? ""
        }else{
            return name ?? ""
        }
    }

}
