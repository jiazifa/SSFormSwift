//
//  FormForm.swift
//  Pods
//
//  Created by tree on 2017/4/23.
//
//

import Foundation

public protocol FormDelegate: class {
    
    func sectionHaveBeenAdded(_ section: Section, at: Int) -> Void
    
    func sectionHaveBeenRemoved(_ section: Section, at: Int) -> Void

    func sectionHaveBeenReplaced(oldSection: Section, newSection: Section, at: Int) -> Void
    
    func rowHaveBeenAdded(_ row: BaseRow, at: IndexPath) -> Void
    func rowHaveBeenRemoved(_ row: BaseRow, at: IndexPath) -> Void
    func rowHaveBeenReplaced(oldRow: BaseRow, newRow: BaseRow, at: IndexPath) -> Void
    func rowHaveBeenChanged(for: BaseRow, oldValue: Any?, newValue: Any?) -> Void
}

/// 对应整个表格的描述对象，包含了区和rows
public final class Form: NSObject {
    
    /// form对象的代理
    public weak var delegate: FormDelegate?
    
    /// 包含了secion的集合
    dynamic var _sections = NSMutableArray()
    var sections: NSMutableArray { return mutableArrayValue(forKey: "_sections")}
    var _allSections = [Section]()
    
    public override init() {
        super.init()
        addObserver(self, forKeyPath: "_sections", options: NSKeyValueObservingOptions.new.union(.old), context: nil)
    }
    
    deinit {
        removeObserver(self, forKeyPath: "_sections")
    }
    //MARK:-
    //MARK:KVO
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let newSections = change?[NSKeyValueChangeKey.newKey] as? [Section] ?? []
        let oldSections = change?[NSKeyValueChangeKey.oldKey] as? [Section] ?? []
        guard let delegateValue = delegate, let keyPathValue = keyPath, let changeType = change?[NSKeyValueChangeKey.kindKey] else { return }
        guard keyPathValue == "_sections" else { return }
        switch (changeType as! NSNumber).uintValue {
        case NSKeyValueChange.setting.rawValue:
            let indexSet = change![NSKeyValueChangeKey.indexesKey] as? IndexSet ?? IndexSet(integer: 0)
            let formSection: Section = (object as! Form).sections.object(at: indexSet.first!) as! Section
            delegateValue.sectionHaveBeenAdded(formSection, at: indexSet.first!)
        case NSKeyValueChange.insertion.rawValue:
            let indexSet = change![NSKeyValueChangeKey.indexesKey] as? IndexSet ?? IndexSet(integer: 0)
            let formSection: Section = (object as! Form).sections.object(at: indexSet.first!) as! Section
            delegateValue.sectionHaveBeenAdded(formSection, at: indexSet.first!)
        case NSKeyValueChange.removal.rawValue:
            let indexSet = change![NSKeyValueChangeKey.indexesKey] as? IndexSet ?? IndexSet(integer: 0)
            let formSection: Section = oldSections[indexSet.first!]
            delegateValue.sectionHaveBeenRemoved(formSection, at: indexSet.first!)
        case NSKeyValueChange.replacement.rawValue:
            let indexSet = change![NSKeyValueChangeKey.indexesKey] as? IndexSet ?? IndexSet(integer: 0)
            let oldSecrtion: Section = oldSections[indexSet.first!]
            let newSection: Section = newSections[indexSet.first!]
            delegateValue.sectionHaveBeenReplaced(oldSection: oldSecrtion, newSection: newSection, at: indexSet.first!)
        default:
            assertionFailure()
        }
    }
}

extension Form {
    @discardableResult
    public func add(formSection: Section) -> Form {
        return insertSection(formSection: formSection, at: sections.count)
    }
    
    @discardableResult
    public func insert(formSection: Section, at index:Int) -> Form {
        return insertSection(formSection: formSection, at: index)
    }
    
    @discardableResult
    public func delete(formSection: Section) -> Form {
        assert(sections.contains(formSection), "Form: sections not contains section")
        return deleteSection(formSection: formSection)
    }
    
    @discardableResult
    public func delete(at index: Int) -> Form {
        assert(index <= sections.count, "Form: out of range")
        return deleteSection(formSection: sections.object(at: index) as! Section)
    }
    
    @discardableResult
    public func replace(oldSection: Section, newSection: Section) -> Form {
        return replace(oldSection: oldSection, newSection: newSection)
    }
    
    @discardableResult
    private func insertSection(formSection: Section, at index:Int) -> Form {
        assert(index <= sections.count, "Form: out of range")
        formSection.form = self
        sections.insert(formSection, at: index)
        return self
    }
    
    private func deleteSection(formSection: Section) -> Form {
        assert(sections.contains(formSection), "Form: sections not contains section")
        formSection.form = nil
        sections.remove(formSection)
        return self
    }
    
    @discardableResult
    private func replaceSection(oldSection: Section, newSection: Section) -> Form {
        assert(sections.contains(oldSection), "Form: sections not contains section")
        oldSection.form = nil
        newSection.form = self
        let index = sections.index(of: oldSection)
        sections.replaceObject(at: index, with: newSection)
        return self
    }
    
}
