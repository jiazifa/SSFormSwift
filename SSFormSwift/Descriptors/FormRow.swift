//
//  FormRow.swift
//  Pods
//
//  Created by Mac on 17/4/12.
//
//

import Foundation


open class RowOf<T: Equatable>: BaseRow {
    
    open var value: T? {
        didSet {
            guard let form = section?.form else { return }
            wasChanged = true
            if let delegate = form.delegate {
                delegate.valueHasBeenChanged(for: self, oldValue: oldValue, newValue: value)
                callbackOnChange?()
            }
            guard let t = tag else { return }
            form.tagToValue[t] = (value != nil ? value : NSNull())
        }
    }
    
    public override var baseValue: Any? {
        get { return value }
        set { value = newValue as? T }
    }
    
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}
/**
 类 --> 代表了row
 */
open class Row<Cell: CellType>: RowOf<Cell.Value>, TypedRowType where Cell: BaseCell {
    
    public var cellProvider = CellProvider<Cell>()
    
    public let cellType: Cell.Type! = Cell.self
    
    private var _cell: Cell! {
        didSet {
            RowDefaults.cellSetup["\(type(of: self))"]?(_cell, self)
            (callbackCellSetup as? ((Cell) -> Void))?(_cell)
        }
    }
    
    public var cell: Cell! {
        return _cell ?? {
            let result = cellProvider.makeCell(style: self.cellStyle)
            result.row = self
            result.setup()
            _cell = result
            return _cell
        }()
    }
    
    public override var baseCell: BaseCell { return cell }
    
    public required init(tag: String?) {
        super.init(tag: tag)
    }
    
    open override func updateCell() {
        super.updateCell()
        cell.update()
        customUpdateCell()
        RowDefaults.cellUpdate["\(type(of: self))"]?(cell, self)
        callbackCellUpdate?()
    }
    
    open override func didSelect() {
        super.didSelect()
        if !isDisabled {
            cell?.didSelect()
        }
        customDidSelect()
        callbackCellOnSelection?()
    }
    
    open func customDidSelect() {}
    
    open func customUpdateCell() {}
}

open class BaseRow: FormRowType {

    var callbackOnChange: (() -> Void)?
    var callbackCellUpdate: (() -> Void)?
    var callbackCellSetup: Any?
    var callbackCellOnSelection: (() -> Void)?
    var callbackOnExpandInlineRow: Any?
    var callbackOnCollapseInlineRow: Any?//折叠
    var callbackOnCellHighlightChanged: (() -> Void)?
    var callbackOnRowValidationChanged: (() -> Void)?
    var _inlineRow: BaseRow?
    
    public internal(set) var wasBlurred = false//模糊
    public internal(set) var wasChanged = false//改变
    /**
     protocol Taggable
     */
    public var tag: String?
    
    /**
     protocol FormRowType
     */
    public var cellStyle: UITableViewCellStyle = UITableViewCellStyle.value1
    
    public var title: String?
    
    open func updateCell() {}
    open func didSelect() {}
    open func prepare(for segue: UIStoryboardSegue) {}
    
    public var baseCell: BaseCell! { return nil }
    
    public var baseValue: Any? {
        set {}
        get { return nil }
    }
    
    public var disabled: Condition?
    
    public var hidden: Condition?
    
    public var isDisabled: Bool { return disabledCache }
    public var isHidden: Bool { return hiddenCache }
    
    var hiddenCache = false
    var disabledCache = false {
        willSet {
            if newValue && !disabledCache {
                baseCell.cellResignFirstResponder()
            }
        }
    }
    
    public weak var section: Section?
    
    public static var estimatedRowHeight: CGFloat = 44.0
    
    public required init(tag: String? = nil) {
        self.tag = tag
    }
    public final var indexPath: IndexPath?
    
}
