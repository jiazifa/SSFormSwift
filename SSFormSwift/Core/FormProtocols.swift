//
//  FormProtocols.swift
//  Pods
//
//  Created by Mac on 17/4/12.
//
//

import Foundation

public protocol FormDelegate: class {
    func sectionsHaveBeenAdded(_ sections: [Section], at: IndexSet) -> Void
    func sectionsHaveBeenRemoved(_ sections: [Section], at: IndexSet) -> Void
    func sectionsHaveBeenReplaced(oldSections: [Section], newSections: [section], at: IndexSet) -> Void
    func rowsHaveBeenAdded(_ rows: [BaseRow], at: [IndexPath]) -> Void
    func rowsHaveBeenRemoved(_ rows: [BaseRow], at: [IndexPath]) -> Void
    func rowsHaveBeenReplaced(for: BaseRow, oldValue: Any?, newValue: Any?) -> Void
    func valueHasBeenChanged(for: BaseRow, oldValue: Any?, newValue: Any?) -> Void
}


open class SSFormTable: UITableView {
    //MARK:-
    //MARK:properties
    public var sourceHelper: FormTableViewSourceHelper?
    
    //MARK:-
    //MARK:lifeCycle
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: .plain)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
