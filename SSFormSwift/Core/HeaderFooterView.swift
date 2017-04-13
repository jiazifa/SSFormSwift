//
//  HeaderFooterView.swift
//  Pods
//
//  Created by Mac on 17/4/13.
//
//

import Foundation

public enum HeaderFooterType {
    case header, footer
}

public enum HeaderFooterProvider<ViewType: UIView> {
    
    case `class`
    
    case callback(() -> ViewType)
    
    case nibFile(name: String, bundle: Bundle?)
    
    internal func createView() -> ViewType {
        switch self {
        case .class:
            return ViewType()
        case .callback(let builder):
            return builder()
        case .nibFile(let nibName, let bundle):
            return (bundle ?? Bundle(for: ViewType.self)).loadNibNamed(nibName, owner: nil, options: nil)![0] as! ViewType
        }
    }
}

public struct HeaderFooterView<ViewType: UIView> : HeaderFooterViewRepresentable {
    
    public var title: String?
    
    public var viewProvider: HeaderFooterProvider<ViewType>?
    
    public var onSetupView: ((_ view: ViewType, _ section: Section) -> Void)?
    
    public var height: (() -> CGFloat)?
    
    public func viewForSection(_ section: Section, type: HeaderFooterType) -> UIView? {
        var view: ViewType?
        if type == .header {
            view = section.headerView as? ViewType ?? {
                let result = viewProvider?.createView()
                section.headerView = result
                return result
            }()
        }else {
            view = section.footerView as? ViewType ?? {
                let result = viewProvider?.createView()
                section.footerView = result
                return result
            }()
        }
        guard let v = view else { return nil }
        onSetupView?(v, section)
        return v
    }
    
    public init?(title: String?) {
        guard let t = title else { return nil }
        
    }
    
    public init(_ provider: HeaderFooterProvider<ViewType>) {
        viewProvider = provider
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.title  = value
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.title = value
    }
    
    public init(stringLiteral value: String) {
        self.title = value
    }
}
