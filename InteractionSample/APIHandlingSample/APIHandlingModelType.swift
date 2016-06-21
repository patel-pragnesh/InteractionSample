//
//  APIHandlingModelType.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/21.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import Foundation

enum APIHandlingModelType {
    case Single
    case Sync
    case Async
    
    var title: String {
        switch self {
        case .Single:
            return "シングルAPIリクエスト"
        case .Async:
            return "非同期APIリクエスト"
        case .Sync:
            return "同期APIリクエスト"
        }
    }
}
