//
//  MainViewController.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/15.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let mainViewModel = MainViewModel()
    private let disposeBag    = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        binding()
    }
    
    private func configTableView() {
        tableView.registerNib(R.nib.mainCell(), forCellReuseIdentifier: R.nib.mainCell.name)
    }
    
    private func binding() {
        mainViewModel.dataSource.configureCell = {(dataSource, tableView, indexPath, _) in
            switch dataSource.itemAtIndexPath(indexPath) {
            case let .ScrollViewSectionItem(type):
                return self.configCell(tableView: tableView, indexPath: indexPath, name: type.name)
            case let .CollectionViewSectionItem(name):
                return self.configCell(tableView: tableView, indexPath: indexPath, name: name)
            }
        }
        
        mainViewModel.dataSource.canEditRowAtIndexPath = { _ in
            return false
        }
        
        mainViewModel.dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionAtIndex(index).title
        }
        
        mainViewModel.items
            .asObservable()
            .bindTo(tableView.rx_itemsWithDataSource(mainViewModel.dataSource))
            .addDisposableTo(disposeBag)
        
        tableView
            .rx_modelSelected(MainSectionItem)
            .subscribeNext { (item) in
                self.pageControl(sectionItem: item)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func configCell(tableView tableView: UITableView, indexPath: NSIndexPath, name: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(R.nib.mainCell.name, forIndexPath: indexPath) as? MainCell else { return UITableViewCell() }
        cell.config(number: indexPath.row + 1, name: name)
        return cell
    }
    
    private func pageControl(sectionItem sectionItem: MainSectionItem) {
        switch sectionItem {
        case let .ScrollViewSectionItem(type):
            self.presentViewController(type.viewController, animated: true, completion: nil)
        default:
            print("no page")
        }
    }
}
