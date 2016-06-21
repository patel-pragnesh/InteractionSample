//
//  Progress.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/21.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import Foundation

import Foundation
import SVProgressHUD

struct Progress {

    var type: ProgressType
    
    init(type: ProgressType) {
        self.type = type
    }
    
    func Loading() {
        SVProgressHUD.setDefaultStyle(.Light)
        SVProgressHUD.showWithStatus(type.loadingMsg)
    }
    
    func Success() {
        SVProgressHUD.setDefaultStyle(.Light)
        SVProgressHUD.showSuccessWithStatus(type.successMsg)
    }
    
    func Error() {
        SVProgressHUD.setDefaultStyle(.Light)
        SVProgressHUD.showErrorWithStatus(type.errorMsg)
    }
    
    func Dismiss() {
        SVProgressHUD.dismiss()
    }
    
}

enum ProgressType {
    case Default
    
    var loadingMsg: String {
        switch self {
        default:
            return "読込中..."
        }
    }
    
    var successMsg: String {
        switch self {
        default:
            return "成功しました!"
        }
    }
    
    var errorMsg: String {
        switch self {
        default:
            return "ネットワーク接続エラーです"
        }
    }
}
