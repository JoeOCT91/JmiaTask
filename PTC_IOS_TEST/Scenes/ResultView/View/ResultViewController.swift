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


class ResultViewController: UIViewController {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  proprieties
    //----------------------------------------------------------------------------------------------------------------
    
    private enum Section: Hashable {
        case main
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Product>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Product>
    private var snapshot = DataSourceSnapshot()
    private var dataSource: DataSource!
    
    private weak var coordinator: HomeCoordinator!
    private var subscription = Set<AnyCancellable>()
    private var viewModel: ResultVMProtocol!
    private var resultView: ResultView!
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lifecycle methods
    //----------------------------------------------------------------------------------------------------------------
    
    override func loadView() {
        let resultView = ResultView()
        self.resultView = resultView
        self.view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultView.collectionView.delegate = self
        self.dataErrorObserving()
        self.dataLoadingObserving()
        self.configureDataSource()
        self.bindProductListToCollectionView()

    }
    
    class func createResult(searchFor: String, coordinator: HomeCoordinator) -> ResultViewController {
        let resultVC = ResultViewController()
        let viewModel = ResultVM(searchFor: searchFor)
        resultVC.coordinator = coordinator
        resultVC.viewModel = viewModel
        return resultVC
    }
    
    deinit {
        print("\(String(describing: self)) has been deinitializd ...)")
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Private methods
    //----------------------------------------------------------------------------------------------------------------
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: resultView.collectionView) { [weak self]  collectionView, indexPath, product in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.TwoColumnProductCell,
                                                          for: indexPath) as! TwoColumnCollectionViewProductCell
            cell.populateCell(with: product)
            guard let self = self else { return cell }
            self.viewModel.currentValueIndex.send(indexPath.row)
            return cell
        }
        
    }
    
    private func bindProductListToCollectionView() {
        viewModel.resultListPublisher
            .sink { [weak self] productsList in
                guard let self = self else { return }
                self.snapshot = DataSourceSnapshot()
                self.snapshot.appendSections([Section.main])
                self.snapshot.appendItems(productsList)
                self.updateDataSource()
            }.store(in: &subscription)
    }
    
    private func updateDataSource() {
        DispatchQueue.main.async {
                self.dataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
    
    private func dataErrorObserving() {
        viewModel.errorOccurredWhileGettingDataPublisher
            .sink { [weak self] state in
                guard let self = self else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.resultView.hideAnimatedActivityIndicatorView()
                    self.resultView.collectionView.isHidden = state
                    self.resultView.isErrorVisible = state
                    self.resultView.errorText = ErrorMessages.networkError404.rawValue
                }
            }
            .store(in: &subscription)
    }
    
    private func dataLoadingObserving() {
        viewModel.isLoadingDataPublisher
            .sink { [weak self] state in
                guard let self = self else { return }
                    switch state {
                    case true:
                        self.resultView.displayAnimatedActivityIndicatorView()
                        self.resultView.collectionView.isHidden = state
                    case false:
                        self.resultView.hideAnimatedActivityIndicatorView()
                        self.resultView.collectionView.isHidden = state
                    }
                }
            .store(in: &subscription)
    }
}

extension ResultViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = dataSource.itemIdentifier(for: indexPath)
        guard let productIdentifier = product?.productIdentifier else { return }
        coordinator.pushProductInformation(productIdentifier: productIdentifier)
    }
}
