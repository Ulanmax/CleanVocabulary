//
//  MeaningCell.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MeaningCell: UITableViewCell {
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    
    var disposeBagCell:DisposeBag = DisposeBag()
    
    var viewModel: MeaningCellModel?

    func update(with model: MeaningCellModel) {
        self.viewModel = model
        self.labelText.text = model.text
        self.labelNote.text = model.note
    }

    override func prepareForReuse() {
        disposeBagCell = DisposeBag()
    }
}
