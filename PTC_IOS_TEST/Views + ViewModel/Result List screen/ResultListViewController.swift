//
//  ResultListViewController.swift
//  PTC_IOS_TEST
//
//  Created by Mahmoud El-Melligy on 29/06/2021.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit

class ResultListViewController: BaseViewController {
    
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var productData = [Results]()
    
    var comingSearchedData = String()
    var searchedData = [String]()
    var searchPageNumber = 1
    var selectedIndex = 0
    
    let viewModel = ResultListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupNavigationBarUI(isHomePage: true)
        fetchProductData(query: comingSearchedData)
        dropButton.selectionAction = { [unowned self] (index: Int, item: String) in
            self.fetchProductData(query: item)
            
        }
        searchBarTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
        searchedData = viewModel.getSearchStrings()
        searchBarTextField.text = comingSearchedData
        searchBarTextField.setupSearchBarUI()
        searchBarView.setupSearchBackgroundView()
        setupDropDownList(searchBarTextField: searchBarTextField)
    }
    
    func fetchProductData(query: String){
        viewModel.search(query: query, pageNumber: searchPageNumber).subscribe (onNext: { (dataResult) in
            switch(dataResult.status){
            case .success:
                self.handelSuccess()
                self.productData.append(contentsOf: dataResult.data?.results ?? [])
                self.tableView.reloadData()
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

extension ResultListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HorizontalProductCell") as! HorizontalProductCell
        cell.setupCellUI(productResult: productData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == productData.count - 1 && searchPageNumber <= 2{
            searchPageNumber += 1
            fetchProductData(query: "phone")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 203
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "goToItemDetailScreen" , sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemDetailViewController = segue.destination as? ItemDetailViewController {
            itemDetailViewController.productData = productData[selectedIndex]
        }
    }
    
    
}


//textfield delegation methods
extension ResultListViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBarTextField.resignFirstResponder()
        if let text = searchBarTextField.text , !text.isEmpty{
            if !searchedData.contains(text) {
                searchedData.append(text)
                viewModel.saveSearch(search: searchedData)
            }
            self.fetchProductData(query: text)
        }else{
            back()
            dropButton.hide()
        }
        searchBarTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dropButton.dataSource = viewModel.getSearchStrings()
        dropButton.show()
        tableView.isHidden = true
    }
    
    
}
