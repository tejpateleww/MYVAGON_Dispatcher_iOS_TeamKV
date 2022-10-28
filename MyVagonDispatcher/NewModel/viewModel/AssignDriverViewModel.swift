//
//  AssignDriverViewModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 29/08/22.
//

import Foundation
class AssignDriverViewModel{
    func callApiToAssignDriver(reqModel: AssignDriverReqModel, completion: @escaping () -> ()){
        Utilities.showHud()
        WebServiceSubClass.assignDriver(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    completion()
                    Utilities.ShowAlertOfSuccess(OfMessage: apiMessage)
                }
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
}
