//
//  FormSection.swift
//  Pods
//
//  Created by Mac on 17/4/12.
//
//

import Foundation

public protocol SectionDelegate: class {
    func rowHaveBeenAdded(_ row: BaseRow, at: Int) -> Void
    func rowHaveBeenRemoved(_ row: BaseRow, at: Int) -> Void
    func rowHaveBeenReplaced(oldRow: BaseRow, newRow: BaseRow, at: Int) -> Void
}

extension Section: Equatable {
    static public func ==(lhs: Section, rhs: Section) -> Bool {
        return lhs === rhs
    }
}

extension Section {
    public func reload(with rowAnimation: UITableViewRowAnimation = .none) {
        guard let tableView = (form?.delegate as? FormTableViewSourceHelper)?.tableView, let index = index else { return }
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integer: index), with: rowAnimation)
        tableView.endUpdates()
    }
}

extension Section: Hidable, SectionDelegate {}

open class Section {
    public var tag: String?
    
    internal var formRows: [BaseRow] = []
    
    public internal(set) weak var form: Form?
    
    public var header: HeaderFooterViewRepresentable? {
        willSet {
            headerView = nil
        }
    }
    public var footer: HeaderFooterViewRepresentable? {
        willSet {
            footerView = nil
        }
    }
    
    public var index: Int?
    
    public init(_ header: String, _ initializer: (Section) -> Void = {_ in}) {
        self.header = HeaderFooterView(stringLiteral: header)
        initializer(self)
    }
    
    public init(header: String,footer: String, _ initializer: (Section) -> Void = {_ in}) {
        self.header = HeaderFooterView(stringLiteral: header)
        self.footer = HeaderFooterView(stringLiteral: footer)
        initializer(self)
    }
    
    public init(footer: String, _ initializer: (Section) -> Void = {_ in}) {
        self.footer = HeaderFooterView(stringLiteral: footer)
        initializer(self)
    }
    
    public var isHidden: Bool { return hiddenCache }
    
    var headerView: UIView?
    var footerView: UIView?
    var hiddenCache = false
    
    open func rowHaveBeenAdded(_ row: BaseRow, at: Int) {}
    open func rowHaveBeenRemoved(_ row: BaseRow, at: Int) {}
    open func rowHaveBeenReplaced(oldRow: BaseRow, newRow: BaseRow, at: Int) {}
}

extension Section: MutableCollection, BidirectionalCollection {
    
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return formRows.count }
    public subscript(position: Int) -> BaseRow {
        get {
            assert(position <= formRows.count, "Section: Index out of range")
            return formRows[position] as! BaseRow
        }
        set { formRows[position] = newValue }
    }
    
    
}
