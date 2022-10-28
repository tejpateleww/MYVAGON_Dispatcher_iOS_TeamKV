//
//  RegistrationViewModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 06/07/22.
//

import Foundation
import UIKit
class RegistrationViewModel{
    
    var paymantVC : PaymentsVC? = nil
    func callWebServicforDispatcherDriverRegister(reqModel: RegistrationReqModel){
        Utilities.ShowLoaderButtonInButton(Button: paymantVC?.btnSave ?? themeButton(), vc: paymantVC ?? UIViewController())
        WebServiceSubClass.DispatcherRegister(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.HideLoaderButtonInButton(Button: self.paymantVC?.btnSave ?? themeButton(), vc: self.paymantVC ?? UIViewController())
            if status{
                Utilities.ShowAlertOfSuccess(OfMessage: apiMessage)
                UserDefault.removeObject(forKey: UserDefaultsKey.RegisterData.rawValue)
                SingletonClass.sharedInstance.clearSingletonClassForRegister()
                appDel.NavigateToLogin()
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
}
