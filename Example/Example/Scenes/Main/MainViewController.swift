//
//  MainViewController.swift
//  Example
//
//  Created by Maks Niagolov on 2020/08/09.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    private func configureUI() {
        
        tableView.register(UINib(nibName: "MeaningCell", bundle: nil), forCellReuseIdentifier: "MeaningCell")
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
        
    private func bindViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        let viewDidAppear = rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
        .mapToVoid()
        .asDriverOnErrorJustComplete()
        
        let searchTrigger = searchBar.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
        
        let input = MainViewModel.Input(
            trigger: viewDidAppear,
            searchTrigger: searchTrigger,
            selection: tableView.rx.itemSelected.asDriver()
        )
        let output = viewModel.transform(input: input)
        
        [
            output.meanings.drive(tableView.rx.items(cellIdentifier: "MeaningCell", cellType: MeaningCell.self)) { tv, viewModel, cell in
                cell.update(with: viewModel)
            },
            output.error.drive(errorBinding),
            output.selectedMeaning.drive()
        ]
        .forEach({$0.disposed(by: disposeBag)})
        
    }
        
    var favContentBinding: Binder<String> {
        return Binder(self, binding: { (vc, title) in
            print(title)
        })
    }
}
