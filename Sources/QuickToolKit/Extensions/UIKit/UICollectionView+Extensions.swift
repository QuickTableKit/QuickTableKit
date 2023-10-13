//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public func register(cellType: UICollectionViewCell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    public func dequeue<Element: UICollectionViewCell>(cellType: Element.Type, for indexPath: IndexPath) -> Element {
        let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath)
        
        guard let element = cell as? Element else {
            fatalError("Cell \(cell) cannot be casted as \(cellType.identifier)")
        }
        
        return element
    }
}
