//
//  ProductDetailViewController.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 29/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import UIKit

public class ProductDetailViewController: BaseViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        return tableView
    }()
    
    private let viewModel = ProductDetailViewModel()
    private var emptyState = false
    
    init(delegate: ProductDetailViewModelDelegate? = nil, productId: Int) {
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = delegate ?? self
        viewModel.productId = productId
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        showLoad()
        viewModel.fetchProductDetail()
    }
    
    private func getTextCell() -> ProductDetailTextTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.string.identifiers.productDetailTextCell()) as! ProductDetailTextTableViewCell
    }
}

extension ProductDetailViewController: CodableView {
    func configViews() {
        tableView.configureTableView(viewController: self, estimateRowHeight: 100)
        tableView.register(ProductDetailImageTableViewCell.self,
                           forCellReuseIdentifier: R.string.identifiers.productDetailImageCell())
        tableView.register(ProductDetailPriceTableViewCell.self,
                           forCellReuseIdentifier: R.string.identifiers.productDetailPriceCell())
        tableView.register(ProductDetailTextTableViewCell.self,
                           forCellReuseIdentifier: R.string.identifiers.productDetailTextCell())
        tableView.register(ProductDetailRatingTableViewCell.self,
                           forCellReuseIdentifier: R.string.identifiers.productDetailRatingCell())
        
    
    }
    
    func buildViews() {
        view.addSubview(tableView)
    }
    
    func configConstraints() {
        tableView.snp.makeConstraints {
            $0.trailing.left.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func hideProductLoad() {
        setupViews()
        hideLoad()
        tableView.reloadData()
    }
}

extension ProductDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emptyState ? 0 : 6
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.string.identifiers.productDetailImageCell()) as! ProductDetailImageTableViewCell
            cell.imageUrl = viewModel.detail?.imageList?.first
            return cell
        case 1:
            let cell = getTextCell()
            cell.cellLayout = (viewModel.detail?.brand, .brand)
            return cell
        case 2:
            let cell = getTextCell()
            cell.cellLayout = (viewModel.detail?.name, .description)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.string.identifiers.productDetailPriceCell()) as! ProductDetailPriceTableViewCell
            cell.cellLayout = viewModel.detail
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.string.identifiers.productDetailRatingCell()) as! ProductDetailRatingTableViewCell
            cell.cellLayout = viewModel.detail?.rating
            return cell
        case 5:
            let cell = getTextCell()
            cell.cellLayout = (viewModel.detail?.summary?.description, .description)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ProductDetailViewController: ProductDetailViewModelDelegate {
    public func showEmptyState() {
        tableView.backgroundView = emptyStateView
        emptyState = true
        hideProductLoad()
    }
    
    public func showDetail() {
        title = viewModel.detail?.name
        hideProductLoad()
    }
}
