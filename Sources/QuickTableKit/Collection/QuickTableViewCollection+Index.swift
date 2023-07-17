//
// Copyright © 2023 QuickTableKit. All rights reserved.
//

import Foundation

extension QuickTableViewCollection {
    
    public func index(sectionWithId id: String) -> Int? {
        indexes[id]
    }
    
    public func index<SectionId: RawRepresentable>(sectionWithType sectionId: SectionId) -> Int? where SectionId.RawValue == Int {
        sections.firstIndex(where: { $0.id == sectionId.rawValue })
    }
    
    public func index(cellWithId id: String) -> IndexPath? {
        for (sectionIndex, section) in sections.enumerated() {
            guard let itemIndex = section.itemIndex(withId: id) else {
                continue
            }
            
            return IndexPath(item: itemIndex, section: sectionIndex)
        }
        
        return nil
    }
    
    public func index<SectionId: RawRepresentable, CellId: RawRepresentable>(cellWithSectionType sectionId: SectionId, andCellType cellId: CellId) -> IndexPath? where SectionId.RawValue == Int, CellId.RawValue == Int {
        guard let sectionIndex = sections.firstIndex(where: { $0.id == sectionId.rawValue }),
              let cellIndex = sections[sectionIndex].items.firstIndex(where: { $0.id == cellId.rawValue }) else {
            return nil
        }
        
        return IndexPath(item: cellIndex, section: sectionIndex)
    }
    
    public func firstSectionIndex<SectionId: RawRepresentable>(sectionIds: [SectionId]) -> Int? where SectionId.RawValue == Int {
        for sectionId in sectionIds {
            if let sectionIndex = index(sectionWithType: sectionId) {
                return sectionIndex
            }
        }
        
        return nil
    }
}
