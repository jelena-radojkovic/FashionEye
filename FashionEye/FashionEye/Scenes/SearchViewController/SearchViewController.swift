//
//  SearchViewController.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 17.8.22..
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import UIKitSwiftDSL
import Anchorage
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    
    var tableView: UITableView!
    
    override func loadView() {
        view = setInitalState()
        subscribeToViewModel()
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.separatorStyle = .none
        registerCells()
        customizeTitleView()
    }
    
    
    func customizeTitleView() {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.backgroundColor = .primaryBrandColor
        
        let titleLabel = UILabel()
        titleLabel.update(with: viewModel.prepareTitleLabel())
        navigationItem.titleView = titleLabel
    }
    
    private func registerCells() {
        tableView.register(HeaderMainCell.self, forCellReuseIdentifier: HeaderMainCell.identifier)
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
    }
}

// MARK: - Utils for presentation

extension SearchViewController {
    enum Constants {
        static let tableAnchors = Anchors(leading: 0, trailing: 0, top: 0, bottom: 0)
    }
    
    private func setInitalState() -> UIView {
        return UIKitSwiftDSL.view { mainView in
            mainView.backgroundColor = .white
            tableView = mainView.tableViewWithAnchors(Constants.tableAnchors)
        }
    }
}

// MARK: - ViewModel subscriptions

extension SearchViewController {
    private func subscribeToViewModel() {
        viewModel.currentState.subscribe { model in
            // update methods
            
        } onError: { error in
            print("❌ SearchViewController: error in current state: \(error)! ❌")
        }
        .disposed(by: disposeBag)
    }
}



// MARK: - Delegates

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.row) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderMainCell.identifier, for: indexPath) as! HeaderMainCell
            cell.update(with: viewModel.prepareHeaderCell())
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
            cell.update(with: viewModel.prepareSearchCell())
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.row) {
        case 0: return 200
        case 1: return ResizingManager.shared.height - 300
        default: return 0
        }
    }
}


// MARK: - Routing

extension SearchViewController {
    
}
