//
//  MyFleetViewModel.swift
//  MyVagonDispatcher
//
//  Created by Dhanajay  on 19/07/22.
//

import Foundation
class MyFleetViewModel{
    
    var VC : MyFleetVC? = nil
    var myEarningVC : MyEarningVC? = nil
    func getDriverList(){
        WebServiceSubClass.getDriverList { (status, apiMessage, response, error) in
            DispatchQueue.main.async {
                self.VC?.refreshControl.endRefreshing()
            }
            if status {
                self.VC?.arrDriver = response?.data ?? []
                if self.VC?.tabTypeSelection == .Drivers{
                    self.VC?.isLoading = false
                    self.VC?.tblFleet.reloadData()
                }
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
    
    func getTruckList(){
        WebServiceSubClass.getTruckList{ (status, apiMessage, response, error) in
            DispatchQueue.main.async {
                self.VC?.refreshControl.endRefreshing()
            }
            if status {
                self.VC?.arrTruck = response?.data ?? []
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
            if self.VC?.tabTypeSelection == .Truck{
                self.VC?.isLoading = false
                self.VC?.tblFleet.reloadData()
            }
        }
    }
    
    func getTractorList(){
        WebServiceSubClass.getTractorList{ (status, apiMessage, response, error) in
            DispatchQueue.main.async {
                self.VC?.refreshControl.endRefreshing()
            }
            if status {
                self.VC?.arrTractor = response?.data ?? []
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
            if self.VC?.tabTypeSelection == .Vehicles{
                self.VC?.isLoading = false
                self.VC?.tblFleet.reloadData()
            }
        }
    }
}
