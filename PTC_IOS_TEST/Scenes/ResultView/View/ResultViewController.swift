//
//  ResultVC.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import Combine
import CombineCocoa


class ResultVC: UIViewController, UICollectionViewDelegate {
    
    private enum Section: Hashable {
        case main
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Product>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Product>
    private var snapshot = DataSourceSnapshot()
    private var dataSource: DataSource!
    private weak var coordinator: HomeCoordinator!
    private var subscription = Set<AnyCancellable>()
    private var viewModel: ResultVM!
    private var resultView: ResultView!
    
    override func loadView() {
        let resultView = ResultView()
        self.resultView = resultView
        self.view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDataSource()
        self.bindProductListToCollectionView()
        self.resultView.collectionView.delegate = self
    }
    
    class func createResult(searchFor: String, coordinator: HomeCoordinator) -> ResultVC {
        let resultVC = ResultVC()
        let viewModel = ResultVM(searchFor: searchFor)
        resultVC.coordinator = coordinator
        resultVC.viewModel = viewModel
        return resultVC
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: resultView.collectionView) { collectionView, indexPath, product in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.TwoColumnProductCell,
                                                          for: indexPath) as! TwoColumnCollectionViewProductCell
            cell.populateCell(with: product)
            self.viewModel.currentValueIndex.send(indexPath.row)
            return cell
        }
        
    }
    
    internal func bindProductListToCollectionView() {
        viewModel.resultListPublisher
            .sink { [weak self] productsList in
                guard let self = self else { return }
                self.snapshot = DataSourceSnapshot()
                self.snapshot.appendSections([Section.main])
                self.snapshot.appendItems(productsList)
                DispatchQueue.main.async {
                    self.dataSource.apply(self.snapshot, animatingDifferences: true)
                }
        }.store(in: &subscription)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = dataSource.itemIdentifier(for: indexPath)
        guard let productIdentifier = product?.productIdentifier else { return }
        coordinator.pushProductInformation(productIdentifier: productIdentifier)
    }
}
