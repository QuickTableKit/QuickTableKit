//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import Foundation

public protocol QuickCollectionViewCellModelProtocol: AnyObject {
    
    typealias StringIdentifiable = any Identifiable<String>
    
    var type: QuickCollectionViewCellProtocol.Type { get }
    
    var id: Int? { get set }
    
    var entity: StringIdentifiable? { get set }
}
