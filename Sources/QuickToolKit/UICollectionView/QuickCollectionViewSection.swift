//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public final class QuickCollectionViewSection {
    
    private var indexes: [String: Int] = [:]
    
    public private(set) var id: Int?
    public private(set) var entity: (any QuickIdentifiable)?
    public internal(set) var items: [QuickCollectionViewCellModelProtocol] {
        didSet {
            recalculateIndexes()
        }
    }
    
    public init(id: Int? = nil,
                entity: (any QuickIdentifiable)? = nil,
                items: [QuickCollectionViewCellModelProtocol] = []) {
        self.id = id
        self.entity = entity
        self.items = items
        
        recalculateIndexes()
    }
    
    public func index<CellId: RawRepresentable>(cellWithId cellId: CellId) -> Int? where CellId.RawValue == Int {
        items.firstIndex(where: { $0.id == cellId.rawValue })
    }
    
    internal func index(cellWithId id: String) -> Int? {
        return indexes[id]
    }
    
    // MARK: Private methods
    
    private func recalculateIndexes() {
        indexes = items.map({ $0.entity?.id }).enumerated().reduce(into: [String: Int](), { $0[$1.element ?? ""] = $1.offset })
    }
}
