//
//  VocabularyNetwork.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import RxSwift

public final class VocabularyNetwork {
    private let network: Network<WordModel>

    private let path = "weather"

    init(network: Network<WordModel>) {
        self.network = network
    }

    public func searchWords(search: String, page: Int, pageSize: Int) -> Observable<[WordModel]> {
        let params = ["search": search, "page": page, "pageSize": pageSize] as [String : Any]
        return network.getItems(path, params: params).map({ (result) -> [WordModel] in
            return result
        })
    }
}
