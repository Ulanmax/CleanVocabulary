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
    
    private let meaning: MeaningModel
    
    struct Input {
        let trigger: Driver<Void>
    }
    struct Output {
        let fetching: Driver<Bool>
        let title: Driver<String>
        let error: Driver<Error>
    }
    
    private let useCase: VocabularyNetwork
    private let navigator: MeaningNavigator
    
    init(useCase: VocabularyNetwork, navigator: MeaningNavigator, meaning: MeaningModel) {
        self.useCase = useCase
        self.navigator = navigator
        self.meaning = meaning
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let title = Driver.just(self.meaning).startWith(self.meaning).map {$0.translation.text}
        
        return Output(fetching: fetching,
                      title: title,
                      error: errors)
    }
}
