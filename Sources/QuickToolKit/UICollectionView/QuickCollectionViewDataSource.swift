//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import Foundation
import UIKit

public class QuickCollectionViewDataSource: NSObject {
    
    public private(set) var collection: QuickCollectionViewCollection
    
    public init(collection: QuickCollectionViewCollection) {
        self.collection = collection
    }
    
    public func update(collection: QuickCollectionViewCollection) {
        self.collection = collection
    }
}

extension QuickCollectionViewDataSource: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collection.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.numberOfItems(in: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = collection.cellType(at: indexPath),
              let cell = collectionView.dequeue(cellType: cellType, for: indexPath) as? QuickCollectionViewCellProtocol,
              let cellModel = collection.cell(at: indexPath) else {
            fatalError("Cell cannot be dequeue")
        }
        
        cell.update(model: cellModel)
        
        return cell
    }
}
