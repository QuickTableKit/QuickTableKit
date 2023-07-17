//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

public class QuickTableViewDataSource: NSObject, UITableViewDataSource {
    
    public private(set) var collection: QuickTableViewCollectionProtocol?
    
    public override init() {
        collection = nil
    }
    
    public init(collection: QuickTableViewCollectionProtocol) {
        self.collection = collection
    }
    
    public func update(collection: QuickTableViewCollectionProtocol) {
        self.collection = collection
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        collection?.numberOfSections() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collection?.numberOfItems(in: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = collection?.cellType(at: indexPath),
              let cell = tableView.dequeue(cellType: cellType, for: indexPath) as? QuickTableViewCellProtocol,
              let cellModel = collection?.cell(at: indexPath) else {
            fatalError("Cell cannot be dequeue")
        }
        
        cell.update(model: cellModel)
        
        return cell
    }
    
    public func dequeue(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UITableViewHeaderFooterView {
        guard let headerType = collection?.headerType(at: section),
              let header = tableView.dequeue(headerFooterType: headerType) as? QuickTableViewHeaderProtocol,
              let headerModel = collection?.header(at: section) else {
            fatalError("Header cannot be dequeue")
        }
        
        header.update(model: headerModel)
        return header
    }
    
    public func dequeue(_ tableView: UITableView, viewForFooterInSection section: Int) -> UITableViewHeaderFooterView {
        guard let footerType = collection?.footerType(at: section),
              let footer = tableView.dequeue(headerFooterType: footerType) as? QuickTableViewHeaderProtocol,
              let footerModel = collection?.footer(at: section) else {
            fatalError("Header cannot be dequeue")
        }
        
        footer.update(model: footerModel)
        return footer
    }
}
