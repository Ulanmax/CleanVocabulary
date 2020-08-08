//
//  MeaningModel.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation

public class MeaningModel: Codable {
    
    public let id: Int
    public let partOfSpeechCode: String
    public let translation: TranslationModel
    public let previewUrl: String
    public let imageUrl: String
    
    public init(
        id: Int,
        partOfSpeechCode: String,
        translation: TranslationModel,
        previewUrl: String,
        imageUrl: String
        ) {
        self.id = id
        self.partOfSpeechCode = partOfSpeechCode
        self.translation = translation
        self.previewUrl = previewUrl
        self.imageUrl = imageUrl
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case partOfSpeechCode
        case translation
        case previewUrl
        case imageUrl
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        partOfSpeechCode = try container.decode(String.self, forKey: .partOfSpeechCode)
        translation = try container.decode(TranslationModel.self, forKey: .translation)
        previewUrl = try container.decode(String.self, forKey: .previewUrl)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
    }
}
