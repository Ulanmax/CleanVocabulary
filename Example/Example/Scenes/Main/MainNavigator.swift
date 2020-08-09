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
        let storyboard = UIStoryboard(name: "Meaning", bundle: nil)
        let navigator = MeaningNavigator(network: network, navigationController: navigationController, storyBoard: storyboard)
        let vc = storyboard.instantiateViewController(ofType: MeaningViewController.self)
        let viewModel = MeaningViewModel(useCase: network.makeVocabularyNetwork(), navigator: navigator, meaning: meaning)
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
}

