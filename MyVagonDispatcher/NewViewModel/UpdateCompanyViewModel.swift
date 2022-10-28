//
//  UpdateCompanyViewModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 08/07/22.
//

import Foundation
class UpdateCompanyViewModel{
    
    func callWebServiceForUpdateCompany(reqModel: UpdateCompanyDetailReqModel){
        WebServiceSubClass.UpdateCompany(reqModel: reqModel) { (status, apiMessage, response, error) in
            if status{
                AppDelegate.shared.Logout()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Utilities.ShowAlertOfSuccess(OfMessage: apiMessage)
                }
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
}
