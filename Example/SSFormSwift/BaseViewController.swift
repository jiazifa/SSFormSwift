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
    var formTable:UITableView = {
        let _tableView : UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        _tableView.indicatorStyle = .white
        _tableView.isScrollEnabled = true
        _tableView.isUserInteractionEnabled = true
        _tableView.backgroundColor = UIColor.clear
        _tableView.backgroundView = nil
        _tableView.tableFooterView = UIView.init()
        
        _tableView.sectionHeaderHeight = 0.0
        _tableView.sectionFooterHeight = 0.0
        
        _tableView.separatorStyle = .singleLine
        return _tableView
    }()
    //MARK:-
    //MARK:lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        formTable = UITableView.init(frame: CGRect.init(x: 0.0, y: 64.0, width: view.frame.width, height: view.frame.height-64.0-50.0), style: .plain)
        view.addSubview(formTable)
        let formHelper:SSFormTableViewSourceHelper = SSFormTableViewSourceHelper.init(formTable)
        
        let form:SSFormDescriptor = SSFormDescriptor.init("表格")
        let section:SSFormSectionDescriptor = SSFormSectionDescriptor.init("")
        form.addSection(section)
        for index in 1...2 {
            let row :SSFormRowDescriptor = SSFormRowDescriptor.init(40.0, cellClass: demoCell.self, value: "\(index)行----->点击我刷新当前行" as AnyObject)
            
            let action:UITableViewRowAction = UITableViewRowAction.init(style: .default, title: "添加", handler:{
                (action, indexPath) in
                print("added")
            })
            
            let ac:UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "删除", handler:{
                (action, indexPath) in
                print("delete")
            })
            row.canMoveRow = true
            row.canEditRow = true
            row.editActions = [action,ac]
            //            row.editingStyleHandle({ (rowDes, style, indexPath) in
            //                if style != .insert { return}
            //                let section:SSFormSectionDescriptor = SSFormSectionDescriptor.init("added-->\(indexPath)")
            //                section.height = 40.0
            //                section.insertAnimation = .none
            //                formHelper.form.addSection(section)
            //            })
            row.deleteAnimation = .left
            row.freshAnimation = .left
            row.onClickHandle({ (rowDes, indexPath) in
                rowDes.value = "ssdfasldkjasdklfj" as AnyObject
            })
            section.add(row)
        }
        
        formHelper.form = form
        formTable.sourceHelper = formHelper
    }
    //MARK:-
    //MARK:delegate
   

    //MARK:-
    //MARK:helper
}
