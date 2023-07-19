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
    
    var QuickRespondableConfig: QuickRespondableConfig? { get set }
}

public protocol QuickRespondableTableViewCellProtocol: AnyObject {
    
    func update(QuickRespondableConfig: QuickRespondableConfig?)
}

extension QuickRespondableTableViewCellProtocol {
    
    public func update(QuickRespondableConfig: QuickRespondableConfig?) { }
}
