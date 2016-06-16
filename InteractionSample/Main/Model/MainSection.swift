//
//  MainSection.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/15.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import Foundation
import RxDataSources

enum MainSection {
    case ScrollViewSetion(title: String, items: [MainSectionItem])
    case UITabBarSection(title: String, items: [MainSectionItem])
    case CollectionViewSection(title: String, items: [MainSectionItem])
}

enum  MainSectionItem {
    case ScrollViewSectionItem(type: ScrollViewType)
    case UITabBarSectionItem(type: UITabBarType)
    case CollectionViewSectionItem(name: String)
}

extension MainSection: SectionModelType {
    typealias Item = MainSectionItem
    
    var items: [Item] {
        switch self {
        case .ScrollViewSetion(title: _, items: let items):
            return items.map { $0 }
        case .UITabBarSection(title: _, items: let items):
            return items.map { $0 }
        case .CollectionViewSection(title: _, items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: MainSection, items: [Item]) {
        self = original
    }
}

extension MainSection {
    var title: String {
        switch self {
        case .ScrollViewSetion(title: let title, items: _):
            return title
        case .UITabBarSection(title: let title, items: _):
            return title
        case .CollectionViewSection(title: let title, items: _):
            return title
        }
    }
}
