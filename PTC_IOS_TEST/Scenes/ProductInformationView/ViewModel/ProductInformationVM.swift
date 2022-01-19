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

}

class ProductInformationVM: ProductInformationVMProtocol {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private var anyCancelable = Set<AnyCancellable>()
    @Published private var productInformation: Product!
    internal var productInformationPublisher: Published<Product?>.Publisher {$productInformation}
    @Published private var isError: Bool = false
    internal var errorOccurredWhileGettingDataPublisher : Published<Bool>.Publisher {$isError}

    
    init(productIdentifier: String) {
        self.getProductWith(identifier: productIdentifier)
    }
    
    private func getProductWith(identifier: String) {
        APIManager.getProductInformation(identifier: identifier)
            .sink { response in
                if response.error == nil {
                    guard let productInformation = response.value?.metadata else { return }
                    self.productInformation = productInformation
                } else {
                    switch response.error {
                    case .InternalError404:
                        self.isError = true
                        print("error")
                    default:
                        self.isError = true
                    }
                }
            }
            .store(in: &anyCancelable)
    }
}
