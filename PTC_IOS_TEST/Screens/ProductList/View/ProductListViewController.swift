//
//  ProductListViewController.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/5/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProductListViewController: UIViewController {
    
    weak var coordinator : MainCoordinator?
    
    var collectionView : UICollectionView!
    
    var  collectionLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    var viewModel : ProductListViewModelProtocol!
    let disposeBag  = DisposeBag()
    var cellHeight = CGFloat(300.0)
    var collectionPadding = CGFloat( 25.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProductListViewModel()
        configureUI()
        configureUIBinding()
        viewModel.loadProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    func configureUI(){
         view.backgroundColor = .white
         navigationItem.title = "Products"
         configureCollectionView()
         configureCollectionViewConstraints()
         confirgureCollectionCellsSize()
         registerCollectionCells()
    }
    
    func configureUIBinding(){
        bindingCollectionViewDataSource()
        bindingSelecteCollectionViewItem()
        bindingCollectionViewScrolling()
        bindCollectionViewLoadingIndicator()
        bindingLoadingError()
    }
    
    func configureCollectionView(){
      collectionView = UICollectionView(frame: .zero , collectionViewLayout: collectionLayout)
      collectionView.backgroundColor = .white
      collectionView.showsVerticalScrollIndicator = false
      view.addSubview(collectionView)
    }

    func confirgureCollectionCellsSize()  {
        let width  = UIScreen.main.bounds.width - collectionPadding // padding
        let cellSize = CGSize(width: (CGFloat(  width  / 2 )) , height: cellHeight)
        collectionLayout.itemSize = cellSize
    }
    
    func registerCollectionCells(){
        collectionView.register(ProductListItemCell.self, forCellWithReuseIdentifier: Cells.ProductListItemCell.rawValue)
    }
    
    func configureCollectionViewConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.snp.makeConstraints { maker in
            maker.leading.equalTo(view.snp.leading).offset(10)
            maker.trailing.equalTo(view.snp.trailing).offset(-10)
            maker.bottom.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }
}
