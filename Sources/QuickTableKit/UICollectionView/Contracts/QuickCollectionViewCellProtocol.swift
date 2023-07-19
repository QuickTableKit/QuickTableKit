//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

public protocol QuickCollectionViewCellProtocol where Self: UICollectionViewCell {
    
    func update(model: QuickCollectionViewCellModelProtocol)
}
