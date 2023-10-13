//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public protocol QuickTableViewHeaderFooterViewProtocol where Self: UITableViewHeaderFooterView {
    
    func update(model: QuickTableViewHeaderFooterModelProtocol)
}
