//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public protocol QuickTableViewHeaderModelProtocol: AnyObject {
    
    func getType() -> QuickTableViewHeaderProtocol.Type
}
