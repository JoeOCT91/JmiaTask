//
//  ProductInformationVM.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 16/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
import Combine

protocol ProductInformationVMProtocol: AnyObject {
    var productInformationPublisher: Published<Product?>.Publisher { get }
    var errorOccurredWhileGettingDataPublisher : Published<Bool>.Publisher { get }
    var isLoadingDataPublisher: Published<Bool>.Publisher { get }
}

class ProductInformationVM: ProductInformationVMProtocol {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private var anyCancelable = Set<AnyCancellable>()
    @Published private var productInformation: Product!
    internal var productInformationPublisher: Published<Product?>.Publisher {$productInformation}
    @Published private var isError: Bool = false
    @Published private var isLoading: Bool = false
    internal var isLoadingDataPublisher: Published<Bool>.Publisher {$isLoading}
    internal var errorOccurredWhileGettingDataPublisher : Published<Bool>.Publisher {$isError}
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    
    init(productIdentifier: String) {
        self.getProductWith(identifier: productIdentifier)
    }
    
    deinit {
        print(String(describing: self) + " has been deisnalized... ")
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  private Methods ...
    //----------------------------------------------------------------------------------------------------------------
    
    private func getProductWith(identifier: String) {
        APIManager.getProductInformation(identifier: identifier)
            .sink { response in
                self.isLoading = false
                if response.error == nil {
                    guard let response = response.value else { return }
                    if response.success {
                        self.productInformation = response.metadata
                    } else {
                        self.isError = true //  response with error
                    }
                } else {
                    switch response.error {
                    case .InternalError404:
                        self.isError = true
                    default:
                        self.isError = true
                    }
                }
            }
            .store(in: &anyCancelable)
    }
}
