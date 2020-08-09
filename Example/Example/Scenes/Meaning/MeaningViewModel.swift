//
//  MeaningViewModel.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MeaningViewModel: ViewModelType {
    
    private let word: String
    private let meaning: MeaningModel
    
    struct Input {
        let trigger: Driver<Void>
    }
    struct Output {
        let fetching: Driver<Bool>
        let word: Driver<String>
        let translation: Driver<String>
        let imageUrl: Driver<URL?>
        let error: Driver<Error>
    }
    
    private let useCase: VocabularyNetwork
    private let navigator: MeaningNavigator
    
    init(useCase: VocabularyNetwork, navigator: MeaningNavigator, word: String, meaning: MeaningModel) {
        self.useCase = useCase
        self.navigator = navigator
        self.word = word
        self.meaning = meaning
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let word = Driver.just(self.word).startWith(self.word)
        
        let translation = Driver.just(self.meaning).startWith(self.meaning).map {$0.translation.text}
        
        let imageUrl = Driver.just(self.meaning).startWith(self.meaning).map {
            $0.imageUrl
        }
        
        return Output(fetching: fetching,
                      word: word,
                      translation: translation,
                      imageUrl: imageUrl,
                      error: errors)
    }
}
