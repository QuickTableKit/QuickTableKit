//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import Foundation

public protocol QuickTableViewCollectionProtocol: AnyObject {
    
    func numberOfSections() -> Int
    
    func numberOfItems(in section: Int) -> Int
    
    func cellType(at indexPath: IndexPath) -> QuickTableViewCellProtocol.Type?
    
    func cell(at indexPath: IndexPath) -> QuickTableViewCellModelProtocol?
    
    func hasHeader(at section: Int) -> Bool
    
    func hasFooter(at section: Int) -> Bool
    
    func headerType(at section: Int) -> QuickTableViewHeaderProtocol.Type?
    
    func footerType(at section: Int) -> QuickTableViewHeaderProtocol.Type?
    
    func header(at section: Int) -> QuickTableViewHeaderModelProtocol?
    
    func footer(at section: Int) -> QuickTableViewHeaderModelProtocol?
}
