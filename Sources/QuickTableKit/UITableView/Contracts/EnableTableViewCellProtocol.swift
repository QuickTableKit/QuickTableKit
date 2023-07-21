//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

public protocol EnableTableViewCellModelProtocol: AnyObject {
    
    var isEnabled: Bool { get set }
}

public protocol EnableTableViewCellProtocol: AnyObject {
    
    func set(isEnabled: Bool)
}
