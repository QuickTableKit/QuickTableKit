//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

public final class QuickCollectionViewSection {
    
    private var indexes: [String: Int] = [:]
    
    public private(set) var id: Int?
    public private(set) var entity: IdentifiableEntity?
    public internal(set) var items: [QuickCollectionViewCellModelProtocol] {
        didSet {
            recalculateIndexes()
        }
    }
    
    public init(id: Int? = nil,
                entity: IdentifiableEntity? = nil,
                items: [QuickCollectionViewCellModelProtocol] = []) {
        self.id = id
        self.entity = entity
        self.items = items
        
        recalculateIndexes()
    }
    
    public func index<CellId: RawRepresentable>(withId cellId: CellId) -> Int? where CellId.RawValue == Int {
        items.firstIndex(where: { $0.id == cellId.rawValue })
    }
    
    internal func index(withEntityId id: String) -> Int? {
        return indexes[id]
    }
    
    // MARK: Private methods
    
    private func recalculateIndexes() {
        indexes = items.map({ $0.entity?.id }).enumerated().reduce(into: [String: Int](), { $0[$1.element ?? ""] = $1.offset })
    }
}
