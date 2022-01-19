//
//  ItemView.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import SwifterSwift
import Cosmos


class ProductInformationView: JumiaView {
    
    
    let contentTableView = UITableView()
    // Slide show views ...
    let imageView = UIImageView(frame: .zero)
    var imagesCollection: UICollectionView!

    let productImagesStack = UIStackView(frame: .zero)
    let productNameLabel = UILabel(frame: .zero)
    let brandLabel = UILabel(frame: .zero)
    let priceLabel = UILabel(frame: .zero)
    let priceBeforeLabel = UILabel(frame: .zero)
    let shortDescriptionLabel = UILabel(frame: .zero)
    let descriptionLabel = UILabel(frame: .zero)
    let ratingView = CosmosView(frame: .zero)
    
    
    let padding: CGFloat = 12
    
    override init() {
        super.init()
        self.backgroundColor = ColorName.bgColor.color
        self.setupViews()
        self.setInternalErrorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        configureContentTableView()
        configureImageCollection()
        configureRatingView()
        configureImageView()
    }
    
    private func configureContentTableView() {
        self.addSubview(contentTableView)
        contentTableView.fillToSuperview()
        contentTableView.backgroundColor = ColorName.productInfoTableViewBG.color
        contentTableView.separatorStyle = .none
        contentTableView.dataSource = self
        contentTableView.delegate = self
    }
    
    private func configureImageCollection() {
        let flowLayout =  Layouts.createSlideShowFlowLayout()
        imagesCollection = UICollectionView(frame: .zero, collectionViewLayout:flowLayout)
        imagesCollection.register(SlideShowCell.self, forCellWithReuseIdentifier: Cells.slideShowCell)
        imagesCollection.heightAnchor.constraint(equalToConstant: flowLayout.itemSize.height + 20).isActive = true
        imagesCollection.widthAnchor.constraint(equalToConstant: Measurements.screenWidth).isActive = true
    }
    
    private func configureImageView() {
        imageView.anchor( widthConstant: Measurements.screenWidth * 0.85,
                          heightConstant: Measurements.screenWidth * 0.85)
        imageView.contentMode = .scaleAspectFit
    }
  
    
    private func configureRatingView() {
        
    }
    
    internal func populateViewWithItemInformation(product: Product) {
        self.productNameLabel.text = product.name
        self.brandLabel.text = "Brand: \(product.brand)"
        self.priceLabel.text = "\(product.specialPrice) \(UserDefaultsManager.shared().currencySymbol!)"
        self.priceBeforeLabel.text = "\(product.price) \(UserDefaultsManager.shared().currencySymbol!)"
        self.shortDescriptionLabel.text = product.summary?.shortDescription
        self.ratingView.rating = Double(product.rating!.average)
        
        let description = product.summary?.summaryDescription.replacingOccurrences(of: "-", with: "\n- ")
        self.descriptionLabel.text = description
        contentTableView.reloadData()
    }
    
    internal func updateImage(image: UIImage?) {
        imageView.image = image
    }
}

extension ProductInformationView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = productInformationSections(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .slider:
            return createSlideShowCell()
        case .basicInformation:
            return basicInformationCell()
        case .productDetails:
            return createDescriptionCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        productInformationSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    private enum productInformationSections: Int, CaseIterable {
        case slider = 0
        case basicInformation = 1
        case productDetails = 2
    }
    
    private func basicInformationCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let containerView = UIStackView()
        cell.contentView.addSubview(containerView)
        containerView.fillToSuperview()
        let containerViews = [productNameLabel ,brandLabel, priceLabel, priceBeforeLabel, ratingView]
        containerView.addArrangedSubviews(containerViews)
        containerView.axis = .vertical
        containerView.distribution = .fillEqually
        containerView.spacing = 8
        containerView.isLayoutMarginsRelativeArrangement = true
        containerView.layoutMargins = EdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return cell
    }
    
    private func createSlideShowCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let containerView = UIStackView()
        cell.contentView.addSubview(containerView)
        containerView.fillToSuperview()
        containerView.addArrangedSubviews([imageView, imagesCollection])
        containerView.isLayoutMarginsRelativeArrangement = true
        containerView.layoutMargins = EdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
        containerView.spacing = padding
        containerView.alignment = .center
        containerView.axis = .vertical
        return cell
    }
    
    private func createDescriptionCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let containerView = UIStackView()
        cell.contentView.addSubview(containerView)
        containerView.fillToSuperview()
        let headerView = createHeader(title: L10n.productDetails)
        containerView.addArrangedSubviews([headerView ,descriptionLabel])
        containerView.axis = .vertical
        containerView.distribution = .fill
        descriptionLabel.numberOfLines = 0
        return cell
    }
    
    private func createHeader(title: String) -> UIView {
        let stack = UIStackView()
        stack.backgroundColor = ColorName.productInfoTableViewBG.color
        stack.distribution = .fill
        let label = JumiaLabel(title: title.uppercased())
        label.font = UIFont(font: FontFamily.Nunito.bold, size: 22)
        label.byInsets = UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding)
            label.paddingLeft = padding
        stack.addArrangedSubview(label)
        return stack
    }
}
