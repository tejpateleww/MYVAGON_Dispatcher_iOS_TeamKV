//
//  WebServicesSubclass.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation
import UIKit
class WebServiceSubClass{


    //MARK: -Init
    class func InitApi(completion: @escaping (Bool,String,InitResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.Init.rawValue + "/" + kAPPVesion + "/" + "\(SingletonClass.sharedInstance.DispatcherProfileData?.id ?? 0)", responseModel: InitResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Init
       class func SystemDateTime(completion: @escaping (Bool,String,SystemDateResModel?,Any) -> ()){
           Utilities.showHud()
           URLSessionRequestManager.makeGetRequest(urlString: ApiKey.SystemDateTime.rawValue , responseModel: SystemDateResModel.self) { (status, message, response, error) in
//               Utilities.hidreHud()
            if status{
                SingletonClass.sharedInstance.SystemDate = response?.data ?? ""
            }
               completion(status, message, response, error)
           }
       }
       
    
    
    //MARK: -Login
    class func Login(reqModel: LoginReqModel, completion: @escaping (Bool,String,LoginResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.Login.rawValue, requestModel: reqModel, responseModel: LoginResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -Forgot Password
    class func ForgotPasswordOTP(reqModel: ForgotPasswordReqModel, completion: @escaping (Bool,String,VerifyResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.forgotpassword.rawValue, requestModel: reqModel, responseModel: VerifyResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -ResetNewPassword
    class func ResetNewPassword(reqModel: ResetNewPasswordReqModel, completion: @escaping (Bool,String,GeneralMessageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.ResetPassword.rawValue, requestModel: reqModel, responseModel: GeneralMessageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -ChangePassword
    class func ChangePassword(reqModel: ChangePasswordReqModel, completion: @escaping (Bool,String,GeneralMessageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.ChangePassword.rawValue, requestModel: reqModel, responseModel: GeneralMessageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: - ShipperDetail
    class func ShipperDetail(shipperID: String,completion: @escaping (Bool,String,ReviewResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.shipperDetail.rawValue + "/\(shipperID)", responseModel: ReviewResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -PostTruck
    class func PostTruck(reqModel: PostTruckReqModel, completion: @escaping (Bool,String,PostTruckResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.PostAvailability.rawValue, requestModel: reqModel, responseModel: PostTruckResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -Settings
    class func Settings(reqModel: SettingsReqModel, completion: @escaping (Bool,String,SettingsResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.Settings.rawValue, requestModel: reqModel, responseModel: SettingsResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -GetSettings
    class func GetSettings(reqModel: GetSettingsListReqModel, completion: @escaping (Bool,String,SettingsGetResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.GetSettings.rawValue, requestModel: reqModel, responseModel: SettingsGetResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -VerifyEmail
    class func VerifyEmail(reqModel: EmailVerifyReqModel, completion: @escaping (Bool,String,VerifyResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.EmailVerify.rawValue, requestModel: reqModel, responseModel: VerifyResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -VerifyPhone
    class func VerifyPhone(reqModel: MobileVerifyReqModel, completion: @escaping (Bool,String,VerifyResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.PhoneNumberVerify.rawValue, requestModel: reqModel, responseModel: VerifyResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    //MARK:- Register
    class func Register(reqModel: RegisterReqModel, completion: @escaping (Bool,String,RegisterResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.Register.rawValue, requestModel: reqModel, responseModel: RegisterResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    //MARK: - Dispatcher Register
    class func DispatcherRegister(reqModel: RegistrationReqModel, completion: @escaping (Bool,String,RegisterResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.registration.rawValue, requestModel: reqModel, responseModel: RegisterResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    
    //MARK: -TruckType
    class func TruckType(completion: @escaping (Bool,String,TruckTypeListingResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.TruckTypeListing.rawValue, responseModel: TruckTypeListingResModel.self, language: true) { (status, message, response, error) in
            if status{
                SingletonClass.sharedInstance.TruckTypeList = response?.data
            }
            completion(status, message, response, error)
        }
    }
    
    //MARK: -PackageListing
    class func PackageListing(completion: @escaping (Bool,String,PackageListingResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.PackageListing.rawValue, responseModel: PackageListingResModel.self,language: true) { (status, message, response, error) in
            if status{
                SingletonClass.sharedInstance.PackageList = response?.data
            }
            completion(status, message, response, error)
        }
    }
    
    //MARK: -TruckUnit
    class func TruckUnit(completion: @escaping (Bool,String,TruckUnitResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.TruckUnitListing.rawValue, responseModel: TruckUnitResModel.self, language: true) { (status, message, response, error) in
            if status{
                SingletonClass.sharedInstance.TruckunitList = response?.data
            }
            completion(status, message, response, error)
        }
    }
    
    //MARK: -TruckFeatures
    class func TruckFeatures(completion: @escaping (Bool,String,TruckFeaturesResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.TruckFeatureListing.rawValue, responseModel: TruckFeaturesResModel.self, language: true) { (status, message, response, error) in
            if status{
                SingletonClass.sharedInstance.TruckFeatureList = response?.data
            }
            completion(status, message, response, error)
        }
    }
    
    //MARK: -TruckBrand
    class func TruckBrand(completion: @escaping (Bool,String,TruckBrandsResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.TruckBrandListing.rawValue, responseModel: TruckBrandsResModel.self, language: true) { (status, message, response, error) in
            if status{
                SingletonClass.sharedInstance.TruckBrandList = response?.data
            }
            completion(status, message, response, error)
        }
    }
    
    //MARK: - Cancellation Reasons
    class func cancellationReasoneList(completion: @escaping (Bool,String,CancellationReasoneResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.CancellationReason.rawValue, responseModel: CancellationReasoneResModel.self,language: true) { (status, message, response, error) in
            if status{
                SingletonClass.sharedInstance.cancellationReasons = response?.data
            }
            completion(status, message, response, error)
        }
    }
    
    //MARK: -TruckType
    class func stateList(completion: @escaping (Bool,String,DriverStateListResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.StateList.rawValue, responseModel: DriverStateListResModel.self, language: true) { (status, message, response, error) in
            if status{
                SingletonClass.sharedInstance.stateList = response?.data
            }
            completion(status, message, response, error)
        }
    }
    
    //MARK: -ImageUpload
    class func ImageUpload(imgArr:[UIImage], completion: @escaping (Bool,String,ImageUploadResModel?,Any) -> ()){
        
        URLSessionRequestManager.makeMultipleImageRequest(urlString: ApiKey.TempImageUpload.rawValue, requestModel: [String:String](), responseModel: ImageUploadResModel.self, imageKey: "images[]", arrImageData: imgArr) { status, message, response, error in
            completion(status, message, response, error)
        }
        
    }
    
    //MARK: -DocumentUpload
    class func DocumentUpload(Documents:[UploadMediaModel], completion: @escaping (Bool,String,ImageUploadResModel?,Any) -> ()){
        
        URLSessionRequestManager.makeMultipleMediaUploadRequest(urlString: ApiKey.TempImageUpload.rawValue, requestModel: [String:String](), responseModel: ImageUploadResModel.self, mediaArr: Documents) { status, message, response, error in
            completion(status, message, response, error)
        }
        
        
     
        
    }
    //MARK: -GetShipmentList
    class func GetShipmentList(reqModel: ShipmentListReqModel, completion: @escaping (Bool,String,SearchResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.SearchLoads.rawValue, requestModel: reqModel, responseModel: SearchResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
//    //MARK: -SearchShipemnet
//    class func SearchShipment(reqModel: SearchLoadReqModel, completion: @escaping (Bool,String,SearchResModel?,Any) -> ()){
//        URLSessionRequestManager.makePostRequest(urlString: ApiKey.SearchLoads.rawValue, requestModel: reqModel, responseModel: SearchResModel.self) { (status, message, response, error) in
//            completion(status, message, response, error)
//        }
//    }
    
    //MARK: -BookNow
    class func BookNow(reqModel: BookNowReqModel, completion: @escaping (Bool,String,GeneralMessageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.BookNow.rawValue, requestModel: reqModel, responseModel: GeneralMessageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -BidRequest
    class func BidRequest(reqModel: PostTruckBidReqModel, completion: @escaping (Bool,String,BidRequestResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.BidRequest.rawValue, requestModel: reqModel, responseModel: BidRequestResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    
    //MARK: -PostedTruckResult
    class func PostedTruckResult(reqModel: PostTruckBidReqModel, completion: @escaping (Bool,String,SearchResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.PostAvailabilityResult.rawValue, requestModel: reqModel, responseModel: SearchResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -AcceptReject
    class func AcceptReject(reqModel: BidAcceptRejectReqModel, completion: @escaping (Bool,String,BidRequestResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.BidRequestAcceptreject.rawValue, requestModel: reqModel, responseModel: BidRequestResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    //MARK: -RejectBookingRequest
    class func RejectBookingRequest(reqModel: BidAcceptRejectReqModel, completion: @escaping (Bool,String,BidRequestResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.RejectBookingRequest.rawValue, requestModel: reqModel, responseModel: BidRequestResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    //MARK: -BidPost
    class func BidPost(reqModel: BidReqModel, completion: @escaping (Bool,String,GeneralMessageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.BidPost.rawValue, requestModel: reqModel, responseModel: GeneralMessageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -GetMyLoadesList
    class func GetMyLoadesList(reqModel: MyLoadsReqModel, completion: @escaping (Bool,String,NewMyLodeDetailResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.MyLoades.rawValue, requestModel: reqModel, responseModel: NewMyLodeDetailResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    //MARK:- ProfileEdit
    class func ProfileEdit(reqModel: ProfileEditReqModel, completion: @escaping (Bool,String,NewLoginResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.ProfileUpdate.rawValue, requestModel: reqModel, responseModel: NewLoginResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- GetDriverList
    class func GetDriverList(reqModel: GetDriverListReqModel, completion: @escaping (Bool,String,DriverListResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.ManageDriver.rawValue, requestModel: reqModel, responseModel: DriverListResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -Settings
    class func PermissionSettings(reqModel: ChangePermissionReqModel, completion: @escaping (Bool,String,DriverPermissionChangeResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.ChangePermission.rawValue, requestModel: reqModel, responseModel: DriverPermissionChangeResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- ArrivedAtLocation
    class func ArrivedAtLocation(reqModel: ArraivedAtLocationReqModel, completion: @escaping (Bool,String,BookingLoadDetailsResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.ArrivedAtLocation.rawValue, requestModel: reqModel, responseModel: BookingLoadDetailsResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    //MARK:- StartLoading
    class func StartLoading(reqModel: StartLoadingReqModel, completion: @escaping (Bool,String,BookingLoadDetailsResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.StartLoading.rawValue, requestModel: reqModel, responseModel: BookingLoadDetailsResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    //MARK:- Cancel Bid
    class func CancelBidRequest(reqModel: CancelBidReqModel, completion: @escaping (Bool,String,GeneralMessageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.CancelRequest.rawValue, requestModel: reqModel, responseModel: GeneralMessageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    //MARK:- Delete Bid
    class func DeleteBidRequest(reqModel: CancelBidReqModel, completion: @escaping (Bool,String,GeneralMessageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.DeleteRequest.rawValue, requestModel: reqModel, responseModel: GeneralMessageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    //MARK:- CompleteTrip
    class func CompleteTrip(reqModel: CompleteTripReqModel, completion: @escaping (Bool,String,BookingLoadDetailsResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.CompleteTrip.rawValue, requestModel: reqModel, responseModel: BookingLoadDetailsResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    //MARK:- StartJourney
    class func StartJourney(reqModel: StartJourneyReqModel, completion: @escaping (Bool,String,BookingLoadDetailsResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.StartJourney.rawValue, requestModel: reqModel, responseModel: BookingLoadDetailsResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- UploadPOD
    class func UploadPOD(reqModel: UploadPODReqModel, completion: @escaping (Bool,String,BookingLoadDetailsResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.UploadPOD.rawValue, requestModel: reqModel, responseModel: BookingLoadDetailsResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- LoadDetails
    class func LoadDetails(reqModel: LoadDetailsReqModel, completion: @escaping (Bool,String,BookingLoadDetailsResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.BookingLoadDetails.rawValue, requestModel: reqModel, responseModel: BookingLoadDetailsResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- RateShipper
    class func RateShipper(reqModel: RateReviewReqModel, completion: @escaping (Bool,String,GeneralMessageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.RateShipper.rawValue, requestModel: reqModel, responseModel: GeneralMessageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -NotificationList
    class func NotificationList(completion: @escaping (Bool,String,NotificationListResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.NotificationList.rawValue, responseModel: NotificationListResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- RateShipper
    class func chatHistory(reqModel: chatMessageReqModel, completion: @escaping (Bool,String,ChatMessagesResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.chatMessages.rawValue, requestModel: reqModel, responseModel: ChatMessagesResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- chat list
    class func chatUserList(completion: @escaping (Bool,String,ChatUserListResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.chatUsers.rawValue, responseModel: ChatUserListResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Earning
    class func earningList(reqModel: EarningReqModel, completion: @escaping (Bool,String,EarningResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.statisticsDetail.rawValue, requestModel: reqModel, responseModel: EarningResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Accept Payment
    class func AcceptPayment(reqModel: AcceptPaymentReqModel, completion: @escaping (Bool,String,GeneralMessageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.acceptPayment.rawValue, requestModel: reqModel, responseModel: GeneralMessageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -getSupportAPI
    class func getSupportAPI(completion: @escaping (Bool,String,SupportResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.contactUs.rawValue, responseModel: SupportResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -StatiscticList
    class func StatisticListAPI(completion: @escaping (Bool,String,StatisticResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.statistics.rawValue, responseModel: StatisticResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -Payment Deatil API
    class func getPaymentDeatilAPI(completion: @escaping (Bool,String,PaymentDetailResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.getPaymentDetails.rawValue + "/\(SingletonClass.sharedInstance.DispatcherProfileData?.id ?? 0)", responseModel: PaymentDetailResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Update Payment Details
    class func updatePaymentDetail(reqModel: PaymentDetailUpdateReqModel, completion: @escaping (Bool,String,GeneralMessageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.updatePaymentDetails.rawValue, requestModel: reqModel, responseModel: GeneralMessageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: - LocationDetail
    class func LocationDetail(locationID: String,completion: @escaping (Bool,String,LocationDetailResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.locationDetail.rawValue + "/\(locationID)", responseModel: LocationDetailResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Update Personal Info
    class func editPersonalInfo(reqModel: EditPersonalInfoReqModel, completion: @escaping (Bool,String,NewLoginResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.updateBasicDetails.rawValue, requestModel: reqModel, responseModel: NewLoginResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Update Licence Details
    class func updateLicenceDetail(reqModel: EditLicenceDetailsReqModel, completion: @escaping (Bool,String,GeneralMessageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.updateLicenceDetails.rawValue, requestModel: reqModel, responseModel: GeneralMessageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: - edit tractor
    class func editTractorDetail(reqModel: EditTractorDetailReqModel, completion: @escaping (Bool,String,RegisterResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.tractorDetailEdit.rawValue, requestModel: reqModel, responseModel: RegisterResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: - edit truck
    class func editTruckDetail(reqModel: EditTruckReqModel, completion: @escaping (Bool,String,RegisterResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.editTruckDetail.rawValue, requestModel: reqModel, responseModel: RegisterResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: - Add Truck
    class func addTruck(reqModel: AddTruckReqModel, completion: @escaping (Bool,String,RegisterResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.addTruck.rawValue, requestModel: reqModel, responseModel: RegisterResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Related Match
    class func GetRelatedMatchList(reqModel: RelatedMatchReqModel, completion: @escaping (Bool,String,SearchResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.relatedMatch.rawValue, requestModel: reqModel, responseModel: SearchResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: - Start Trip
    class func StartTrip(reqModel: StartTripReqModel, completion: @escaping (Bool,String,StartTripResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.startTrip.rawValue, requestModel: reqModel, responseModel: StartTripResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: - Decline Load
    class func declineLoad(reqModel: CancelBookRequestReqModel, completion: @escaping (Bool,String,StartTripResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.cancelBookRequest.rawValue, requestModel: reqModel, responseModel: StartTripResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: - Remove Truck Detail
    class func removeTruckDetail(reqModel: RemoveTruckDetailReqModel, completion: @escaping (Bool,String,StartTripResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.removeTruckDetails.rawValue, requestModel: reqModel, responseModel: StartTripResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: - trash-posted-truck
    class func trashPostedTruck(reqModel: TrashPostedTruck, completion: @escaping (Bool,String,StartTripResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.trashPostedTruck.rawValue, requestModel: reqModel, responseModel: StartTripResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: - Make as default truck
    class func makeAsDefaultTruck(reqModel: MakeAsDefaultTruckReqModel, completion: @escaping (Bool,String,StartTripResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.makeAsDefaultTruck.rawValue, requestModel: reqModel, responseModel: StartTripResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // Logout Driver
    class func logOutDriver(completion: @escaping (Bool,String,InitResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.logOut.rawValue, responseModel: InitResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // getSetting
    class func getSetting(completion: @escaping (Bool,String,GetSettingResModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.driverGetSetting.rawValue, responseModel: GetSettingResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    // UpdateSetting
    class func updateSetting(reqModel: EditSettingsReqModel, completion: @escaping (Bool,String,GetSettingResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.driverEditSettings.rawValue, requestModel: reqModel, responseModel: GetSettingResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // UpdateSetting
    class func changeLanguage(reqModel: LanguageChangeReqModel, completion: @escaping (Bool,String,ChangeLanguageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.changeLanguage.rawValue, requestModel: reqModel, responseModel: ChangeLanguageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // DeleteUser
    class func deleteUser(reqModel: DeleteUserReqModel, completion: @escaping (Bool,String,ChangeLanguageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.deleteUser.rawValue, requestModel: reqModel, responseModel: ChangeLanguageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // UpdateCompany
    class func UpdateCompany(reqModel: UpdateCompanyDetailReqModel, completion: @escaping (Bool,String,ChangeLanguageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.updateCompany.rawValue, requestModel: reqModel, responseModel: ChangeLanguageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    //MARK: -getDriverList
    class func getDriverList(completion: @escaping (Bool,String,DispatcherDriverListResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.DreiverList.rawValue, responseModel: DispatcherDriverListResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // get Available Driver
    class func getAvailableDriverList(reqModel: AvailableDriverList, completion: @escaping (Bool,String,DispatcherDriverListResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.availableDriver.rawValue, requestModel: reqModel, responseModel: DispatcherDriverListResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    
    //MARK: -getTruckListList
    class func getTruckList(completion: @escaping (Bool,String,DispatcherTruckListResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.truckList.rawValue, responseModel: DispatcherTruckListResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK: -getTractorListList
    class func getTractorList(completion: @escaping (Bool,String,DispatcherTractorListResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.tractorList.rawValue, responseModel: DispatcherTractorListResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // Add Driver
    class func AddDriver(reqModel: AddDriverReqModel, completion: @escaping (Bool,String,ChangeLanguageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.addDriver.rawValue, requestModel: reqModel, responseModel: ChangeLanguageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // Add Tractor
    class func AddTractor(reqModel: AddTractorReqModel, completion: @escaping (Bool,String,ChangeLanguageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.addTractor.rawValue, requestModel: reqModel, responseModel: ChangeLanguageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // Update Tractor
    class func UpdateTractor(reqModel: AddTractorReqModel, completion: @escaping (Bool,String,ChangeLanguageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.UpdateTractor.rawValue, requestModel: reqModel, responseModel: ChangeLanguageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // Add Truck
    class func dispatcherAddTruck(reqModel: DispatcherAddTruckReqModel, completion: @escaping (Bool,String,ChangeLanguageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.DispatcherAddTruck.rawValue, requestModel: reqModel, responseModel: ChangeLanguageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // Update Truck
    class func dispatcherUpdateTruck(reqModel: DispatcherAddTruckReqModel, completion: @escaping (Bool,String,ChangeLanguageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.UpdateTruck.rawValue, requestModel: reqModel, responseModel: ChangeLanguageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //Update Driver
    class func updateDriver(reqModel: AddDriverReqModel, completion: @escaping (Bool,String,ChangeLanguageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.updateDriver.rawValue, requestModel: reqModel, responseModel: ChangeLanguageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //Driver Permission
    class func getPermission(reqModel: DriverPermissionReqModel, completion: @escaping (Bool,String,DriverPermissionResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.getPermission.rawValue, requestModel: reqModel, responseModel: DriverPermissionResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //Vehicle List
    class func getVehicleList(completion: @escaping (Bool,String,AvailableVehicleListResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.availableVehicle.rawValue, responseModel: AvailableVehicleListResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //Update Permission
    class func updatePermission(reqModel: UpdatePermissionReqModel, completion: @escaping (Bool,String,DriverPermissionResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.updatePermission.rawValue, requestModel: reqModel, responseModel: DriverPermissionResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //Assign Vehicle
    class func assignVehicle(reqModel: AssignVehicleReqModel, completion: @escaping (Bool,String,DriverPermissionResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.assignVehicle.rawValue, requestModel: reqModel, responseModel: DriverPermissionResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //ShipmentDetail
    class func GetShipmentDetail(reqModel: ShipmentDetailReqModel, completion: @escaping (Bool,String,ShipmentDetailResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.bookingDetail.rawValue, requestModel: reqModel, responseModel: ShipmentDetailResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // Assign driver
    class func assignDriver(reqModel: AssignDriverReqModel, completion: @escaping (Bool,String,ChangeLanguageResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.assignDriver.rawValue, requestModel: reqModel, responseModel: ChangeLanguageResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    // driver Loads
    class func getDriverLoads(reqModel: DriverLoadsReqModel, completion: @escaping (Bool,String,EarningResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.driverLoads.rawValue, requestModel: reqModel, responseModel: EarningResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Remove Vehicle
    class func removeVehicle(reqModel: RemoveVehicleReqModel, completion: @escaping (Bool,String,BookingLoadDetailsResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.removeVehicle.rawValue, requestModel: reqModel, responseModel: BookingLoadDetailsResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
}


