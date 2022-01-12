//
//  ProductListViewController+BindingModel.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/8/22.
//  Copyright © 2022 Jumia. All rights reserved.
//
import UIKit
import SnapKit
import RxSwift
import RxCocoa

extension ProductListViewController {
    
    func bindingCollectionViewDataSource(){
        viewModel.outputs.products.bind(to: collectionView.rx.items) { (collection , index , item) in
            let index = IndexPath(row: index, section: 0)
            let cell = collection.dequeueReusableCell(withReuseIdentifier: Cells.ProductListItemCell.rawValue, for: index) as! ProductListItemCell
            cell.setup(with: item)
            return cell
        }.disposed(by: disposeBag)
    }
    
    func bindingSelecteCollectionViewItem(){
        collectionView.rx.modelSelected(ProductViewData.self)
        .subscribe(onNext : { [weak self] item in
            print("product was selected")
            self?.coordinator?.showProductDetails(with:item.sku)
        }).disposed(by: disposeBag)
    }
    
    func bindingCollectionViewScrolling(){
        collectionView.rx.reachedBottom
        .asObservable()
        .bind(to: viewModel.inputs.reachedBottomTrigger)
        .disposed(by: disposeBag)
    }
    
    func bindCollectionViewLoadingIndicator(){
        collectionView.setupLoadingIndicator()
        guard  let indicator = collectionView.backgroundView as? UIActivityIndicatorView else {
            return
        }
        viewModel.outputs.isLoading
        .bind(to: indicator.rx.isAnimating)
        .disposed(by: disposeBag)
    }
    
    func bindingLoadingError(){
        /* In order to test it you should toggle your internet connection */
        viewModel.outputs.onError
        .observe(on: MainScheduler.asyncInstance)
        .subscribe(onNext : {[weak self] event in
            self?.collectionView.setMessage(event)
        }).disposed(by: disposeBag)
    }
}
