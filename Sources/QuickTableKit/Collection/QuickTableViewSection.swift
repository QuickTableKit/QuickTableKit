//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public final class QuickTableViewSection {
    
    private var indexes: [String: Int] = [:]
    
    public private(set) var id: Int?
    public private(set) var entity: IdentifiableEntity?
    public var header: QuickTableViewHeaderModelProtocol?
    public var footer: QuickTableViewHeaderModelProtocol?
    public private(set) var items: [QuickTableViewCellModelProtocol] {
        didSet {
            recalculateIndexes()
        }
    }
    
    public init(id: Int? = nil,
                entity: IdentifiableEntity? = nil,
                header: QuickTableViewHeaderModelProtocol? = nil,
                footer: QuickTableViewHeaderModelProtocol? = nil,
                items: [QuickTableViewCellModelProtocol] = []) {
        self.id = id
        self.entity = entity
        self.header = header
        self.footer = footer
        self.items = items
        
        recalculateIndexes()
    }
    
    // MARK: Insert
    
    public func add(item: QuickTableViewCellModelProtocol, at index: Int? = nil) {
        add(items: [item], at: index)
    }
    
    public func add(items: [QuickTableViewCellModelProtocol], at index: Int? = nil) {
        let insertIndex = index ?? self.items.count
        guard self.items.count >= insertIndex else {
            fatalError("Item with index = \(insertIndex) not exist.")
        }
        
        self.items.insert(contentsOf: items, at: insertIndex)
    }
    
    // MARK: Update
    
    public func update(with items: [QuickTableViewCellModelProtocol]) {
        self.items.removeAll()
        add(items: items)
    }
    
    // MARK: Remove
    
    public func remove(itemAt index: Int) {
        guard items.count > index else {
            return
        }
        
        items.remove(at: index)
    }
    
    public func remove(itemWithId id: String) {
        guard let itemIndex = items.firstIndex(where: { $0.entity?.id == id }) else {
            return
        }
        
        items.remove(at: itemIndex)
    }
    
    // MARK: Other
    
    public func replace(item: QuickTableViewCellModelProtocol, at index: Int) {
        items[index] = item
    }
    
    // MARK: Indexes
    
    public func itemIndex(withId id: String) -> Int? {
        indexes[id]
    }
    
    public func index<CellId: RawRepresentable>(cellWithId cellId: CellId) -> Int? where CellId.RawValue == Int {
        items.firstIndex(where: { $0.id == cellId.rawValue })
    }
    
    // MARK: Private methods
    
    private func recalculateIndexes() {
        indexes = items.map({ $0.entity?.id }).enumerated().reduce(into: [String: Int](), { $0[$1.element ?? ""] = $1.offset })
    }
}
