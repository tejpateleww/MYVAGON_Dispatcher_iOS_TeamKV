//
//  DriverLoadViewModel.swift
//  MyVagonDispatcher
//
//  Created by Dhananjay  on 06/09/22.
//

import Foundation
import UIKit
class DriverLoadViewModel{
    var vc: DriverLoadsVC?
    func getDriverLoads(reqModel:DriverLoadsReqModel){
        Utilities.showHud()
        WebServiceSubClass.getDriverLoads(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            DispatchQueue.main.async {
                self.vc?.refreshControl.endRefreshing()
            }
            if status{
                self.vc?.isLoading = false
                self.vc?.arrDriverLoads = response?.data ?? []
                self.vc?.tblDriverLoads.reloadData()
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
}
