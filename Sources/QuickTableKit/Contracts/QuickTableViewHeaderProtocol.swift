//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public protocol QuickTableViewHeaderProtocol where Self: UITableViewHeaderFooterView {
    
    func update(model: QuickTableViewHeaderModelProtocol)
}
