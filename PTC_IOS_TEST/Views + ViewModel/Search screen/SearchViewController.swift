//
//  SearchViewController.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 28/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import UIKit
import DropDown

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var resultProductCollectionView: UICollectionView!
    
    
    let viewModel = SearchViewModel()
    
    var dropButton = DropDown()
    var productData = [Results]()
    var searchedData = [String]()
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
        setuoDropDownList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupSearchBarUI(){
        searchBarTextField.tintColor = AppColors.blackColor
        searchBarTextField.textColor = AppColors.blackColor
        searchBarTextField.backgroundColor = AppColors.jumiaOrangeColor
        searchBarTextField.returnKeyType = .search
        searchBarTextField.delegate = self
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
    
    func setuoDropDownList(){
        dropButton.anchorView = searchBarTextField
        dropButton.bottomOffset = CGPoint(x: 0, y:(dropButton.anchorView?.plainView.bounds.height)!)
        dropButton.textColor = AppColors.blackColor
        dropButton.backgroundColor = AppColors.jumiaOrangeColor
        dropButton.direction = .bottom
        DropDown.startListeningToKeyboard()
        dropButton.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)") 
        }
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
    }
    
    func handelFailure(dataResult: DataResult<SearchDataResult>){
        self.stopLoadingIndicator()
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

//textfield delegation methods
extension SearchViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBarTextField.resignFirstResponder()
        if let text = searchBarTextField.text , !text.isEmpty{
            searchedData.append(text)
        }else{
            resultProductCollectionView.isHidden = false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dropButton.dataSource = searchedData
        dropButton.show()
        resultProductCollectionView.isHidden = true
    }
    
    
}
