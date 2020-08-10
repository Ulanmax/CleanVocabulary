//
//  MainViewModel.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: ViewModelType {
    
    struct Input {
        let trigger: Driver<Void>
        let searchTrigger: Driver<String>
        let selection: Driver<IndexPath>
    }
    struct Output {
        let fetching: Driver<Bool>
        let meanings: Driver<[MeaningCellModel]>
        let selectedMeaning: Driver<Void>
        let error: Driver<Error>
    }
    
    private let useCase: VocabularyNetworkProtocol
    private let navigator: MainNavigatorProtocol
    
    init(useCase: VocabularyNetworkProtocol, navigator: MainNavigatorProtocol) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let meanings = input.searchTrigger.withLatestFrom(input.trigger) { value, _ in return value }
            .flatMapLatest { value -> SharedSequence<DriverSharingStrategy, [WordModel]> in
            // I haven't added pagination here
                return self.useCase.searchWords(search: value, page: 1, pageSize: 1)
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                }.map { words -> [MeaningCellModel] in
                    guard let wordModel = words.first else { return [] }
                    return wordModel.meanings.map { MeaningCellModel(with: $0, word: wordModel.text) }
                }
        
        let selectedMeaning = input.selection.withLatestFrom(meanings) { (indexPath, meanings) -> MeaningCellModel in
                return meanings[indexPath.row]
            }
        .do(onNext:
            { [weak self] (cellModel) in
                if let meaning = cellModel.meaning, let word = cellModel.word {
                    self?.navigator.toMeaningDetails(word, meaning: meaning)
                }
            }
        ).mapToVoid()
        
        return Output(fetching: fetching,
                      meanings: meanings,
                      selectedMeaning: selectedMeaning,
                      error: errors)
    }
}
