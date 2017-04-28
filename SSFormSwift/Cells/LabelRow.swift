//
//  LabelCell.swift
//  Pods
//
//  Created by Mac on 17/4/13.
//
//

import Foundation

open class LabelCellOf<T: Equatable>: Cell<T>, CellType {
    public required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func setup() {
        super.setup()
        selectionStyle = .none
    }
}

public typealias LabelCell = LabelCellOf<String>

open class  _LabelRow: Row<LabelCell> {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

public final class LabelRow: _LabelRow, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}
