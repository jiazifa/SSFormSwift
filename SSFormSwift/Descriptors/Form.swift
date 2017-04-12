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
    
    /// 区的数目
    public var formSectionsCount: Int { return self.formSections.count }
    
    private var formSections: [Section] = []
    
    public init() {}
    //MARK:-
    //MARK:delegate
    
    //MARK:-
    //MARK:helper
    
}
