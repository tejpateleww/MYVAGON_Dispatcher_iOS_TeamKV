//
//  DriverPermissionViewModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 27/07/22.
//

import Foundation
class DriverPermissionViewModel{
    var VC : DriverPermissionVC? = nil
    
    func callWebServiceToGetPermmision(reqModel:DriverPermissionReqModel){
        Utilities.showHud()
        WebServiceSubClass.getPermission(reqModel: reqModel, completion: { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.VC?.arrPermission = response?.data
                self.VC?.tblDriverPermission.reloadData()
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        })
    }
    
    func callWebServiceToUpdatePermmision(reqModel:UpdatePermissionReqModel){
        Utilities.showHud()
        WebServiceSubClass.updatePermission(reqModel: reqModel, completion: { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.VC?.arrPermission = response?.data
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
            self.VC?.tblDriverPermission.reloadData()
        })
    }
}
