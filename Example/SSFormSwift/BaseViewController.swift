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

class BaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK:-
    //MARK:properties
    var formTable: SSFormTable = {
        let _tableView : SSFormTable = SSFormTable.init(frame: CGRect.zero, style: .plain)
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
        self.formTable.frame = CGRect.init(x: 0.0, y: 64.0, width: view.frame.size.width, height: view.frame.size.height - 64.0)
        view.addSubview(self.formTable)
        self.formTable.delegate = self
        self.formTable.dataSource = self
                
        let row: LabelRow = LabelRow(tag: "tagtag")
        print("\(row.tag)")
        row.value = "hahahhahahahah"
    }
    //MARK:-
    //MARK:delegate
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ce")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "ce")
        }
        cell?.textLabel?.text = "sss"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    //MARK:-
    //MARK:helper
}
