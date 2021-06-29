//
//  ItemDetailViewController.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 29/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class ItemDetailViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productOldPrice: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var prodectDiscount: UILabel!
    @IBOutlet weak var productDiscountBackground: UIView!
    @IBOutlet weak var productRating: UIView!
    @IBOutlet weak var productDescription: UITextView!
    
    var productData : Results?
    var productDetails : ProductDataResult?
    let viewModel = ItemDetailViewModel()
    
    lazy var cosmosView : CosmosView = {
        cosmosView = CosmosView()
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.filledBorderColor = AppColors.blackColor
        cosmosView.settings.filledColor = AppColors.jumiaOrangeColor
        return cosmosView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProductDetails(sku: productData?.sku ?? "")
    }
    
    func fetchProductDetails(sku : String){
        viewModel.getProductDetail(sku : sku).subscribe (onNext: { (dataResult) in
            switch(dataResult.status){
            case .success:
                self.productDetails = dataResult.data
                self.handelSuccess()
            case .error:
                self.handelFailure(dataResult: dataResult)
            case .loading:
                self.showLoadingIndicator()
            }
        }).disposed(by: baseDisposeBag)
    }
    
    func handelSuccess(){
        self.stopLoadingIndicator()
        productName.text = productDetails?.name ?? ""
        productBrand.text = productDetails?.brand ?? ""
        productOldPrice.text = "\(LocalStorage.getCurrencySymbol()) \(String(describing: productDetails?.price ?? 0))"
        productOldPrice.strikeThrough(true)
        productPrice.text = "\(LocalStorage.getCurrencySymbol()) \(String(describing: productDetails?.specialPrice ?? 0))"
        
        prodectDiscount.text = "\(productDetails?.maxSavingPercentage ?? 0) %"
        productDiscountBackground.discountBackgroundView()
        
        cosmosView.rating = Double(productDetails?.rating?.average ?? 0)
        cosmosView.text = "\(productDetails?.rating?.ratingsTotal ?? 0)"
        productRating.addSubview(cosmosView)
        
        productDescription.attributedText = (productDetails?.summary?.description ?? "").changeStringToparagraphStyle()
        productDescription.textColor = AppColors.blackColor
        productDescription.textAlignment = .left
        productDescription.font = UIFont.systemFont(ofSize: 14)
        pageControl.numberOfPages = productDetails?.images?.count ?? 0
        collectionView.reloadData()

    }
    
    func handelFailure(dataResult: DataResult<ProductDataResult>){
        self.stopLoadingIndicator()
    }
    
}


extension ItemDetailViewController : UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetails?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCell", for: indexPath) as! ProductDetailsCell
        cell.setupCellUI(productImageString: productDetails?.images?[indexPath.row] ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    
}

extension String {
    func changeStringToparagraphStyle() -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        return NSAttributedString(string: self , attributes:attributes)
    }
}
