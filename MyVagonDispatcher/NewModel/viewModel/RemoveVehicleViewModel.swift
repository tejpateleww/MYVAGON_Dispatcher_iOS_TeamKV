//
//  RemoveVehicleViewModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 27/09/22.
//

import Foundation
import UIKit
class RemoveVehicleViewModel{
    var vc: DriverPermissionVC?
    func removeVehicle(reqModel:RemoveVehicleReqModel){
        Utilities.showHud()
        WebServiceSubClass.removeVehicle(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    Utilities.ShowAlertOfSuccess(OfMessage: apiMessage)
                })
                NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshmyfleet"), object: nil)
                let viewController = self.vc?.navigationController?.viewControllers.first { $0 is MyFleetVC }
                guard let destinationVC = viewController else {  self.vc?.navigationController?.popViewController(animated: true)
                    return
                }
                self.vc?.navigationController?.popToViewController(destinationVC, animated: true)
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
}
