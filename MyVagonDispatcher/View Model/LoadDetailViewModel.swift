//
//  LoadDetailViewModel.swift
//  MyVagonDispatcher
//
//  Created by Apple on 30/11/21.
//

import Foundation
import UIKit
class LoadDetailViewModel {
    weak var loadDetailsVC : SearchDetailVC? = nil
    weak var commonAcceptRejectPopupVC : ConfirmPopupVC? = nil
    
    func BookNow(ReqModel:BookNowReqModel){
        Utilities.ShowLoaderButtonInButton(Button: commonAcceptRejectPopupVC?.BtnRight ?? themeButton(), vc: commonAcceptRejectPopupVC ?? UIViewController())
      
        WebServiceSubClass.BookNow(reqModel: ReqModel, completion: { (status, apiMessage, response, error) in
            Utilities.HideLoaderButtonInButton(Button: self.commonAcceptRejectPopupVC?.BtnRight ?? themeButton(), vc: self.commonAcceptRejectPopupVC ?? UIViewController())
            self.commonAcceptRejectPopupVC?.dismiss(animated: true, completion: nil)
            if status {
                self.loadDetailsVC?.openReloadView(strTitle: apiMessage,isFromRelode: self.loadDetailsVC?.isFromRelated ?? false,driverID: ReqModel.driver_id ?? "")
            } else {
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        })
    }
}

