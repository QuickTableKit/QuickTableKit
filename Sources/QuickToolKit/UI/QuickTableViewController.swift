//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

open class QuickTableViewController: UITableViewController {
    
    public lazy var collection = QuickTableViewCollection()
    public lazy var tableViewDataSource = QuickTableViewDataSource(collection: collection)
    
    public convenience init() {
        self.init(style: .insetGrouped)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
        setupTableData()
    }
    
    open func setupTableView() {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.keyboardDismissMode = .interactiveWithAccessory
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    open func setupTableData() { }
}

extension QuickTableViewController {
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource.numberOfSections(in: tableView)
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.tableView(tableView, numberOfRowsInSection: section)
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewDataSource.tableView(tableView, cellForRowAt: indexPath)
    }
}
