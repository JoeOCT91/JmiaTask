//
//  SearchViewController+BindingModel.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/10/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import RxSwift
import RxCocoa

extension SearchViewController {
    func subscribingToSearchFieldText(){
        searchField.rx.controlEvent([.editingDidEnd])
        .withLatestFrom(searchField.rx.text.orEmpty)
        .bind(to: viewModel.inputs.searchQuery)
        .disposed(by: disposeBag)
    }
    
    func subscribingToSearchButton(){
         searchButton.rx.tap
        .throttle(RxTimeInterval.milliseconds(500),scheduler: MainScheduler.instance)
        .bind(to: viewModel.inputs.searchTrigger)
        .disposed(by: disposeBag)
    }
    
    func bindingToShowSearchResults(){
        viewModel.outputs.searchResult
        .subscribe(onNext : { [weak self] item in
            guard let self = self else {return}
            self.configureIndicatorAlert()
            self.indicatorAlert?.show()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.indicatorAlert?.hide()
                self.coordinator?.showProducts()
            }
        }).disposed(by: disposeBag)
    }
    
    func bindingToNoSearchResults(){
        viewModel.outputs.noSearchResult
        .subscribe(onNext : { [weak self] item in
            guard let self = self , self.infoAlert == nil else {return}
            self.configureInfoAlert()
            self.infoAlert?.show(message : item)
        }).disposed(by: disposeBag)
    }
    
    func bindingToSearchButtonEnabled(){
        viewModel.outputs.searchButtonEnabled
        .subscribe(onNext : { [weak self] status in
            guard let self = self else {return}
            self.searchButton.isEnabled = status
        }).disposed(by: disposeBag)
    }
}
