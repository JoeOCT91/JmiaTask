//
//  SplashScreenVM.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 12/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import Foundation
import Combine

protocol SplashScreenVMProtocol: AnyObject {
    var isSuccessGettingConfigurationPublisher: Published<Bool>.Publisher { get }
}

class SplashScreenVM: SplashScreenVMProtocol{
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    
    private var anyCancelable  = Set<AnyCancellable>()
    @Published private var isSuccessGettingConfiguration: Bool = false
    internal var isSuccessGettingConfigurationPublisher: Published<Bool>.Publisher {$isSuccessGettingConfiguration}
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods
    //----------------------------------------------------------------------------------------------------------------
    
    init() {
        self.getConfiguration()
    }
    
    deinit {
        print(String(describing: self) + " has been deisnalized... ")
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  private methods
    //----------------------------------------------------------------------------------------------------------------
        
    private func getConfiguration() {
        APIManager.getConfiguration()
            .sink { response in
                if response.error == nil {
                    guard let configuration = response.value else { return }
                    if configuration.success {
                        let symbol = String(unicodeScalarLiteral: configuration.metadata.currency.currencySymbol)
                        self.saveConfiguration(currencySymbol: symbol)
                        self.isSuccessGettingConfiguration = true
                    } else { print("data received encorpted") }
                } else {
                    switch response.error {
                    case .InternalError404:
                        print("server internal error")
                    default:
                        break
                    }
                }
            }
            .store(in: &anyCancelable)
    }
    
    private func saveConfiguration(currencySymbol: String) {
        UserDefaultsManager.shared().currencySymbol = currencySymbol
    }
}
