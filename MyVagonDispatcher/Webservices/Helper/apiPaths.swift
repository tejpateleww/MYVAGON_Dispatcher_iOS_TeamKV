//
//  apiPaths.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation

typealias NetworkRouterCompletion = ((Data?,[String:Any]?, Bool) -> ())

enum APIEnvironment  {
 
    static var environment: Environment{
        return .Development
    }
    
    static var socketBaseURL : String {
        if APIEnvironment.environment.rawValue == Environment.Development.rawValue {
            return BaseURLS.DevelopmentSocketBaseURL.rawValue
        } else {
            return BaseURLS.LiveSocketBaseURL.rawValue
        }
    }
    
    static var PODImageURL : String {
        if environment.rawValue == Environment.Development.rawValue {
            return BaseURLS.PODImageURL.rawValue
        } else {
            return BaseURLS.PODImageURL.rawValue
        }
    }
    
    static var dispatcherDriverImageURL : String {
        if environment.rawValue == Environment.Development.rawValue {
            return BaseURLS.driverImage.rawValue
        } else {
            return BaseURLS.driverImage.rawValue
        }
    }
 
    static var tempURL : String {
        if environment.rawValue == Environment.Development.rawValue {
            return BaseURLS.devlopmentProfile.rawValue
        } else {
            return BaseURLS.liveProfile.rawValue
        }
    }
    
    static var TempProfileURL : String {
        if environment.rawValue == Environment.Development.rawValue {
            return BaseURLS.TempProfileURL.rawValue
        } else {
            return BaseURLS.tempLiveProfile.rawValue
        }
    }
    
    static var ShipperImageURL : String {
        if environment.rawValue == Environment.Development.rawValue {
            return BaseURLS.ShipperImageURL.rawValue
        } else {
            return BaseURLS.ShipperImageURL.rawValue
        }
    }
    
    static var DriverImageURL : String {
        if environment.rawValue == Environment.Development.rawValue {
            return BaseURLS.DriverImageURL.rawValue
        } else {
            return BaseURLS.DriverImageURL.rawValue
        }
    }
    
    static var baseURL : String {
        if environment.rawValue == Environment.Development.rawValue {
            return BaseURLS.DevelopmentServer.rawValue
        } else {
            return BaseURLS.LiveServer.rawValue
        }
    }
    
    static var profileBaseURL : String {
        if environment.rawValue == Environment.Development.rawValue {
            return BaseURLS.Copydevelopement.rawValue
        } else {
            return BaseURLS.CopyLiveServer.rawValue
        } 
    }
   
    static var BearerHeader : String {
        if UserDefault.bool(forKey: UserDefaultsKey.isUserLogin.rawValue)  {
            if UserDefault.object(forKey:  UserDefaultsKey.userProfile.rawValue) != nil {
                do {
                    let _ = UserDefault.getUserData()
                    return "Bearer \(SingletonClass.sharedInstance.DispatcherProfileData?.token ?? "")"
                }
            }
        }
        return ""
    }
    
    static var headers : [String:String]{
        let langCode = Localize.currentLanguage()
        if UserDefault.bool(forKey: UserDefaultsKey.isUserLogin.rawValue) {
            if UserDefault.object(forKey:  UserDefaultsKey.userProfile.rawValue) != nil {
                do {
                    let _ = UserDefault.getUserData()
                    return [UrlConstant.Localization : langCode,UrlConstant.AppAuthentication : UrlConstant.AppAuthenticationValue, UrlConstant.XApiKey : "Bearer \(SingletonClass.sharedInstance.DispatcherProfileData?.token ?? "")"]
                }
            }
        }
        return [UrlConstant.Localization : langCode,UrlConstant.AppAuthentication : UrlConstant.AppAuthenticationValue,UrlConstant.HeaderKey : UrlConstant.AppHostKey]
    }
}

