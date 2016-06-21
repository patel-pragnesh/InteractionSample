//
//  APIHandlingViewModel.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/21.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class APIHandlingViewModel {
    
    let requestState  = Variable<RequestStatus>(.None)
    let indicatorView = Variable<Bool>(true)
    let completeView  = Variable<Bool>(true)
    let errorView     = Variable<Bool>(true)
    
    let disposeBag = DisposeBag()
    let items = Driver.just([
            APIHandlingModelType.Single,
            APIHandlingModelType.Sync,
            APIHandlingModelType.Async
        ])
    
    init() {
        binding()
    }
    
    private func binding() {
        requestState
            .asObservable()
            .map { $0 == RequestStatus.Requesting }
            .bindTo(indicatorView)
            .addDisposableTo(disposeBag)
        requestState
            .asObservable()
            .map { $0 == RequestStatus.Error }
            .bindTo(errorView)
            .addDisposableTo(disposeBag)
        requestState
            .asObservable()
            .map { $0 == RequestStatus.Complete }
            .bindTo(completeView)
            .addDisposableTo(disposeBag)
    }
    
    func request(type type: APIHandlingModelType) {
        requestState.value = .Requesting
        switch type {
        case .Single:
            singleRequest()
                .asObservable()
                .subscribe(
                    onNext: { (items) in
//                        print(items)
                    },
                    onError: { error in
                        self.requestState.value = .Error
//                        print(error)
                    },
                    onCompleted: { _ in
                        self.requestState.value = .Complete
//                        print("complete")
                    })
                .addDisposableTo(disposeBag)
        default:
            break
        }
    }
    
    private func singleRequest() -> Observable<Bool> {
        let params = [
            "page" : "100",
            "per_page" : "100000"
        ]
        return Observable.create { (observer: AnyObserver<Bool>) in
            Alamofire
                .request(API.Router.Item(params))
                .responseJSON { (response) in
                    switch response.result {
                    case .Success(let value):
                        print(value)
                        switch (response.response?.statusCode)! {
                        case 200..<300:
                            observer.onNext(true)
                            observer.onCompleted()
                        default:
                            observer.onError(APIErrorType.RequestError)
                        }
                        break
                    case .Failure(let error):
                        observer.onError(error)
                        break
                    }
                }
             return AnonymousDisposable {}
        }
    }
}
