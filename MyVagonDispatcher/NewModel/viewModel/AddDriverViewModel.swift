//
//  AddDriverViewModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 19/07/22.
//

import Foundation
import UIKit
class AddDriverViewModel{
    var VC : AddDriverVC? = nil
    func WebServiceImageUpload(images:[UIImage],uploadFor:DocumentType){
        Utilities.showHud()
        WebServiceSubClass.ImageUpload(imgArr: images, completion: { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                response?.data?.images?.forEach({ element in
                    self.VC?.setImage(image: images.first ?? UIImage(), name: response?.data?.images?.first ?? "")
                })
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        })
    }
    
    func callApiToAddDriver(reqModel: AddDriverReqModel){
        Utilities.ShowLoaderButtonInButton(Button: VC?.btnAddDriver ?? themeButton(), vc: VC ?? UIViewController())
        WebServiceSubClass.AddDriver(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.HideLoaderButtonInButton(Button: self.VC?.btnAddDriver ?? themeButton(), vc: self.VC ?? UIViewController())
            if status{
                self.VC?.driverAdded()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    Utilities.ShowAlertOfSuccess(OfMessage: apiMessage)
                }
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
    
    func callWebServiceToUpdateDriver(reqModel: AddDriverReqModel){
        Utilities.ShowLoaderButtonInButton(Button: VC?.btnAddDriver ?? themeButton(), vc: VC ?? UIViewController())
        WebServiceSubClass.updateDriver(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.HideLoaderButtonInButton(Button: self.VC?.btnAddDriver ?? themeButton(), vc: self.VC ?? UIViewController())
            if status{
                NotificationCenter.default.post(name: Notification.Name(rawValue: "refreshmyfleet"), object: nil)
                let viewController = self.VC?.navigationController?.viewControllers.first { $0 is MyFleetVC }
                guard let destinationVC = viewController else {  self.VC?.navigationController?.popViewController(animated: true)
                    return
                }
                self.VC?.navigationController?.popToViewController(destinationVC, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    Utilities.ShowAlertOfSuccess(OfMessage: apiMessage)
                }
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
}
