//
// Copyright © 2023 QuickToolKit. All rights reserved.
//

import UIKit
import QuickToolKit

public final class EmptyTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func setupUI() {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}

extension EmptyTableViewCell: QuickTableViewCellProtocol {
    
    public func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? EmptyTableViewCellModel else {
            return
        }
    }
}
