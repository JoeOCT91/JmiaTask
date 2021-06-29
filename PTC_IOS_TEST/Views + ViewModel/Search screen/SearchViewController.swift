//
//  SearchViewController.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 28/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var resultProductCollectionView: UICollectionView!
    
    
    let viewModel = SearchViewModel()
    
    var productData = [Results]()
    var searchPageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround() 
        setupNavigationBarUI(isHomePage: true)
        fetchProductData(query: "phone")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setupSearchBarUI()
        setupSearchBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupSearchBarUI(){
        searchBarTextField.tintColor = AppColors.blackColor
        searchBarTextField.textColor = AppColors.blackColor
        searchBarTextField.backgroundColor = AppColors.jumiaOrangeColor
        searchBarTextField.attributedPlaceholder = NSAttributedString(string: "Search for products",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: AppColors.blackColor])
        searchBarTextField.setLeftView(image: #imageLiteral(resourceName: "search"))
    }
    
    func setupSearchBackgroundView(){
        searchBarView.backgroundColor = AppColors.jumiaOrangeColor
        searchBarView.layer.cornerRadius = 10
        searchBarView.clipsToBounds = true
        searchBarView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
    
    
    func fetchProductData(query: String){
        viewModel.search(query: query, pageNumber: searchPageNumber).subscribe (onNext: { (dataResult) in
            switch(dataResult.status){
            case .success:
                self.handelSuccess()
                self.productData.append(contentsOf: dataResult.data?.results ?? [])
                self.resultProductCollectionView.reloadData()
            case .error:
                self.handelFailure(dataResult: dataResult)
            case .loading:
                self.showLoadingIndicator()
            }
        }).disposed(by: baseDisposeBag)
    }
    
    func handelSuccess(){
        self.stopLoadingIndicator()
        //        self.navigate(navigateKey: NavigationKeys.TAB_BAR_SCREEN)
    }
    
    func handelFailure(dataResult: DataResult<SearchDataResult>){
        self.stopLoadingIndicator()
        //        switch dataResult.errorType {
        //        case .SERVER_ERROR:
        //            let alertt = self.alertService.successAndFailureAlert(alertStatus: false, alertMessage: "تأكد من رقم الساب و كلمة المرور ", alertButtonTitle: "رجــوع"){}
        //            self.present(alertt,animated: true)
        //        default:
        //            self.handleError(errorResult: dataResult)
        //        }
    }
}

//MARK:- search bar collection view set up
extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCollectionViewCell", for: indexPath) as! HorizontalProductCell
        cell.setupCellUI(productResult: productData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == productData.count - 1 && searchPageNumber <= 2{
            searchPageNumber += 1
            fetchProductData(query: "phone")
        }
    }
    
}

