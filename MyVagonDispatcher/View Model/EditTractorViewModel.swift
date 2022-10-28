//
//  EditTractorViewModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 16/03/22.
//

import Foundation
import UIKit

class EditTractorDetailViewModel{
    var tractorVc : TractorDetailVC?
    func callwebservice(reqModel: EditTractorDetailReqModel){
        Utilities.ShowLoaderButtonInButton(Button: tractorVc?.btnSave ?? themeButton(), vc: tractorVc ?? UIViewController())
        WebServiceSubClass.editTractorDetail(reqModel: reqModel) {(status, apiMessage, response, error) in
            Utilities.HideLoaderButtonInButton(Button: self.tractorVc?.btnSave ?? themeButton(), vc: self.tractorVc ?? UIViewController())
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
    
    func callWebServiceToAddTractor(reqModel:AddTractorReqModel){
        Utilities.ShowLoaderButtonInButton(Button: tractorVc?.btnSave ?? themeButton(), vc: tractorVc ?? UIViewController())
        WebServiceSubClass.AddTractor(reqModel: reqModel) {(status, apiMessage, response, error) in
            Utilities.HideLoaderButtonInButton(Button: self.tractorVc?.btnSave ?? themeButton(), vc: self.tractorVc ?? UIViewController())
            if status{
                self.tractorVc?.tractorAdded()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    Utilities.ShowAlertOfSuccess(OfMessage: apiMessage)
                }
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
    
    func callWebServiceToUpdateTractor(reqModel:AddTractorReqModel){
        Utilities.ShowLoaderButtonInButton(Button: tractorVc?.btnSave ?? themeButton(), vc: tractorVc ?? UIViewController())
        WebServiceSubClass.UpdateTractor(reqModel: reqModel){(status, apiMessage, response, error) in
            Utilities.HideLoaderButtonInButton(Button: self.tractorVc?.btnSave ?? themeButton(), vc: self.tractorVc ?? UIViewController())
            if status{
                self.tractorVc?.tractorAdded()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    Utilities.ShowAlertOfSuccess(OfMessage: apiMessage)
                }
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
}
