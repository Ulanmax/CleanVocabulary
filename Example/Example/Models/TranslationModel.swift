//
//  TranslationModel.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation

public class TranslationModel: Codable {
    
    public let text: String
    public let note: String
    
    public init(
        text: String,
        note: String
        ) {
        self.text = text
        self.note = note
    }
    
    private enum CodingKeys: String, CodingKey {
        case text
        case note
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        text = try container.decode(String.self, forKey: .text)
        note = try container.decode(String.self, forKey: .note)
    }
}
