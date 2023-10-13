//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public protocol QuickCollectionViewCellProtocol where Self: UICollectionViewCell {
    
    func update(model: QuickCollectionViewCellModelProtocol)
}
