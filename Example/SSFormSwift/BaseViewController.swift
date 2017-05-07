//
//  BaseViewController.swift
//  SSFormSwift
//
//  Created by Mac on 17/4/12.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SSFormSwift

class BaseViewController: UIViewController {
    //MARK:-
    //MARK:properties
    
    //MARK:-
    //MARK:lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let tableView: UITableView = UITableView.init(frame: view.bounds, style: .plain)
        
        view.addSubview(tableView)
    }
    //MARK:-
    //MARK:delegate
   

    //MARK:-
    //MARK:helper
}
