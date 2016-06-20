//
//  ScrollZoom2ViewController.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/17.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ScrollZoom2ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageHeightConst: NSLayoutConstraint!
    @IBOutlet weak var imageBaseViewTopConst: NSLayoutConstraint!
    
    private let items           = Driver.just(["aaaaa", "aaaaa", "aaaaa", "aaaaa", "aaaaa"])
    private let IMAGEVIEWHEIGHT = UIScreen.mainScreen().bounds.size.width
    private let disposeBag      = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageHeightConst.constant = IMAGEVIEWHEIGHT
        configTableView()
        binding()
    }
    
    private func configTableView() {
        tableView.registerNib(R.nib.scrollZoom2Cell(), forCellReuseIdentifier: R.nib.scrollZoom2Cell.name)
        tableView.contentInset          = UIEdgeInsetsMake(85 + 200, 0, 0, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(85, 0, 0, 0)
        tableView.scrollsToTop          = false
    }
    
    private func binding() {
        backButton.rx_tap
            .asObservable()
            .subscribeNext { (_) in
                self.goToPrev()
            }
            .addDisposableTo(disposeBag)
        
        items
            .asDriver()
            .drive(tableView.rx_itemsWithCellIdentifier(R.nib.scrollZoom2Cell.name, cellType: ScrollZoom2Cell.self)) { (row, data, cell) in
                cell.config(title: data)
            }
            .addDisposableTo(disposeBag)
        tableView
            .rx_modelSelected(String)
            .subscribeNext { (title) in
                print(title)
            }
            .addDisposableTo(disposeBag)
        tableView.rx_contentOffset
            .asObservable()
            .filter { $0.y <= -self.IMAGEVIEWHEIGHT }
            .map { -$0.y }
            .bindTo(imageHeightConst.rx_constant)
            .addDisposableTo(disposeBag)
        tableView.rx_contentOffset
            .asObservable()
            .filter { $0.y >= -285 }
            .map { $0.y }
            .subscribeNext { (y) in
                print(y)
                self.imageBaseViewTopConst.constant = -(y + 285)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func goToPrev() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
