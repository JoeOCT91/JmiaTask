//
//  HomeVC.swift
//  PTC_IOS_TEST
//
//  Created by Yousef Mohamed on 13/01/2022.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit
import CombineCocoa

class HomeVC: UIViewController {
    
    private weak var coordinator: HomeCoordinator?
    private var homeView: HomeView!
    
    override func loadView() {
        let homeView = HomeView()
        self.homeView = homeView
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        tabBarController?.tabBar.isHidden = false
    }
    
    class func createHomeVC(coordinator: HomeCoordinator) -> HomeVC {
        let homeVC = HomeVC()
        homeVC.title = L10n.homeVC
        homeVC.coordinator = coordinator
        return homeVC
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        //searchController.searchBar.searchTextField.backgroundColor = ColorName.whiteColor.color
        searchController.searchBar.inputView?.backgroundColor = .white
        searchController.searchBar.layer.borderColor = UIColor.blue.cgColor
        //searchController.searchBar.placeholder = L10n.workOrdersSearchBarPlaceHolder
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.delegate = self
    }
}

extension HomeVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard var searchFor = searchBar.text else { return }
        searchFor = searchFor.lowercased()
        print(searchFor)
        self.coordinator?.pushResultVC(searchFor: searchFor)
    }
}
