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
}

class ProductInformationVM: ProductInformationVMProtocol {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private var anyCancelable = Set<AnyCancellable>()
    @Published private var productInformation: Product!
    internal var productInformationPublisher: Published<Product?>.Publisher {$productInformation}
    
    init(productIdentifier: String) {
        self.getProductWith(identifier: productIdentifier)
    }
    
    private func getProductWith(identifier: String) {
        APIManager.getProductInformation(identifier: identifier).sink { error in
            switch error {
                
            case .finished:
                break
            case .failure(let failure):
                print(failure)
            }
        } receiveValue: { result in
            self.productInformation = result.metadata
        }.store(in: &anyCancelable)
    }
    
}
