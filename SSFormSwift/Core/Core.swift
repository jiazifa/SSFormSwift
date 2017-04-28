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


//MARK: -
//MARK: FormControllerAnimationProtocol
public protocol FormControllerAnimationProtocol {
    var tableView: UITableView! { get }
    
    
}
