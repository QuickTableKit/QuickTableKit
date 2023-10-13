//
// Copyright © 2023 QuickToolKit. All rights reserved.
//

import Foundation
import QuickToolKit

public final class EmptyTableViewCellModel: QuickTableViewCellModelProtocol {
    
    public var id: Int?
    
    public var entity: StringIdentifiable?
    
    public init(id: Int? = nil,
                entity: StringIdentifiable? = nil) {
        self.id = id
        self.entity = entity
    }
    
    public var type: QuickTableViewCellProtocol.Type {
        EmptyTableViewCell.self
    }
}
