//
//  ProductDetailsViewController + BindingModel.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/9/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import Cosmos
import RxCocoa
import RxSwift
extension ProductDetailsViewController {
    
  func  bindingProductDetailsInfo(){
    viewModel.outputs.productDetails
    .observe(on: MainScheduler.instance)
    .subscribe(onNext :{ [weak self] info in
        guard let self = self else {return}
        self.priceLabel.text = info.specialPrice
        self.oldPriceLabel.text = info.price
        self.totalRatingLabel.text = "\(info.totalRating)"
        self.discountLabel.text = info.savingPercentage
        self.ratingView.rating = info.rating
        self.descriptionTextView.text = info.summary
        self.oldPriceLabel.strikethrough()
    }).disposed(by: disposeBag)
  }
    
    func bindingCollectionViewImages(){
        viewModel.outputs.productImages.bind(to: imageCollection.rx.items) {
            (collection , index , item) in
            let index = IndexPath(row: index, section: 0)
            let cell = collection.dequeueReusableCell(withReuseIdentifier: Cells.ProductImageItemCell.rawValue, for: index) as! ProductImageItemCell
            cell.setup(with: item)
            return cell
        }.disposed(by: disposeBag)
    }
    
    func selectFirstItemOfImageCollection(){
        viewModel.outputs.productImages.filter{$0.count > 0}
        .observe(on :MainScheduler.asyncInstance)
        .subscribe(onNext : {[weak self] items in
            let index = IndexPath(row: 0, section: 0)
            self?.imageCollection.selectItem(at: index, animated: false, scrollPosition: .left)
            self?.viewModel.inputs.selectedImage.onNext(items.first ?? "")
        }).disposed(by: disposeBag)
    }
    
    func bindingSelectedImageToCurrentImageView(){
        viewModel.inputs.selectedImage
        .subscribe(onNext : {[weak self] selectedItem in
            guard let self = self , let url = URL(string: selectedItem) else {return}
            self.currentImageView.kf.setImage(with: url)
        }).disposed(by: disposeBag)
    }
   
   func bindingSelecteImageCollection(){
       imageCollection.rx.modelSelected(String.self)
        .bind(to: viewModel.inputs.selectedImage)
      .disposed(by: disposeBag)
   }
    
    func bindingFetchingError(){
        viewModel.outputs.onError
        .observe(on: MainScheduler.instance)
        .subscribe(onNext : {[weak self] item in
            guard let self = self  else { return }
            let msg = "The product 'Not Found' in database \n Please try again later"
            self.showNoDetailsView(message : msg)
        }).disposed(by: disposeBag)
    }
    
}
