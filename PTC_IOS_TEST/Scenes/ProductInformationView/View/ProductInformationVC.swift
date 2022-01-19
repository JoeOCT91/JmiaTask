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

    
    
    override func loadView() {
        let productInformationView = ProductInformationView()
        self.productInformationView = productInformationView
        self.view = productInformationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productInformationView.imagesCollection.delegate = self
        self.configureDataSource()
        self.bindData()
        self.observeForDataError()
    }
    
    class func createProductInformationView(productIdentifier: String, coordinator: HomeCoordinator) -> ProductInformationVC {
        let productInformationVC = ProductInformationVC()
        let productInformationVM = ProductInformationVM(productIdentifier: productIdentifier)
        productInformationVC.viewModel = productInformationVM
        productInformationVC.coordinator = coordinator
        return productInformationVC
    }
    
    private func bindData() {
        viewModel.productInformationPublisher
            .dropFirst()
            .sink { productInformation in
                guard let productInformation = productInformation else { return }
                self.updateDataSource(urlAsString: productInformation.imageList)
                self.productInformationView.populateViewWithItemInformation(product: productInformation)
        } .store(in: &subscription)
    }
    
    private func observeForDataError() {
        viewModel.errorOccurredWhileGettingDataPublisher
            //.dropFirst()
            .sink { state in
                print(state)
                self.productInformationView.contentTableView.isHidden = state
                self.productInformationView.isErrorVisible = state
            }
            .store(in: &subscription)
    }
    
    private func updateDataSource(urlAsString: [String]?) {
        guard let urlAsString = urlAsString else { return }
        let items = urlAsString.map { string in return Item(urlAsString: string) }
        self.snapshot = DataSourceSnapshot()
        self.snapshot.appendSections([Section.main])
        self.snapshot.appendItems(items)
        DispatchQueue.main.async {
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
