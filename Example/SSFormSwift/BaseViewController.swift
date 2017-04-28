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
        
        let form: Form = Form.init()
        let section: Section = Section()
        let label = LabelRow(tag: "tagtag")
        label.value = "labelCell"
        section.add(formRow: label)
        
    }
    //MARK:-
    //MARK:delegate
    

    //MARK:-
    //MARK:helper
}
