//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public protocol QuickTableViewCellProtocol where Self: UITableViewCell {
    
    func update(model: QuickTableViewCellModelProtocol)
}
