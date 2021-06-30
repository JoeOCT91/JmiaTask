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
    var searchedData = [String]()
    var searchedDataLast = String()
    var searchPageNumber = 1
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround() 
        setupNavigationBarUI(isHomePage: true)
        fetchProductData(query: "phone")
        searchBarTextField.delegate = self
        dropButton.selectionAction = { [unowned self] (index: Int, item: String) in
            searchedDataLast = item
            performSegue(withIdentifier: "goToResultListViewController" , sender: self)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        searchedData = viewModel.getSearchStrings()
        searchBarTextField.text = .none
        searchBarTextField.placeholder = "Search for products"
        resultProductCollectionView.isHidden = false
        searchBarTextField.setupSearchBarUI()
        searchBarView.setupSearchBackgroundView()
        setupDropDownList(searchBarTextField: searchBarTextField)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultListViewController = segue.destination as? ResultListViewController {
            resultListViewController.comingSearchedData = searchedDataLast
        }else if let itemDetailViewController = segue.destination as? ItemDetailViewController {
            itemDetailViewController.productData = productData[selectedIndex]
        }
    }
    
    
}

//MARK:- search bar collection view set up
extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalProductCell", for: indexPath) as! VerticalProductCell
        cell.setupCellUI(productResult: productData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == productData.count - 1 && searchPageNumber <= 2{
            searchPageNumber += 1
            fetchProductData(query: "phone")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "goToItemDetailScreen" , sender: self)
    }
    
    
}

//textfield delegation methods
extension SearchViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = searchBarTextField.text , !text.isEmpty{
            if !searchedData.contains(text) {
                searchedData.append(text)
                viewModel.saveSearch(search: searchedData)
            }
            dropButton.hide()
            searchedDataLast = searchedData.last ?? ""
            performSegue(withIdentifier: "goToResultListViewController" , sender: self)
        }else{
            resultProductCollectionView.isHidden = false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBarTextField.resignFirstResponder()
        dropButton.dataSource = viewModel.getSearchStrings()
        dropButton.show()
        resultProductCollectionView.isHidden = true
    }
}
