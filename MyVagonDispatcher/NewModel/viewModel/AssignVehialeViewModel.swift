//
//  AssignVehicleViewModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 27/07/22.
//

import Foundation
import UIKit

class AssignVehicleViewModel{
    var VC : AssignVehicalVC? = nil
    
    func callWebServiceForVehicleList(){
        Utilities.showHud()
        WebServiceSubClass.getVehicleList(completion: { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.VC?.VehicleData = response?.data
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        })
    }
    
    func callWebServiceToAssignVehicle(reqModel:AssignVehicleReqModel){
        Utilities.ShowLoaderButtonInButton(Button: VC?.btnAssign ?? themeButton(), vc: VC ?? UIViewController())
        WebServiceSubClass.assignVehicle(reqModel: reqModel, completion: { (status, apiMessage, response, error) in
            Utilities.HideLoaderButtonInButton(Button: self.VC?.btnAssign ?? themeButton(), vc: self.VC ?? UIViewController())
            if status{
                NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshmyfleet"), object: nil)
                let viewController = self.VC?.navigationController?.viewControllers.first { $0 is MyFleetVC }
                guard let destinationVC = viewController else {  self.VC?.navigationController?.popViewController(animated: true)
                    return
                }
                self.VC?.navigationController?.popToViewController(destinationVC, animated: true)
                
                Utilities.ShowAlertOfSuccess(OfMessage: apiMessage)
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        })
    }
}
