//
//  ItemVC.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import Combine
import Alamofire

class ProductInformationVC: UIViewController {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  proprieties
    //----------------------------------------------------------------------------------------------------------------
    
    private enum Section: Hashable {
        case main
    }
    
    struct Item: Hashable {
        let uuid = UUID()
        let urlAsString: String
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Item>
    private var snapshot = DataSourceSnapshot()
    private var dataSource: DataSource!
    
    private var viewModel: ProductInformationVMProtocol!
    private var coordinator: HomeCoordinator?
    private var productInformationView: ProductInformationView!
    private var subscription = Set<AnyCancellable>()
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  lifecycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    
    override func loadView() {
        let productInformationView = ProductInformationView()
        self.productInformationView = productInformationView
        self.view = productInformationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productInformationView.imagesCollection.delegate = self
        self.observingDataLoading()
        self.observeForDataError()
        self.configureDataSource()
        self.bindData()
    }
    
    class func createProductInformationView(productIdentifier: String, coordinator: HomeCoordinator) -> ProductInformationVC {
        let productInformationVC = ProductInformationVC()
        let productInformationVM = ProductInformationVM(productIdentifier: productIdentifier)
        productInformationVC.viewModel = productInformationVM
        productInformationVC.coordinator = coordinator
        return productInformationVC
    }
    
    deinit {
        print("\(String(describing: self)) has been deinitializd ...)")
    }
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Private methods ...
    //----------------------------------------------------------------------------------------------------------------

    private func bindData() {
        viewModel.productInformationPublisher
            .dropFirst()
            .sink { [weak self] productInformation in
                guard let self = self else { return }
                guard let productInformation = productInformation else { return }
                self.updateDataSource(urlAsString: productInformation.imageList)
                self.productInformationView.populateViewWithItemInformation(product: productInformation)
        } .store(in: &subscription)
    }
    
    private func observeForDataError() {
        viewModel.errorOccurredWhileGettingDataPublisher
            .sink { [weak self] state in
                guard let self = self else { return }
                self.productInformationView.contentTableView.isHidden = state
                self.productInformationView.isErrorVisible = state
                self.productInformationView.errorText = ErrorMessages.noDataFound200.rawValue
            }
            .store(in: &subscription)
    }
    
    private func observingDataLoading() {
        viewModel.isLoadingDataPublisher
            .sink { [weak self ]state in
                guard let self = self else { return }
                switch state {
                case true:
                    self.productInformationView.contentTableView.isHidden = true
                    self.productInformationView.displayAnimatedActivityIndicatorView()
                case false:
                    self.productInformationView.contentTableView.isHidden = false
                    self.productInformationView.hideAnimatedActivityIndicatorView()
                }
            }
            .store(in: &subscription)
        
    }
    
    private func updateDataSource(urlAsString: [String]?) {
        guard let urlAsString = urlAsString else { return }
        let items = urlAsString.map { string in return Item(urlAsString: string) }
        self.snapshot = DataSourceSnapshot()
        self.snapshot.appendSections([Section.main])
        self.snapshot.appendItems(items)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dataSource.apply(self.snapshot, animatingDifferences: true)
        }
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: productInformationView.imagesCollection) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.slideShowCell,
                                                          for: indexPath) as! SlideShowCell
            cell.setImageWith(url: item.urlAsString)
            return cell
        }
    }
}

extension ProductInformationVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SlideShowCell
        productInformationView.updateImage(image: cell.productImage.image)
    }
}
