//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public protocol QuickTableViewCellModelProtocol: AnyObject {
    
    typealias StringIdentifiable = any Identifiable<String>
    
    var type: QuickTableViewCellProtocol.Type { get }
    
    var id: Int? { get set }
    
    var entity: StringIdentifiable? { get set }
}
