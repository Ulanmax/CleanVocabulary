//
//  MeaningCellModel.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation
import UIKit

class MeaningCellModel {
    
    var text: String = ""
    
    var note: String = ""
    
    var word: String?
    
    weak var meaning: MeaningModel?
    
    init(with meaning: MeaningModel, word: String) {
        self.update(with: meaning, word: word)
    }
    
    func update(with meaning: MeaningModel, word: String) {
        self.word = word
        self.meaning = meaning
        self.text = meaning.translation.text
        self.note = meaning.translation.note ?? "˜˜"
    }
    
    
}
