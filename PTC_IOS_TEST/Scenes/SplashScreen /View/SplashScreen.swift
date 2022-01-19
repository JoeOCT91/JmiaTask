//
//  SplashScreen.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 12/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import Combine

class SplashScreenVC: UIViewController {
    
    private var subscription = Set<AnyCancellable>()
    private weak var coordinator: AppCoordinator?
    private var viewModel: SplashScreenVM!
    private var logoImageView = UIImageView()
    private var spinner = UIActivityIndicatorView(style: .large)

    override  func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorName.bgColor.color
        self.bindToSuccessBool()
        self.configureLogo()
        self.configureSpinner()
    }
    
    class func createSplashScreen(coordinator: AppCoordinator) -> SplashScreenVC {
        let splashScreen = SplashScreenVC()
        let viewModel = SplashScreenVM()
        splashScreen.coordinator = coordinator
        splashScreen.viewModel = viewModel
        return splashScreen
    }
    
    private func configureLogo() {
        self.view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: Measurements.screenWidth * 0.85),
            logoImageView.widthAnchor.constraint(equalToConstant: Measurements.screenWidth * 0.85),
            logoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        logoImageView.image = UIImage(asset: Asset.jumiaLogo)
        logoImageView.cornerRadius = 12
    }
    
    private func configureSpinner() {
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 18),
            spinner.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor),
        ])
        spinner.startAnimating()
    }
    
    func bindToSuccessBool() {
        viewModel.isSuccessGettingConfigurationPublisher
            .dropFirst()
            .sink { [weak self] value in
                guard let self = self else { return }
                switch value {
                case true:
                    self.spinner.stopAnimating()
                    self.coordinator?.presentHomeScreenAsWidowMainView()
                case false:
                    print("failed")
                }
            }
            .store(in: &subscription)
    }
}
