//
//  ProductDetailsViewController.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/8/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import Cosmos
import RxCocoa
import RxSwift

class ProductDetailsViewController: UIViewController {
    
    weak var coordinator : MainCoordinator?
    
    @IBOutlet weak var currentImageView: UIImageView!
    
    @IBOutlet weak var imageCollection: UICollectionView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var oldPriceLabel: UILabel!
    
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var totalRatingLabel: UILabel!
    
    var viewModel : ProductDetailsViewModelProtocol!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureUIBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getProductDetails()
    }
    
    func configureUI()  {
        navigationItem.title = "Product Detail"
        registerCollectionCells()
    }
   
   func configureUIBinding() {
      bindingProductDetailsInfo()
      bindingCollectionViewImages()
      bindingSelectedImageToCurrentImageView()
      selectFirstItemOfImageCollection()
      bindingSelecteImageCollection()
   }
    
    func registerCollectionCells(){
        imageCollection.register(ProductImageItemCell.self, forCellWithReuseIdentifier: Cells.ProductImageItemCell.rawValue)
    }
    
}



/*extension ProductDetailsViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.ProductImageItemCell.rawValue, for: indexPath)
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("xcxvvxxv")
    }
}*/

