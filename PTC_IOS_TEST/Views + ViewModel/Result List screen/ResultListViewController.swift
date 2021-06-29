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
        dropButton.selectionAction = { [unowned self] (index: Int, item: String) in
            comingSearchedData = item
            searchBarTextField.text = item
            self.fetchProductData(query: item)
            
        }
        searchBarTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchProductData(query: comingSearchedData)
        navigationItem.hidesBackButton = true
        tableView.isHidden = true
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
                self.productData.append(contentsOf: self.handelSuccess(productData: dataResult.data?.results))
                self.tableView.reloadData()
            case .error:
                self.handelFailure(dataResult: dataResult)
            case .loading:
                self.showLoadingIndicator()
            }
        }).disposed(by: baseDisposeBag)
    }
    
    func handelSuccess(productData : [Results]?) -> [Results]{
        tableView.isHidden = false
        self.stopLoadingIndicator()
        guard let dataResult = productData, !dataResult.isEmpty else {
            tableView.isHidden = true
            self.noSearchResult()
            return  []
        }
        self.CustomViewForNoDataUIView(labelText: "", imageIcone: #imageLiteral(resourceName: "empty_search"))
        return  dataResult
    }
    
    func handelFailure(dataResult: DataResult<SearchDataResult>){
        self.stopLoadingIndicator()
            tableView.isHidden = true
            switch dataResult.errorType {
            case .CONNECTION_ERROR:
                noSearchResult()
            case .SERVER_ERROR:
                noInternetConnection()
            case .none:
                stopLoadingIndicator()
            }
    }
    
    
    func noSearchResult(){
        self.CustomViewForNoDataUIView(labelText: "No search results for that search", imageIcone: #imageLiteral(resourceName: "empty_search").withTintColor(AppColors.jumiaOrangeColor))
    }
    
    func noInternetConnection(){
        self.CustomViewForNoDataUIView(labelText: "No internet connection", imageIcone: #imageLiteral(resourceName: "clear"))
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
