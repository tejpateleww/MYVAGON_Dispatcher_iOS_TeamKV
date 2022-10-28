//
//  ShipmentDetailViewModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 05/08/22.
//

import Foundation
import UIKit
class ShipmentDetailViewModel{
    
    func getShipmentDetail(reqModel:ShipmentDetailReqModel,DisplayStatus:String){
        Utilities.showHud()
        WebServiceSubClass.GetShipmentDetail(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                let controller = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: ScheduleDetailVC.storyboardID) as! ScheduleDetailVC
                controller.strLoadStatus = DisplayStatus
                controller.hidesBottomBarWhenPushed = true
                controller.LoadDetails = response?.data
                UIApplication.topViewController()?.navigationController?.pushViewController(controller, animated: true)
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
}
