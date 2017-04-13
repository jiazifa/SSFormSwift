//
//  Form.swift
//  Pods
//
//  Created by Mac on 17/4/12.
//
//

import Foundation

public final class Form {
    //MARK:-
    //MARK:properties
    public weak var delegate: FormDelegate?
    public var rows: [BaseRow] { return [] }
    
    var rowsByTag = [String: BaseRow]()
    var tagToValue = [String: Any]()
    
    /// 区的数目
    public var formSectionsCount: Int { return self.formSections.count }
    
    private var formSections: [Section] = []
    
    public init() {}
    
    
    //MARK:-
    //MARK:delegate
    
    
    //MARK:-
    //MARK:helper
    
    
}
