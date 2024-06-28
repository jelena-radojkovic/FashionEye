//
//  OnboardingViewController.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 14.8.22..
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import UIKitSwiftDSL
import Anchorage
import RxSwift
import RxCocoa

class OnboardingViewController: UIViewController {
    private let viewModel = OnboardingViewModel()
    private let disposeBag = DisposeBag()
    
    // ui elems
    var tableView: UITableView!
    
    override func loadView() {
        view = setInitalState()
        subscribeToViewModel()
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(OnboardingImageCell.self, forCellReuseIdentifier: OnboardingImageCell.identifier)
        tableView.register(OnboardingInfoCell.self, forCellReuseIdentifier: OnboardingInfoCell.identifier)
    }
}

// MARK: - Utils for presentation

extension OnboardingViewController {
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

extension OnboardingViewController {
    private func subscribeToViewModel() {
        viewModel.currentState.subscribe { model in
            // update methods
        } onError: { error in
            print("❌ OnboardingViewController: error in current state: \(error)! ❌")
        }
        .disposed(by: disposeBag)
    }
}

// MARK: - Routing

extension OnboardingViewController {
    
}


// MARK: - Delegates

extension OnboardingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.row) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingImageCell.identifier, for: indexPath) as! OnboardingImageCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingInfoCell.identifier, for: indexPath) as! OnboardingInfoCell
            cell.update(with: viewModel.prepareInfoCell())
            return cell
        default: return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.row) {
        case 0: return 350
        case 1: return 300
        default: return 0
        }
    }
}
