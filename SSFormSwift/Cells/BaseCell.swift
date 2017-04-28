//
//  BaseCell.swift
//  Pods
//
//  Created by Mac on 17/4/12.
//
//

import Foundation

/// 继承于UITableViewCell，提供基础的方法
open class BaseCell: UITableViewCell, BaseCellType {
    
    public var baseRow: BaseRow! { return nil }
    
    /**
     BaseCellType
     */
    public var height: (() -> CGFloat)?
    
    public func setup() {}
    
    public func update() {}
    
    public func didSelect() {}
    
    public func cellCanBecomeFirstResponder() -> Bool { return false}
    
    public func cellResignFirstResponder() -> Bool { return resignFirstResponder() }
    
    public func formViewController() -> UIViewController? {
        var responder: AnyObject? = self
        while responder != nil {
            if let formVC = responder as? UIViewController { return formVC }
            responder = responder?.next
        }
        return nil
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}


/// 泛型，提供value属性，value属性的变化会调用代理的方法
open class Cell<T:Equatable>: BaseCell, TypeCellType {
    public typealias Value = T
    
    /// 这个属性持有BaseRow，当这个值变化的时候，设置回调处理变化
    public weak var row: RowOf<T>!
    
    public required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        height = { UITableViewAutomaticDimension }
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func setup() {
        super.setup()
    }
    open override func update() {
        super.update()
        
    }
}

