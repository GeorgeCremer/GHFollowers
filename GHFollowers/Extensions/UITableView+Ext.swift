//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by George Cremer on 29/03/2021.


import UIKit

extension UITableView {
 
    func removeExcessCells(){
        tableFooterView = UIView(frame:.zero)
    }
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
}
