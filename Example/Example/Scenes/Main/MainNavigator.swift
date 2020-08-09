//
//  MainNavigator.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift

class MainNavigator {
    
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
    
    func toMain() {
        let vc = storyBoard.instantiateViewController(ofType: MainViewController.self)
        vc.viewModel = MainViewModel(useCase: network.makeVocabularyNetwork(),
                                        navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }

    func toMeaningDetails(_ meaning: MeaningModel) {
//        let viewModel = MeaningDetailsViewModel(useCase: services.make(), navigator: self, meaning: meaning)
//        let vc = storyBoard.instantiateViewController(ofType: MeaningDetailsViewController.self)
//        vc.viewModel = viewModel
//        navigationController.pushViewController(vc, animated: true)
    }
    
}

