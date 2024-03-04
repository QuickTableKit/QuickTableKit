//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import QuickToolKit

class ViewController: QuickTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = 44
        tableView.register(cellType: TextEditTableViewCell.self)
        tableView.register(cellType: EmptyTableViewCell.self)
        
        let section = QuickTableViewSection()
        
        for i in (0...100) {
            if (i + 1) % 10 < 3 {
                section.add(item: EmptyTableViewCellModel(
                    entity: ExmapleEntity(id: "sds")
                ))
            } else {
                section.add(item: TextEditTableViewCellModel(titleText: "Field #\(i + 1)"))
            }
        }
        
        collection.update(with: [section])
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("[SD] \(collection.cell(at: indexPath)?.entity?.id)")
        return (indexPath.item + 1) % 10 < 3 ? 600 : UITableView.automaticDimension
    }
}

struct ExmapleEntity: QuickIdentifiable {
    
    var id: String
}
