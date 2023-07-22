//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

open class QuickExtendTableViewController: UIViewController {
    
    public lazy var collection = QuickTableViewCollection()
    public lazy var tableViewDataSource = QuickTableViewDataSource(collection: collection)
    
    public var tableView: UITableView
    
    open var contentBackgroundColor: UIColor {
        UIColor.secondarySystemBackground
    }
    
    open var isRefreshIndicationEnable: Bool = false {
        didSet {
            if isRefreshIndicationEnable && refreshControl == nil {
                refreshControl = makeRefreshControl()
            } else if refreshControl != nil && !isRefreshIndicationEnable {
                refreshControl?.removeFromSuperview()
                refreshControl = nil
            }
        }
    }
    
    public var canCloseViewController: Bool = true {
        didSet {
            navigationItem.hidesBackButton = !canCloseViewController
        }
    }
    
    public var refreshControl: UIRefreshControl? {
        didSet {
            tableView.refreshControl = refreshControl
        }
    }
    
    public init(style: UITableView.Style) {
        tableView = UITableView(frame: .zero, style: style)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(nibName: nil, bundle: nil)
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
        view.backgroundColor = contentBackgroundColor
        
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
        tableView.backgroundColor = contentBackgroundColor
    }
    
    open func setupTableData() {
        
    }
    
    open func didTapRefresh() {
        
    }
    
    // swiftlint:disable line_length
    public func reloadTableRowIfPossible<SectionId: RawRepresentable, CellId: RawRepresentable>(sectionId: SectionId, cellId: CellId) where SectionId.RawValue == Int, CellId.RawValue == Int {
        guard let cellIndex = collection.index(cellWithSectionType: sectionId, andCellType: cellId),
              tableView.hasAnyCells() else {
            return
        }
        
        tableView.reloadRows(at: [cellIndex], with: .none)
    }
    
    public func reloadTableSectionIfPossible<SectionId: RawRepresentable>(sectionId: SectionId) where SectionId.RawValue == Int {
        guard let sectionIndex = collection.index(sectionWithType: sectionId),
              tableView.hasAnyCells() else {
            return
        }
        
        tableView.reloadSections([sectionIndex], with: .none)
    }
    
    public func insertTableSectionIfPossible<SectionId: RawRepresentable>(sectionId: SectionId) where SectionId.RawValue == Int {
        guard let sectionIndex = collection.index(sectionWithType: sectionId),
              tableView.hasAnyCells() else {
            return
        }
        
        tableView.insertSections([sectionIndex], with: .fade)
    }
    
    private func makeRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addAction(for: .valueChanged) { [unowned self] in
            self.didTapRefresh()
        }
        return refreshControl
    }
}

extension QuickExtendTableViewController: UITableViewDelegate {
    
}
