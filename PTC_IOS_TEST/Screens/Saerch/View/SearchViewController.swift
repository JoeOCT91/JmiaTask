//
//  SearchViewController.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/10/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: ParentViewController {
    //MARK: UI Components
    lazy var mainStack  : UIStackView =  {
       let stack = UIStackView(arrangedSubviews: [searchField , searchButton])
       stack.axis = .vertical
       stack.spacing = 30
       return stack
    }()
    
    var searchField : UITextField = {
        let field = UITextField()
        field.placeholder = "Search..."
        field.font = UIFont.systemFont(ofSize: 15)
        field.layer.borderWidth = 0.5
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.layer.borderColor = UIColor.orange.cgColor
        return field
    }()
    
    var searchButton : UIButton = {
        let button = UIButton()
        button.setTitle("Serach", for: .normal)
        button.setTitleColor(.darkGray, for: .highlighted)
        button.setTitleColor(.lightGray, for: .disabled)
        button.isEnabled = false
        button.backgroundColor = .orange
        return button
    }()
    
    //MARK: Properties
    weak var coordinator : MainCoordinator?
    var viewModel : SearchViewModelProtocol!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel()
        configureUI()
        configureUIBinding()
    }
    
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Search"
        view.addSubview(mainStack)
        configureUIConstraints()
    }
    
    func configureUIBinding(){
        subscribingToSearchFieldText()
        subscribingToSearchButton()
        bindingToShowSearchResults()
        bindingToNoSearchResults()
        bindingToSearchButtonEnabled()
    }
    
    func configureUIConstraints(){
        mainStack.snp.makeConstraints { maker in
            maker.centerY.equalTo(view.snp.centerY).offset(-20)
            maker.leading.equalTo(view.snp.leading).offset(25)
            maker.trailing.equalTo(view.snp.trailing).offset(-25)
        }
        
        searchField.snp.makeConstraints { maker in
            maker.height.equalTo(40)
        }
    }
    
}
