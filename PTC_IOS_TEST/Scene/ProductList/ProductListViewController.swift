//
//  ProductListViewController.swift
//  PTC_IOS_TEST
//
//  Created by José Moreira Neto on 28/01/19.
//  Copyright © 2019 PTC. All rights reserved.
//

import UIKit

class ProductListViewController: BaseViewController {

    private var viewModel = ProductListViewModel()
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 0.5, height: 220)
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    init(delegate: ProductListViewModelDelegate? = nil, query: String) {
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = delegate ?? self
        viewModel.query = query
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoad()
        viewModel.fetchProductList(nextPage: false)
        setupViews()
    }
    
    private func fetchNextPage() {
        viewModel.fetchProductList(nextPage: true)
    }
}

extension ProductListViewController: CodableView {
    func configViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductListCollectionViewCell.self,
                                forCellWithReuseIdentifier: R.string.identifiers.productListCell())
        
        collectionView.addInfiniteScroll(handler: { _ in
            self.fetchNextPage()
        })
    }
    
    func buildViews() {
        view.addSubview(collectionView)
    }
    
    func configConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = ProductDetailViewController(productId: indexPath.row)
        navigationController?.pushViewController(detailController, animated: true)
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.string.identifiers.productListCell(),
                                                      for: indexPath) as! ProductListCollectionViewCell
        cell.cellLayout = viewModel.results[indexPath.row]
        return cell
    }
}

extension ProductListViewController: ProductListViewModelDelegate {
    func showTitle() {
        title = viewModel.title
    }
    
    func updateList(with animation: Bool) {
        hideLoad()
        collectionView.finishInfiniteScroll()
        collectionView.reloadData()
    }
    
    func preventScrolling() {
        collectionView.finishInfiniteScroll()
        collectionView.setShouldShowInfiniteScrollHandler { _ -> Bool in
            return false
        }
    }
    
    func showEmptyState() {
        hideLoad()
        if viewModel.results.isEmpty {
            collectionView.backgroundView = emptyStateView
            collectionView.reloadData()
        }
    }
}
