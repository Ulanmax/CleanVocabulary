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
    
    var meaning: MeaningModel?
    
    init(with meaning: MeaningModel) {
        self.update(with: meaning)
    }
    
    func update(with meaning: MeaningModel) {
        self.meaning = meaning
        self.text = meaning.translation.text
        self.note = meaning.translation.note ?? "˜˜"
    }
    
    
}
