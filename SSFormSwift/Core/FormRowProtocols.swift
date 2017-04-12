//
//  FormRowProtocols.swift
//  Pods
//
//  Created by Mac on 17/4/12.
//
//

import Foundation

/// 标签协议，需要有个独一无二的标签来辨识
public protocol Taggable: AnyObject {
    var tag: String? { get set}
}

/// 不可选的协议
protocol Disableable: Taggable {
    
}

/// 隐藏的协议
protocol Hidable: Taggable {
    
}

public protocol FormRowType: Taggable {
    
    /// 单元格样式属性，用于初始化
    var cellStyle: UITableViewCellStyle { get set}
    
    /// 标题属性，显示与否又目标决定
    var title: String? { get set}
    
    /// 主动调用重绘单元格
    func updateCell()
    
    /// 被选中的时候调用此方法
    func didSelect()
}

public protocol TypedRowType: FormRowType {
    
}

/// 所以的row都应该遵守这个协议
public protocol RowType:TypedRowType {
    init(_ tag: String?, _ initializer:(Self) -> Void)
}

