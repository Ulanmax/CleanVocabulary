//
//  NetworkProvider.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "https://dictionary.skyeng.ru/api/public/v1"
    }
    
    public func makeVocabularyNetwork() -> VocabularyNetwork {
        let network = Network<WordModel>(apiEndpoint)
        return VocabularyNetwork(network: network)
    }
}
