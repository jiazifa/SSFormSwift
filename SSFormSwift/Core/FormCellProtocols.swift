//
//  FormCellProtocols.swift
//  Pods
//
//  Created by Mac on 17/4/12.
//
//

import Foundation

/// 针对cell的协议，其中要求实现几种基本的方法
public protocol BaseCellType: class {
    
    /// 单元格的高度
    var height : (() -> CGFloat)? { get }
    
    /// 初始化方法
    func setup()
    
    func update()
    
    func didSelect()
    /**
     单元格能否成为第一响应者
     */
    func cellCanBecomeFirstResponder() -> Bool
    /**
     注销第一响应者
     */
    func cellResignFirstResponder() -> Bool
    /**
     获得单元格的视图控制器
     */
    func formViewController() -> UIViewController?
}

public protocol TypeCellType: BaseCellType {
    /**
     指定一个确定的类型并要求该类型实现指定的方法
     */
    associatedtype Value: Equatable
    
    var row: RowOf<Value>! { get set}
}

public protocol CellType: TypeCellType {}
