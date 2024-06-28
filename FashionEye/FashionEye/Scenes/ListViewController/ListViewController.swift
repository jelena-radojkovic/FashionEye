//
//  ListViewController.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 22.8.22..
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import UIKitSwiftDSL
import Anchorage
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    private let viewModel = ListViewModel()
    private let disposeBag = DisposeBag()
    var headlines: [String] = [""]
    var clothingToBePresented: [Clothing]? = nil
    var tableView: UITableView!
    
    override func loadView() {
        view = setInitalState()
        subscribeToViewModel()
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
        customizeTitleView()
    }
    
    func customizeTitleView() {
        self.navigationItem.hidesBackButton = false
        self.navigationController?.navigationBar.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.update(with: viewModel.prepareTitleLabel())
        navigationItem.titleView = titleLabel
    }
    
    private func registerCells() {
        tableView.register(ListPreviewCell.self, forCellReuseIdentifier: ListPreviewCell.identifier)
    }
}

// MARK: - Utils for presentation

extension ListViewController {
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

extension ListViewController {
    private func subscribeToViewModel() {
        viewModel.currentState.subscribe { model in
            // update methods
            
        } onError: { error in
            print("❌ ListViewController: error in current state: \(error)! ❌")
        }
        .disposed(by: disposeBag)
    }
}

// MARK: - Routing

extension ListViewController {
    
}

// MARK: - Delegates

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothingToBePresented?[section].count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListPreviewCell.identifier, for: indexPath) as! ListPreviewCell
        if let clothing = clothingToBePresented {
            cell.update(with: viewModel.prepareListCell(with: clothing[indexPath.section][indexPath.row]))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.update(with: LabelStateModel(text: self.headlines[section], textColor: .primaryTextColor, font: .m20, backgroundColor: .systemGray6 ,textAlignment: .center))
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
