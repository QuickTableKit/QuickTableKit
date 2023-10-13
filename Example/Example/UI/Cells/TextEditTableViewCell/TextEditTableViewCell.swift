//
// Copyright © 2023 QuickToolKit. All rights reserved.
//

import UIKit
import QuickToolKit

public final class TextEditTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textColor = UIColor.label
        textField.delegate = self
        return textField
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, textField])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var canBecomeFirstResponder: Bool {
        textField.canBecomeFirstResponder
    }
    
    public override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
    }
    
    // MARK: Private methods
    
    private func setupUI() {
        contentView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            contentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        titleLabel.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        textField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}

extension TextEditTableViewCell: QuickTableViewCellProtocol {
    
    public func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? TextEditTableViewCellModel else {
            return
        }
        
        titleLabel.text = model.titleText
        
        textField.returnKeyType = .next
    }
}

extension TextEditTableViewCell: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activatePreviousCellResponder()
        return true
    }
}
