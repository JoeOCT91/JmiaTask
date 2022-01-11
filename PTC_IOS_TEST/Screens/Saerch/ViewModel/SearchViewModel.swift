//
//  SearchViewModel.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/10/22.
//  Copyright © 2022 Jumia. All rights reserved.
//
import RxSwift
import RxCocoa

class SearchViewModel: SearchViewModelProtocol , SearchViewModelEvents {

    var inputs: SearchViewModelProtocolInput {return self}
    var outputs: SearchViewModelProtocolOutput {return self}
    var searchQuery: BehaviorSubject<String>
    var searchTrigger : PublishSubject<Void>
    var searchResult: PublishSubject<Void>
    var noSearchResult: PublishSubject<String>
    var searchButtonEnabled : BehaviorSubject<Bool>
    let disposeBag = DisposeBag()
    
    init() {
        searchQuery = BehaviorSubject<String>(value: "")
        searchTrigger = PublishSubject<Void>()
        searchResult = PublishSubject<Void>()
        noSearchResult = PublishSubject<String>()
        searchButtonEnabled = BehaviorSubject<Bool>(value : false)
        subcribingToSearchTrigger()
        subcribingToSearchQuery()
    }
    
    func subcribingToSearchTrigger(){
        searchTrigger.subscribe(onNext: { [weak self]item in
            guard let self = self else {return}
            
            self.searchQuery.filter{$0.lowercased().trimmed == "phone"}
            .map{_ in Void()}
            .bind(to: self.searchResult)
            .disposed(by: self.disposeBag)
            
            self.searchQuery.filter{$0.lowercased().trimmed != "phone"} /* When there are no result */
            .subscribe(onNext :{[weak self] item in
             guard let self = self else {return}
                let message = "There are no results match your query \(item) please enter phone and retry again"
                self.noSearchResult.onNext(message)
                
            }).disposed(by: self.disposeBag)
                
        }).disposed(by: disposeBag)
    }
    
    
    
    func subcribingToSearchQuery(){
        searchQuery.filter{$0.count >= 5}
       .map{_ in true}
       .bind(to: searchButtonEnabled)
       .disposed(by: disposeBag)
    }
}
