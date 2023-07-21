//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import Foundation

public struct StringIdentifiable: IdentifiableEntity {
    
    public var id: String
    
    init(_ id: String) {
        self.id = id
    }
}
