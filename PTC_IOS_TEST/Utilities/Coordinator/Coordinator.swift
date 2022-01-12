//
//  Coordinator.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/5/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators : [Coordinator] {get set}
    var navigationController : UINavigationController {get set}
    func start()
    func back()
}

