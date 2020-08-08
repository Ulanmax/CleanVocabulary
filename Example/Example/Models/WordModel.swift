//
//  WordModel.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation

public class WordModel: Codable {
    
    public let id: Int
    public let text: String
    public let meanings: [MeaningModel]
    
    public init(
        id: Int,
        text: String,
        meanings: [MeaningModel]
        ) {
        self.id = id
        self.text = text
        self.meanings = meanings
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case meanings
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        text = try container.decode(String.self, forKey: .text)
        meanings = try container.decode([MeaningModel].self, forKey: .meanings)
    }
}
