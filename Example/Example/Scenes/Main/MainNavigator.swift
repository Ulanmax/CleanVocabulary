//
//  MainNavigator.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift

protocol MainNavigatorProtocol {
    func toMain()
    func toMeaningDetails(_ word: String, meaning: MeaningModel)
}

class MainNavigator: MainNavigatorProtocol {
    
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

    func toMeaningDetails(_ word: String, meaning: MeaningModel) {
        let storyboard = UIStoryboard(name: "Meaning", bundle: nil)
        let navigator = MeaningNavigator(network: network, navigationController: navigationController, storyBoard: storyboard)
        let vc = storyboard.instantiateViewController(ofType: MeaningViewController.self)
        let viewModel = MeaningViewModel(useCase: network.makeVocabularyNetwork(), navigator: navigator, word: word, meaning: meaning)
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
}

