//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public final class QuickCollectionViewCollection {
    
    private var indexes: [String: Int] = [:]
    
    public private(set) var sections: [QuickCollectionViewSection] {
        didSet {
            recalculateIndexes()
        }
    }
    
    public var hasAnyItems: Bool {
        sections.firstIndex(where: { !$0.items.isEmpty }) != nil
    }
    
    public init(sections: [QuickCollectionViewSection]) {
        self.sections = sections
        
        recalculateIndexes()
    }
    
    public convenience init(items: [QuickCollectionViewCellModelProtocol]) {
        self.init(sections: [QuickCollectionViewSection(items: items)])
    }
    
    public convenience init() {
        self.init(sections: [])
    }
    
    // MARK: Insert Sections
    
    public func add(section: QuickCollectionViewSection, at index: Int? = nil) {
        add(sections: [section], at: index)
    }
    
    public func add(sections: [QuickCollectionViewSection], at index: Int? = nil) {
        let insertIndex = index ?? self.sections.count
        guard self.sections.count >= insertIndex else {
            fatalError("Section with index = \(insertIndex) not exist.")
        }
        
        self.sections.insert(contentsOf: sections, at: insertIndex)
    }
    
    // MARK: Insert Items
    
    public func add(item: QuickCollectionViewCellModelProtocol, to index: Int? = nil, atSection sectionIndex: Int? = nil) {
        add(items: [item], to: index, atSection: sectionIndex)
    }
    
    public func add(items: [QuickCollectionViewCellModelProtocol], to index: Int? = nil, atSection sectionIndex: Int? = nil) {
        let sectionIndex = sectionIndex ?? sections.count
        guard sections.count >= sectionIndex else {
            fatalError("Section with index = \(sectionIndex) not exist.")
        }
        
        if sections.count == sectionIndex {
            sections.append(QuickCollectionViewSection(items: items))
            return
        }
        
        sections[sectionIndex].items.append(contentsOf: items)
    }
    
    // MARK: Update Sections
    
    public func update(sections: [QuickCollectionViewSection]) {
        self.sections.removeAll()
        add(sections: sections)
    }
    
    // MARK: Update Items
    
    public func update(items: [QuickCollectionViewCellModelProtocol], atSection sectionIndex: Int) {
        guard let section = sections[safe: sectionIndex] else {
            fatalError("Section with index = \(sectionIndex) not exist.")
        }
        
        section.items = items
    }
    
    // MARK: Remove Sections
    
    public func remove(sectionAt index: Int) {
        guard sections.count > index else {
            return
        }
        
        sections.remove(at: index)
    }
    
    public func remove(sectionWithId id: String) {
        guard let sectionIndex = sections.firstIndex(where: { $0.entity?.id == id }) else {
            return
        }
        
        sections.remove(at: sectionIndex)
    }
    
    public func removeAll() {
        sections.removeAll()
    }
    
    // MARK: Remove Items
    
    public func remove(itemAt index: Int, inSection sectionIndex: Int) {
        guard let section = sections[safe: sectionIndex] else {
            fatalError("Section with index = \(sectionIndex) not exist.")
        }
        
        guard section.items.count > index else {
            return
        }
        
        section.items.remove(at: index)
    }
    
    public func remove(itemWithEntityId id: String, inSection sectionIndex: Int) {
        guard let section = sections[safe: sectionIndex] else {
            fatalError("Section with index = \(sectionIndex) not exist.")
        }
        
        guard let itemIndex = section.index(withEntityId: id) else {
            return
        }
        
        section.items.remove(at: itemIndex)
    }
    
    // MARK: Private methods
    
    private func recalculateIndexes() {
        let sectionIds = sections.map({ $0.entity?.id }).enumerated()
        
        indexes = sectionIds.reduce(into: [String: Int](), { $0[$1.element ?? ""] = $1.offset })
    }
}
