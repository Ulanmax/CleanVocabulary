//
//  MeaningViewController.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

class MeaningViewController: UIViewController {
    
    @IBOutlet weak var imageViewWord: UIImageView!
    @IBOutlet weak var labelWord: UILabel!
    @IBOutlet weak var labelTranslation: UILabel!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: MeaningViewModel!
    
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
        
        let input = MeaningViewModel.Input(
            trigger: viewWillAppear
        )
        let output = viewModel.transform(input: input)
        
        [
            output.word.drive(onNext: { [weak self] (value) in
                self?.labelWord.text = value
            }),
            output.translation.drive(onNext: { [weak self] (value) in
                self?.labelTranslation.text = value
            }),
            output.imageUrl.drive(onNext: { [weak self] (value) in
                guard let imageView = self?.imageViewWord, let url = value, let options = self?.makeImageLoadingOptions() else {return}
                Nuke.loadImage(with: url, options: options, into: imageView)
            }),
            output.error.drive(errorBinding)
        ]
        .forEach({$0.disposed(by: disposeBag)})
    }
    
    func makeImageLoadingOptions() -> ImageLoadingOptions {
        return ImageLoadingOptions(placeholder:UIImage(named: "photo"), transition: .fadeIn(duration: 0.25))
    }
}