enum ApiKey: String {
    case Init                                   = "dispatcher/init/ios_carrier"
    case Login                                  = "dispatcher/login"
    case forgotpassword                         = "dispatcher/forgot-password"
    case ResetPassword                          = "password/reset"
    case ChangePassword                         = "dispatcher/change-password"
    case PostAvailability                       = "dispatcher/post-availability"
    case Settings                               = "driver/settings"
    case GetSettings                            = "driver/get/settings"
    case Register                               = "driver/register_new"
    case ProfileUpdate                          = "driver/profile/update"
    case EmailVerify                            = "email/verify"
    case PhoneNumberVerify                      = "phone/verify"
    case TempImageUpload                        = "dispatcher/image/upload"
    case TruckTypeListing                       = "truck/type/listing"
    case StateList                              = "dispatcher/get_states"
    case TruckBrandListing                      = "truck/brands"
    case TruckFeatureListing                    = "truck/features"
    case TruckUnitListing                       = "truck/unit"
    case CancellationReason                     = "cancellation-reasons"
    case PackageListing                         = "package/listing"
    case ShipmentList                           = "shipment/search"
    case SearchLoads                            = "dispatcher/search-loads"
    case BookNow                                = "dispatcher/post-book"
    case BidRequest                             = "dispatcher/bid-requests"
    case PostAvailabilityResult                 = "dispatcher/matches-found"
    case BidRequestAcceptreject                 = "dispatcher/accept-decline-bid-request"
    case SystemDateTime                         = "system-date-time"
    case RejectBookingRequest                   = "RejectBookingRequest"
    case MyLoades                               = "dispatcher/my-loads-new"
    case BidPost                                = "dispatcher/post-bid"
    case ManageDriver                           = "dispature/manage-drivers"
    case ChangePermission                       = "dispature/edit-permission"
    case BookingLoadDetails                     = "booking-load-detail"
    case ArrivedAtLocation                      = "arrived-at-location"
    case StartLoading                           = "start-loading"
    case StartJourney                           = "start-journey"
    case CompleteTrip                           = "complete-trip"
    case UploadPOD                              = "dispatcher/upload-pod"
    case RateShipper                            = "dispatcher/review-rating"
    case NotificationList                       = "dispatcher/notification-list"
    case CancelRequest                          = "dispatcher/cancel-bid-request"
    case DeleteRequest                          = "dispatcher/cancel-request"
    case chatMessages                           = "dispatcher/chat-messages"
    case chatUsers                              = "dispatcher/chat-users"
    case statisticsDetail                       = "statistics-detail"
    case acceptPayment                          = "dispatcher/accept-payment"
    case contactUs                              = "contact-us"
    case statistics                             = "dispatcher/statistics"
    case getPaymentDetails                      = "get-payment-details"
    case updatePaymentDetails                   = "dispatcher/update-bank"
    case shipperDetail                          = "shipper-detail"
    case locationDetail                         = "location-details"
    case updateBasicDetails                     = "dispatcher/update-personal"
    case updateLicenceDetails                   = "update-personal-details"
    case tractorDetailEdit                      = "update-tractor-details"
    case editTruckDetail                        = "update-truck-details"
    case addTruck                               = "add-truck-details"
    case relatedMatch                           = "dispatcher/related-matches"
    case startTrip                              = "start-trip"
    case cancelBookRequest                      = "dispatcher/cancel-book-request"
    case removeTruckDetails                     = "remove-truck-details"
    case trashPostedTruck                       = "dispatcher/trash-posted-truck"
    case makeAsDefaultTruck                     = "make-as-default-truck"
    case logOut                                 = "dispatcher/logout"
    case driverGetSetting                       = "dispatcher/get-settings"
    case driverEditSettings                     = "dispatcher/edit-settings"
    case changeLanguage                         = "dispatcher/change-language"
    case deleteUser                             = ""
    case registration                           = "dispatcher/register"
    case updateCompany                          = "dispatcher/update-company"
    case DreiverList                            = "dispatcher/get-driver"
    case addDriver                              = "dispatcher/add-driver"
    case availableDriver                        = "dispatcher/get-driver-booking"
    case updateDriver                           = "dispatcher/update-driver"
    case truckList                              = "dispatcher/get-all-truck"
    case tractorList                            = "dispatcher/get-all-tractor"
    case addTractor                             = "dispatcher/add-tractor"
    case DispatcherAddTruck                     = "dispatcher/add-truck"
    case UpdateTractor                          = "dispatcher/update-tractor"
    case UpdateTruck                            = "dispatcher/update-truck"
    case getPermission                          = "dispatcher/get-driver-permission"
    case availableVehicle                       = "dispatcher/get-available-vehicle"
    case updatePermission                       = "dispatcher/update-driver-permission"
    case assignVehicle                          = "dispatcher/assign-vehicle"
    case bookingDetail                          = "dispatcher/booking-detail"
    case assignDriver                           = "dispatcher/load-assign-driver"
    case driverLoads                            = "dispatcher/driver-loads"
    case removeVehicle                          = "dispatcher/remove-assign-vehicle"
}

enum socketApiKeys : String {
    case driverConnect = "driver_connect"
    case updateLocation = "update_location"
    case startTrip = "start_trip"
    case HideAtPickup = "hide_at_pickup"

    //Chat
    case SendMessage                              = "send_message"
    case ReceiverMessage                          = "new_message"
}

enum BaseURLS:String {
    case TempProfileURL = "http://3.66.160.72/public/temp/"
    case tempLiveProfile = "http://13.36.112.48/public/temp/"
    case ShipperImageURL = "https://myvagon.s3.eu-west-3.amazonaws.com/shipper/"
    case DriverImageURL = "https://myvagon.s3.eu-west-3.amazonaws.com/profile/"
    case PODImageURL = "https://myvagon.s3.eu-west-3.amazonaws.com/POD/"
    case driverImage = "https://myvagon.s3.eu-west-3.amazonaws.com/driver/"
    
    //App urls
    case DevelopmentServer = "http://3.66.160.72/api/"
    case Copydevelopement = "http://3.66.160.72/"
    case devlopmentProfile = "http://3.66.160.72/temp/"
    case liveProfile = "http://13.36.112.48/temp/"
    case LiveServer = "http://13.36.112.48/api/"
    case CopyLiveServer = "http://13.36.112.48/"
    //socket
    case LiveSocketBaseURL = "http://13.36.112.48:3000"
    case DevelopmentSocketBaseURL = "http://3.66.160.72:3000"
}

enum Environment : String {
    case Development
    case Live
}

