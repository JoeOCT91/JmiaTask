//
//  SearchViewController.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 28/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import UIKit
import Material

class SearchViewController: BaseViewController {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.spacing = 10
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = R.string.localizable.searchTextfieldPlaceholder()
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        return textField
    }()
    
    private let searchButton: RaisedButton = {
        let button = RaisedButton(title: R.string.localizable.searchButtonTitle(),
                                  titleColor: .white)
        button.pulseColor = .white
        button.backgroundColor = Color.blue.base
        button.addTarget(self, action: #selector(nav), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.all
        extendedLayoutIncludesOpaqueBars = true
        setupViews()
    }
    
    @objc
    func nav() {
        if let text = searchTextField.text {
            if !text.isEmpty {
                navigationController?.pushViewController(ProductListViewController(query: text),
                                                     animated: true)
            }
        }
    }
}

extension SearchViewController: CodableView {
    func configViews() {
        
    }
    
    func buildViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(searchTextField)
        stackView.addArrangedSubview(searchButton)
    }
    
    func configConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(100) 
        }
    }
}
