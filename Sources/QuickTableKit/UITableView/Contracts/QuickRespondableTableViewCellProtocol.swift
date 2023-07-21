//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import Foundation

public struct QuickRespondableConfig {
    
    public var isPreviousInputEnabled: Bool?
    
    public var isNextInputEnabled: Bool?
    
    public init(isPreviousInputEnabled: Bool? = nil, isNextInputEnabled: Bool? = nil) {
        self.isPreviousInputEnabled = isPreviousInputEnabled
        self.isNextInputEnabled = isNextInputEnabled
    }
}

public protocol QuickRespondableTableViewCellModelProtocol: AnyObject {
    
    var respondableConfig: QuickRespondableConfig? { get set }
}

public protocol QuickRespondableTableViewCellProtocol: AnyObject {
    
    func update(respondableConfig: QuickRespondableConfig?)
}

extension QuickRespondableTableViewCellProtocol {
    
    public func update(respondableConfig: QuickRespondableConfig?) { }
}
