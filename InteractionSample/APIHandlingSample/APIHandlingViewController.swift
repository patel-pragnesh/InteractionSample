//
//  APIHandlingViewController.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/21.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class APIHandlingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    private let progress             = Progress(type: .Default)
    private let apiHandlingViewModel = APIHandlingViewModel()
    private let disposeBag           = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        binding()
    }
    
    private func configTableView() {
        tableView.registerNib(R.nib.aPIHandlingListCell(), forCellReuseIdentifier: R.nib.aPIHandlingListCell.name)
    }
    
    private func binding() {
        backButton.rx_tap
            .asObservable()
            .subscribeNext { (_) in
                self.goToPrev()
            }
            .addDisposableTo(disposeBag)
        
        apiHandlingViewModel.items
            .asDriver()
            .drive(tableView.rx_itemsWithCellIdentifier(R.nib.aPIHandlingListCell.name, cellType: APIHandlingListCell.self)) { (row, data, cell) in
                cell.config(title: "\(row). \(data.title)")
            }
            .addDisposableTo(apiHandlingViewModel.disposeBag)
        tableView
            .rx_modelSelected(APIHandlingModelType)
            .subscribeNext { (type) in
                self.request(type: type)
            }
            .addDisposableTo(disposeBag)
        tableView
            .rx_setDelegate(self)
            .addDisposableTo(disposeBag)
        
        apiHandlingViewModel.indicatorView
            .asObservable()
            .skip(1)
            .filter { $0 }
            .subscribeNext { (isShow) in
                self.progress.Loading()
            }
            .addDisposableTo(disposeBag)
        apiHandlingViewModel.completeView
            .asObservable()
            .skip(1)
            .filter { $0 }
            .subscribeNext { (isShow) in
                self.progress.Success()
                self.dismissProgress()
            }
            .addDisposableTo(disposeBag)
        apiHandlingViewModel.errorView
            .asObservable()
            .skip(1)
            .filter { $0 }
            .subscribeNext { (isShow) in
                self.progress.Error()
                self.dismissProgress()
            }
            .addDisposableTo(disposeBag)
    }
    
    private func request(type type: APIHandlingModelType) {
        apiHandlingViewModel.request(type: type)
    }
    
    private func dismissProgress() {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.progress.Dismiss()
        }
    }
    
    private func goToPrev() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension APIHandlingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
}
