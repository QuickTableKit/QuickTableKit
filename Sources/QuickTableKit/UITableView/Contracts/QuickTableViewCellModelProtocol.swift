//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public protocol QuickTableViewCellModelProtocol: AnyObject {
    
    var type: QuickTableViewCellProtocol.Type { get }
    
    var id: Int? { get set }
    
    var entity: IdentifiableEntity? { get set }
}
