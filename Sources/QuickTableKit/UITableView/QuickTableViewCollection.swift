//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public final class QuickTableViewCollection {
    
    private var indexes: [String: Int] = [:]
    
    public private(set) var sections: [QuickTableViewSection] {
        didSet {
            recalculateIndexes()
        }
    }
    
    public var hasAnyItems: Bool {
        sections.firstIndex(where: { !$0.items.isEmpty }) != nil
    }
    
    public init(sections: [QuickTableViewSection]) {
        self.sections = sections
        
        recalculateIndexes()
    }
    
    public convenience init(items: [QuickTableViewCellModelProtocol]) {
        self.init(sections: [QuickTableViewSection(items: items)])
    }
    
    public convenience init() {
        self.init(sections: [])
    }
    
    // MARK: Insert sections
    
    public func add(section: QuickTableViewSection, at index: Int? = nil) {
        add(sections: [section], at: index)
    }
    
    public func add(sections: [QuickTableViewSection], at index: Int? = nil) {
        let insertIndex = index ?? self.sections.count
        guard self.sections.count >= insertIndex else {
            fatalError("Section with index = \(insertIndex) not exist.")
        }
        
        self.sections.insert(contentsOf: sections, at: insertIndex)
    }
    
    // MARK: Insert items
    
    public func add(item: QuickTableViewCellModelProtocol, at index: Int? = nil) {
        add(items: [item], at: index)
    }
    
    public func add(items: [QuickTableViewCellModelProtocol], at index: Int? = nil) {
        let insertIndex = index ?? self.sections.count
        guard sections.count >= insertIndex else {
            fatalError("Section with index = \(insertIndex) not exist.")
        }
        
        if sections.count == insertIndex {
            sections.append(QuickTableViewSection(items: items))
            return
        }
        
        sections[insertIndex].add(items: items)
    }
    
    // MARK: Update
    
    public func update(with sections: [QuickTableViewSection]) {
        self.sections.removeAll()
        add(sections: sections)
    }
    
    // MARK: Remove
    
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
    
    public func remove(cellAt index: IndexPath) {
        guard let section = sections[safe: index.section], section.items.count > index.item else {
            return
        }
        
        section.remove(itemAt: index.item)
    }
    
    public func removeAll() {
        sections.removeAll()
    }
    
    // MARK: Other
    
    @discardableResult
    public func replace(section: QuickTableViewSection, at index: Int) -> Bool {
        guard sections.count > index else {
            return false
        }
        
        sections[index] = section
        return true
    }
    
    // MARK: Private methods
    
    private func recalculateIndexes() {
        let sectionIds = sections.map({ $0.entity?.id }).enumerated()
        
        indexes = sectionIds.reduce(into: [String: Int](), { $0[$1.element ?? ""] = $1.offset })
    }
}

extension QuickTableViewCollection {
    
    public func numberOfSections() -> Int {
        sections.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        sections[safe: section]?.items.count ?? 0
    }
    
    public func cellType(at indexPath: IndexPath) -> QuickTableViewCellProtocol.Type? {
        guard let item = sections[safe: indexPath.section]?.items[safe: indexPath.row] else {
            return nil
        }
        
        return type(of: item).type
    }
    
    public func cellId<CellId: RawRepresentable>(at indexPath: IndexPath) -> CellId? where CellId.RawValue == Int {
        guard let value = sections[safe: indexPath.section]?.items[safe: indexPath.row]?.id else {
            return nil
        }
        
        return CellId(rawValue: value)
    }
    
    public func sectionId<SectionId: RawRepresentable>(at section: Int) -> SectionId? where SectionId.RawValue == Int {
        guard let value = sections[safe: section]?.id else {
            return nil
        }
        
        return SectionId(rawValue: value)
    }
    
    public func cell(at indexPath: IndexPath) -> QuickTableViewCellModelProtocol? {
        guard let sectionModel = sections[safe: indexPath.section],
              let cellModel = sectionModel.items[safe: indexPath.row] else {
            return nil
        }
        
        return cellModel
    }
    
    public func hasHeader(at section: Int) -> Bool {
        sections[safe: section]?.header != nil
    }
    
    public func hasFooter(at section: Int) -> Bool {
        sections[safe: section]?.footer != nil
    }
    
    public func headerType(at section: Int) -> QuickTableViewHeaderFooterViewProtocol.Type? {
        guard let model = sections[safe: section]?.header else {
            return nil
        }
        
        return type(of: model).type
    }
    
    public func footerType(at section: Int) -> QuickTableViewHeaderFooterViewProtocol.Type? {
        guard let model = sections[safe: section]?.footer else {
            return nil
        }
        
        return type(of: model).type
    }
    
    public func header(at section: Int) -> QuickTableViewHeaderFooterModelProtocol? {
        guard let sectionModel = sections[safe: section] else {
            return nil
        }
        
        return sectionModel.header
    }
    
    public func footer(at section: Int) -> QuickTableViewHeaderFooterModelProtocol? {
        guard let sectionModel = sections[safe: section] else {
            return nil
        }
        
        return sectionModel.footer
    }
    
    public func identifier<SectionId>(forSection sectionIndex: Int) -> SectionId? where SectionId: RawRepresentable, SectionId.RawValue == Int {
        guard let identifierValue = sections[safe: sectionIndex]?.id else {
            return nil
        }
        
        return SectionId(rawValue: identifierValue)
    }
    
    public func identifier<CellId>(for indexPath: IndexPath) -> CellId? where CellId: RawRepresentable, CellId.RawValue == Int {
        guard let identifierValue = sections[safe: indexPath.section]?.items[safe: indexPath.row]?.id else {
            return nil
        }
        
        return CellId(rawValue: identifierValue)
    }
}

extension QuickTableViewCollection {
    
    public func index(sectionWithId id: String) -> Int? {
        indexes[id]
    }
    
    public func index<SectionId: RawRepresentable>(sectionWithType sectionId: SectionId) -> Int? where SectionId.RawValue == Int {
        sections.firstIndex(where: { $0.id == sectionId.rawValue })
    }
    
    public func index(cellWithId id: String) -> IndexPath? {
        for (sectionIndex, section) in sections.enumerated() {
            guard let itemIndex = section.itemIndex(withId: id) else {
                continue
            }
            
            return IndexPath(item: itemIndex, section: sectionIndex)
        }
        
        return nil
    }
    
    public func index<SectionId: RawRepresentable, CellId: RawRepresentable>(cellWithSectionType sectionId: SectionId, andCellType cellId: CellId) -> IndexPath? where SectionId.RawValue == Int, CellId.RawValue == Int {
        guard let sectionIndex = sections.firstIndex(where: { $0.id == sectionId.rawValue }),
              let cellIndex = sections[sectionIndex].items.firstIndex(where: { $0.id == cellId.rawValue }) else {
            return nil
        }
        
        return IndexPath(item: cellIndex, section: sectionIndex)
    }
    
    public func firstSectionIndex<SectionId: RawRepresentable>(sectionIds: [SectionId]) -> Int? where SectionId.RawValue == Int {
        for sectionId in sectionIds {
            if let sectionIndex = index(sectionWithType: sectionId) {
                return sectionIndex
            }
        }
        
        return nil
    }
}
