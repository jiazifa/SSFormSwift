//
//  Core.swift
//  Pods
//
//  Created by Mac on 17/4/12.
//
//

import Foundation

//MARK: -
//MARK: Row
internal class RowDefaults {
    static var cellUpdate = [String: (BaseCell, BaseRow) -> Void]()
    static var cellSetup = [String: (BaseCell, BaseRow) -> Void]()
    static var onCellHighlightChanged = [String: (BaseCell, BaseRow) -> Void]()
    static var rowInitialization = [String: (BaseRow) -> Void]()
    static var onRowValidationChanged = [String: (BaseCell, BaseRow) -> Void]()
    static var rawCellUpdate = [String: Any]()
    static var rawCellSetup = [String: Any]()
    static var rawOnCellHighlightChanged = [String: Any]()
    static var rawRowInitialization = [String: Any]()
    static var rawRnRowValidationChanged = [String: Any]()
    
}

//MARK: -
//MARK: ControllerProvider
public struct CellProvider<Cell: BaseCell> where Cell: CellType {
    
    /// 表示带私有设置方法的公共属性
    public private(set) var nibName: String?
    public private(set) var bundle: Bundle!
    
    public init() {}
    
    public init(nibName: String, bundle: Bundle? = nil) {
        self.nibName = nibName
        self.bundle = bundle ?? Bundle(for: Cell.self)
    }
    
    func makeCell(style: UITableViewCellStyle) -> Cell {
        if let nibName = self.nibName {
            return bundle.loadNibNamed(nibName, owner: nil, options: nil)!.first as! Cell
        }
        return Cell.init(style: style, reuseIdentifier: nil)
    }
}
//MARK: -
//MARK: ControllerProvider
public enum ControllerProvider<VCType: UIViewController> {
    
    case callback(builder: (() -> VCType))
    
    case nibFile(name: String, bundle: Bundle?)
    
    case storyBoard(storyboardId: String, storyboardName: String, bundle: Bundle?)
    
    func makeController() -> VCType {
        switch self {
        case .callback(let builder):
            return builder()
        case .nibFile(let nibName, let bundle):
            return VCType.init(nibName: nibName, bundle:bundle ?? Bundle(for: VCType.self))
        case .storyBoard(let storyboardId, let storyboardName, let bundle):
            let sb = UIStoryboard(name: storyboardName, bundle: bundle ?? Bundle(for: VCType.self))
            return sb.instantiateViewController(withIdentifier: storyboardId) as! VCType
        }
    }
}


//MARK: -
//MARK: Condition
public enum Condition {
    /**
     计算回调的内部条件
     */
    case function([String], (Form) -> Bool)
    /**
     用谓词来计算内调
     */
    case predicate(NSPredicate)
}

extension Condition: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = Condition.function([]) {_ in return value}
    }
}
extension Condition: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .predicate(NSPredicate(format: value))
    }
    
    /**
     Initialize a Condition with a string that will be converted to a NSPredicate
     */
    public init(unicodeScalarLiteral value: String) {
        self = .predicate(NSPredicate(format: value))
    }
    
    /**
     Initialize a Condition with a string that will be converted to a NSPredicate
     */
    public init(extendedGraphemeClusterLiteral value: String) {
        self = .predicate(NSPredicate(format: value))
    }
}

//MARK: -
//MARK: FormControllerAnimationProtocol
public protocol FormControllerAnimationProtocol {
    var tableView: UITableView! { get }
    
    
}
