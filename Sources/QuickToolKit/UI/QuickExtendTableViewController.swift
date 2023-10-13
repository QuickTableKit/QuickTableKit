//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

open class QuickExtendTableViewController: UIViewController {
    
    public lazy var collection = QuickTableViewCollection()
    public lazy var tableViewDataSource = QuickTableViewDataSource(collection: collection)
    
    public var tableView: UITableView
    
    public init(tableView: UITableView) {
        self.tableView = tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(style: UITableView.Style) {
        self.init(tableView: UITableView(frame: .zero, style: style))
    }
    
    public convenience init() {
        self.init(style: .insetGrouped)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        setupTableView()
        setupTableData()
    }
    
    open func setupTableView() {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.keyboardDismissMode = .interactiveWithAccessory
        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
    }
    
    open func setupTableData() { }
}

extension QuickExtendTableViewController: UITableViewDelegate {
    
}
