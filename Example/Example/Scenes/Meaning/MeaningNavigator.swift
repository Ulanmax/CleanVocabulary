//
//  MeaningNavigator.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift

class MeaningNavigator {
    
    let storyBoard: UIStoryboard
    let navigationController: UINavigationController
    let network: NetworkProvider
    
    init(network: NetworkProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.network = network
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    
    func toList() {
        self.navigationController.popViewController(animated: true)
    }
    
}
