//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    public static var identifier: String {
        String(describing: self)
    }
}

extension UITableViewCell {
    
    var tableView: UITableView? {
        return superview?.superview as? UITableView
    }
    
    @discardableResult
    public func activatePreviousCellResponder() -> Bool {
        guard let tableView = tableView else { return false }
        guard let indexPath = tableView.indexPath(for: self) else {
            return false
        }
        
        var currentIndexPath = indexPath
        while true {
            guard let nextIndexPath = previousCellIndex(currentIndexPath, tableView) else {
                break
            }
            
            currentIndexPath = nextIndexPath
            
            guard activateResponder(nextIndexPath, tableView, { cell in cell.activatePreviousCellResponder() }) else {
                continue
            }
            
            return true
        }
        
        return false
    }
    
    @discardableResult
    public func activateNextCellResponder() -> Bool {
        guard let tableView = tableView else { return false }
        guard let indexPath = tableView.indexPath(for: self) else {
            return false
        }
        
        var currentIndexPath = indexPath
        while true {
            guard let nextIndexPath = nextCellIndex(currentIndexPath, tableView) else {
                break
            }
            
            currentIndexPath = nextIndexPath
            
            guard activateResponder(nextIndexPath, tableView, { cell in cell.activateNextCellResponder() }) else {
                continue
            }
            
            return true
        }
        
        return false
    }
    
    private func activateResponder(_ indexPath: IndexPath,
                                   _ tableView: UITableView,
                                   _ failCompletion: @escaping (UITableViewCell) -> Void) -> Bool {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            UIView.animate(withDuration: 0.3, animations: {
                tableView.scrollToRow(at: indexPath, at: .none, animated: false)
            }, completion: { [weak tableView] (result) in
                guard result, let tableView = tableView else { return }
                
                guard let cell = tableView.cellForRow(at: indexPath) else {
                    return
                }
                
                if cell.canBecomeFirstResponder {
                    cell.becomeFirstResponder()
                } else {
                    failCompletion(cell)
                }
            })
            
            return true
        }
        
        guard cell.canBecomeFirstResponder else {
            return false
        }
        
        if !tableView.visibleCells.contains(cell) {
            UIView.animate(withDuration: 0.3, animations: {
                tableView.scrollToRow(at: indexPath, at: .none, animated: false)
            }, completion: { _ in
                cell.becomeFirstResponder()
            })
        } else {
            cell.becomeFirstResponder()
        }
        
        return true
    }
    
    private func nextCellIndex(_ indexPath: IndexPath, _ tableView: UITableView) -> IndexPath? {
        let sectionIndex = indexPath.section
        let itemIndex = indexPath.item
        
        let numberOfItemsInSection = tableView.numberOfRows(inSection: sectionIndex)
        
        if itemIndex + 1 < numberOfItemsInSection {
            return IndexPath(item: itemIndex + 1, section: sectionIndex)
        }
        
        guard sectionIndex + 1 < tableView.numberOfSections else {
            return nil
        }
        
        for i in (sectionIndex + 1...tableView.numberOfSections - 1) {
            guard tableView.numberOfRows(inSection: sectionIndex) > 0 else {
                continue
            }
            
            return IndexPath(item: 0, section: i)
        }
        
        return nil
    }
    
    private func previousCellIndex(_ indexPath: IndexPath, _ tableView: UITableView) -> IndexPath? {
        let sectionIndex = indexPath.section
        let itemIndex = indexPath.item
        
        if itemIndex > 0 {
            return IndexPath(item: itemIndex - 1, section: sectionIndex)
        }
        
        guard sectionIndex > 0 else {
            return nil
        }
        
        for i in (0...sectionIndex - 1).reversed() {
            let numberOfItems = tableView.numberOfRows(inSection: i)
            guard numberOfItems > 0 else {
                continue
            }
            
            return IndexPath(item: numberOfItems - 1, section: i)
        }
        
        return nil
    }
}
