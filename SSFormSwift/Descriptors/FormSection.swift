//
//  Section.swift
//  Pods
//
//  Created by tree on 2017/4/22.
//
//

import Foundation

/// 包含区的类，内含cell数组
open class Section: NSObject {
    
//    tag，section的标签
    public var tag: String?
    
    public internal(set) weak var form: Form?
    
    public var index: Int? { return form?.sections.index(of:self)}
    /// 用于存放rows的集合
    dynamic var _rows = NSMutableArray()
    var rows: NSMutableArray {
        return mutableArrayValue(forKey: "_rows")
    }
    
    public required override init() {
        super.init()
        commonInit()
    }
    
    init(tag: String?) {
        super.init()
        self.tag = tag
        commonInit()
    }
    
    internal func commonInit() -> Void {
        addObserver(self, forKeyPath: "_rows", options: NSKeyValueObservingOptions.new.union(.old), context: nil)
    }
    deinit {
        removeObserver(self, forKeyPath: "_rows")
    }
    
    public init(_ initializer: (Section) -> Void) {
        super.init()
        initializer(self)
        commonInit()
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let newRows = change![NSKeyValueChangeKey.newKey] as? [BaseRow] ?? []
        let oldRows = change![NSKeyValueChangeKey.oldKey] as? [BaseRow] ?? []
        
        guard let keypathValue = keyPath, let changeType = change?[NSKeyValueChangeKey.kindKey] else { return }
        let delegateValue = form?.delegate
        guard keypathValue == "_rows" else { return }
        switch (changeType as! NSNumber).uintValue {
        case NSKeyValueChange.setting.rawValue:
            let indexSet = change![NSKeyValueChangeKey.indexesKey] as! IndexSet
            let formRow: BaseRow = (object as! Section).rows.object(at: indexSet.first!) as! BaseRow
            rowHaveBeenAdded(formRow, at: indexSet)
            delegateValue?.rowHaveBeenAdded(formRow, at: IndexPath(index: 0))
        case NSKeyValueChange.insertion.rawValue:
            let indexSet = change![NSKeyValueChangeKey.indexesKey] as! IndexSet
            let formRow: BaseRow = (object as! Section).rows.object(at: indexSet.first!) as! BaseRow
            rowHaveBeenAdded(formRow, at: indexSet)
            if let _index = index {
                delegateValue?.rowHaveBeenAdded(formRow, at: IndexPath(row: rows.index(of: formRow), section: _index))
            }
        case NSKeyValueChange.removal.rawValue:
            let indexSet = change![NSKeyValueChangeKey.indexesKey] as! IndexSet
            let formRow: BaseRow = (object as! Section).rows.object(at: indexSet.first!) as! BaseRow
            rowHaveBeenRemoved(formRow, at: indexSet)
            if let _index = index {
                delegateValue?.rowHaveBeenRemoved(formRow, at: IndexPath(row: rows.index(of: formRow), section: _index))
            }
        case NSKeyValueChange.replacement.rawValue:
            let indexSet = change![NSKeyValueChangeKey.indexesKey] as! IndexSet
            let formRow: BaseRow = (object as! Section).rows.object(at: indexSet.first!) as! BaseRow
            let indexOfSection = (object as! Section).rows.index(of: formRow)
            rowHaveBeenReplaced(oldRows[indexOfSection], newRow: newRows[indexOfSection], at: indexSet)
            if let _index = index {
                delegateValue?.rowHaveBeenReplaced(oldRow: oldRows[indexOfSection], newRow: newRows[indexOfSection], at: IndexPath(row: indexOfSection, section: _index))
            }
        default:
            assertionFailure()
        }
        print("\(rows)")
    }
    
    open func rowHaveBeenAdded(_ row: BaseRow, at: IndexSet) -> Void {}
    
    open func rowHaveBeenRemoved(_ row: BaseRow, at: IndexSet) -> Void {}
    
    open func rowHaveBeenReplaced(_ oldRow: BaseRow, newRow: BaseRow, at: IndexSet) -> Void {}
}


// MARK: - 用于拓展对集合的操作
extension Section {
    @discardableResult
    public func add(formRow: BaseRow) -> Section {
       return insertRow(formRow: formRow, at: rows.count)
    }
    
    @discardableResult
    public func add(formRow: BaseRow, at index:Int) -> Section {
       return insertRow(formRow: formRow, at: index)
    }
    
    @discardableResult
    public func insert(formRow: BaseRow, at index:Int) -> Section {
        return insert(formRow: formRow, at: index)
    }
    
    @discardableResult
    public func remove(formRow: BaseRow, at index: Int) -> Section {
        return deleteRow(formRow: formRow, at: index)
    }
    
    @discardableResult
    public func remove(formRow: BaseRow) -> Section {
        return deleteRow(formRow: formRow, at: rows.index(of: formRow))
    }
    
    @discardableResult
    public func replace(newRow: BaseRow, at index: Int) -> Section {
        return replaceRow(newRow: newRow, at: index)
    }
    
    
    @discardableResult
    private func insertRow(formRow: BaseRow, at index: Int) -> Section {
        assert(index <= rows.count, "Section: out of range")
        formRow.section = self
        rows.insert(formRow, at: index)
        return self
    }
    
    @discardableResult
    private func deleteRow(formRow: BaseRow, at index: Int) -> Section {
        assert(index <= rows.count, "Section: out of range")
        formRow.section = nil
        if rows.contains(formRow) {
            rows.remove(formRow)
        }
        return self
    }
    
    @discardableResult
    private func replaceRow(newRow: BaseRow, at index: Int) -> Section {
        assert(index <= rows.count, "Section: out of range")
        newRow.section = self
        rows.replaceObject(at: index, with: newRow)
        return self
    }
}
