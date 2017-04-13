//
//  HeaderFooterViewProtocols.swift
//  Pods
//
//  Created by Mac on 17/4/13.
//
//

import Foundation

public protocol HeaderFooterViewRepresentable {
    
    func viewForSection(_ section: Section, type: HeaderFooterType) -> UIView?
    
    var title: String? { get set }
    
    var height: (() -> CGFloat)? { get set }
}
