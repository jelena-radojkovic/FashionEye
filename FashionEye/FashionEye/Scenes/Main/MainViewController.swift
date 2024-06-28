//
//  TestViewController.swift
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
import AlamofireImage
import Alamofire

class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    private let imagePicker = UIImagePickerController()
    private var chosenImage: UIImage = UIImage(named: "searchIcon")!
    
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
        tableView.register(PhotoMainCell.self, forCellReuseIdentifier: PhotoMainCell.identifier)
        tableView.register(ButtonCommonCell.self, forCellReuseIdentifier: ButtonCommonCell.identifier)
    }
}

// MARK: - Utils for presentation

extension MainViewController {
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

extension MainViewController {
    private func subscribeToViewModel() {
        viewModel.currentState.subscribe { model in
            // update methods
        } onError: { error in
            print("❌ TestViewController: error in current state: \(error)! ❌")
        }
        .disposed(by: disposeBag)
    }
}

// MARK: - Delegates

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + (viewModel.isLoaded ? 2 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.row) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderMainCell.identifier, for: indexPath) as! HeaderMainCell
            cell.update(with: viewModel.prepareHeaderCell())
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoMainCell.identifier, for: indexPath) as! PhotoMainCell
            cell.delegate = self
            cell.update(with: viewModel.preparePhotoMainCell(image: chosenImage))
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoMainCell.identifier, for: indexPath) as! PhotoMainCell
            cell.update(with: viewModel.prepareLoadedPhoto())
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCommonCell.identifier, for: indexPath) as! ButtonCommonCell
            cell.delegate = self
            cell.update(with: viewModel.prepareButtonCell())
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.row) {
        case 0: return 200
        case 1,2: return ResizingManager.shared.height - 200
        case 3: return 120
        default: return 0
        }
    }
}

// MARK: - Image picker

extension MainViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate, ImagePickerDelegate, NavigationDelegate {
    func navigateTo() {
        viewModel.navigateToListScreen()
    }
    
    func imageTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.chosenImage = pickedImage
            let imgData = pickedImage.jpegData(compressionQuality: 0.1)!
            viewModel.uploadPhotoToServer(imgData) {
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: 2, section: 0), at: .top, animated: true)
            }
            dismiss(animated: true, completion:nil)
            tableView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
}
