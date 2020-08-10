//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import Example

class ExampleTests: XCTestCase {
    
    var viewModel : MainViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    fileprivate var service : MockVocabularyNetwork!
    fileprivate var navigator : MockMainNavigator!

    override func setUp() {
        super.setUp()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        self.service = MockVocabularyNetwork()
        self.navigator = MockMainNavigator()
        self.viewModel = MainViewModel(useCase: self.service, navigator: self.navigator)
    }

    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        self.navigator = nil
        super.tearDown()
    }

    func testFetchWords() {

        let words = scheduler.createObserver([MeaningCellModel].self)

        let wordModel = WordModel(id: 1,
                                  text: "dog",
                                  meanings: [
                                    MeaningModel(
                                        id: 1,
                                        partOfSpeechCode: "n",
                                        translation: TranslationModel(text: "собака", note: "some text"),
                                        previewUrl: "",
                                        imageUrl: URL(fileURLWithPath: "https://d2zkmv5t5kao9.cloudfront.net/images/75e65bc6fe93fe21d1296f6c54e802a2.jpeg?w=640&h=480")
                                    )
            ]
        )
        
        service.wordModel = wordModel
        
        let trigger = scheduler.createHotObservable([Recorded.next(10, ())]).asDriverOnErrorJustComplete()
        let searchTrigger = scheduler.createHotObservable([Recorded.next(10, String())]).asDriverOnErrorJustComplete()
        
        let input = MainViewModel.Input(trigger: trigger, searchTrigger: searchTrigger, selection: .empty())
        
        let output = viewModel.transform(input: input)

        // bind the result
        output.meanings
            .drive(words)
            .disposed(by: disposeBag)

        scheduler.start()
        
        let result = [MeaningCellModel(with: wordModel.meanings.first!, word: wordModel.text)]

        XCTAssertEqual(words.events, [.next(10, result)])
    }
}

fileprivate class MockVocabularyNetwork: VocabularyNetworkProtocol {
    
    var wordModel : WordModel?
    
    func searchWords(search: String, page: Int, pageSize: Int) -> Observable<[WordModel]> {
        return Observable.just([wordModel!])
    }
}

fileprivate class MockMainNavigator: MainNavigatorProtocol {
    func toMain() {
        
    }
    
    func toMeaningDetails(_ word: String, meaning: MeaningModel) {
        
    }
}

