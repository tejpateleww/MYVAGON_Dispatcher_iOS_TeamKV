//
//  EarningViewModel.swift
//  MyVagonDispatcher
//
//  Created by Tej P on 28/01/22.
//

import Foundation

class EarningListViewModel {
    
    weak var myEarningVC : MyEarningVC? = nil
    
    func WebServiceEarningList(ReqModel:EarningReqModel){
        WebServiceSubClass.earningList(reqModel: ReqModel, completion: { (status, apiMessage, response, error) in
            DispatchQueue.main.async {
                self.myEarningVC?.refreshControl.endRefreshing()
            }
            self.myEarningVC?.isTblReload = true
            self.myEarningVC?.isLoading = false
            if status{
                self.myEarningVC?.arrData = response?.data ?? []
                //self.myEarningVC?.tblEarning.reloadDataWithAutoSizingCellWorkAround()
                
                self.myEarningVC?.tblEarning.reloadData()
                self.myEarningVC?.tblEarning.layoutIfNeeded()
                self.myEarningVC?.tblEarning.beginUpdates()
                self.myEarningVC?.tblEarning.endUpdates()
            } else {
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        })
    }
    
    func getDriverList(){
        WebServiceSubClass.getDriverList { (status, apiMessage, response, error) in
            DispatchQueue.main.async {
                self.myEarningVC?.refreshControl.endRefreshing()
            }
            if status {
                self.myEarningVC?.arrDriver = response?.data ?? []
                    self.myEarningVC?.isLoading = false
                    self.myEarningVC?.tblEarning.reloadData()
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
        }
    }
    
    func getTruckList(){
        WebServiceSubClass.getTruckList{ (status, apiMessage, response, error) in
            DispatchQueue.main.async {
                self.myEarningVC?.refreshControl.endRefreshing()
            }
            if status {
                self.myEarningVC?.arrTruck = response?.data ?? []
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
                self.myEarningVC?.isLoading = false
                self.myEarningVC?.tblEarning.reloadData()
        }
    }
    
    func getTractorList(){
        WebServiceSubClass.getTractorList{ (status, apiMessage, response, error) in
            DispatchQueue.main.async {
                self.myEarningVC?.refreshControl.endRefreshing()
            }
            if status {
                self.myEarningVC?.arrTractor = response?.data ?? []
            }else{
                Utilities.ShowAlertOfValidation(OfMessage: apiMessage)
            }
               self.myEarningVC?.isLoading = false
                self.myEarningVC?.tblEarning.reloadData()
        }
    }
    
    
    
    
    
}
