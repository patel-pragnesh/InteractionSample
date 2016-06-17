//
//  MainViewModel.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/15.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class MainViewModel {
    
    private let sections: [MainSection] = [
        .ScrollViewSetion(title: "scrollView Interactions", items: [
                .ScrollViewSectionItem(type: .ScrollZoom),
                .ScrollViewSectionItem(type: .ScrollZoom2),
                .ScrollViewSectionItem(type: .SlideScroll)
            ]),
        .UITabBarSection(title: "UITabBar Interactions", items: [
                .UITabBarSectionItem(type: .TabBarHide)
            ])
    ]
    
    let dataSource = RxTableViewSectionedReloadDataSource<MainSection>()
    let items      = Variable<[MainSection]>([])
    
    init() {
        binding()
    }
    
    private func binding() {
        items.value = sections
    }
}
