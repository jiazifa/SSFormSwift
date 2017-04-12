//
//  BaseCell.swift
//  Pods
//
//  Created by Mac on 17/4/12.
//
//

import Foundation

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

open class Cell<T:Equatable>: BaseCell, TypeCellType {
    public typealias Value = T
    
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

