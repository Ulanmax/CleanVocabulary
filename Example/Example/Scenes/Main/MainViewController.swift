//
//  MainViewController.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var viewModel: MainViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeNavigationBarTransparent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.makeNavigationBarNonTransparent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindViewModel()
    }
    
    private func configureUI() {
    }
    
    private func bindViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
        .mapToVoid()
        .asDriverOnErrorJustComplete()
        
        let input = MainViewModel.Input(
            trigger: viewWillAppear
        )
        let output = viewModel.transform(input: input)
        
        [
            output.error.drive(errorBinding),
            output.fetching.drive(fetchingBinding),
        ]
        .forEach({$0.disposed(by: disposeBag)})
        
    }
}
