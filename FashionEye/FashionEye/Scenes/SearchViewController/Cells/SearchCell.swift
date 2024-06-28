//
//  SearchCell.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 17.8.22..
//

import Foundation
import UIKit

struct SearchCellModel {
    let titleLabel: LabelStateModel
    let textField: TextFieldStateModel
    let button: ButtonStateModel
}

class SearchCell: UITableViewCell {
    static let identifier = "searchCell"
    private var model: SearchCellModel? = nil
    var pickerData: [[String]] = [[String]]()
    private var selectedItem: String? = nil
    private var selectedStore: String? = nil
    
    // ui
    var titleLabel: UILabel!
    var pickerView: UIPickerView!
    var searchButton: UIButton!
    var background: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        
        setInitialState()
        configurePicker()
        configureStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerData = [["pants", "jacket", "bag", "shoes", "dress", "skirt", "shirt", "t-shirt"],
                      ["Bershka", "Zara", "Terranova"]]
        selectedItem = pickerData[0][0]
        selectedStore = pickerData[1][0]
        pickerView.layer.cornerRadius = 50
    }
    
    func update(with model: SearchCellModel) {
        self.model = model
        self.titleLabel.update(with: model.titleLabel)
        self.searchButton.update(with: model.button)
    }
    
    private func setInitialState() {
        let labelAnchors = Anchors(height: 100, leading: 70, trailing: 70, top: 50)
        let backgroundAnchors = Anchors(height: 650, leading: 0, trailing: 0, top: 0)
        let pickerAnchors = Anchors(height: 170, leading: 30, trailing: 30, top: 150)
        let buttonAnchors = Anchors(width: 120, height: 75, top: 350, centeredX: true)
        
        background = contentView.viewWithAnchors(backgroundAnchors)
        contentView.addSubview(background)
        
        titleLabel = contentView.labelWithAnchors(labelAnchors)
        contentView.addSubview(titleLabel)
        
        searchButton = contentView.buttonWithAnchors(buttonAnchors)
        contentView.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(onSearchClicked), for: .touchUpInside)
        
        pickerView = contentView.pickerWithAnchors(pickerAnchors)
        contentView.addSubview(pickerView)
    }
    
    private func configureStyle() {
        contentView.backgroundColor = .primaryBrandColor
        background.layer.cornerRadius = 70
        background.layer.maskedCorners = [.layerMaxXMinYCorner]
        background.clipsToBounds = true
        background.backgroundColor = .white
    }
    
    @objc
    func onSearchClicked() {
        if let selectedItem = selectedItem, let selectedStore = selectedStore {
            NetworkManager.shared.getItems(item: selectedItem, from: selectedStore, completion: { result in
                let vc = ListViewController()
                vc.clothingToBePresented = [result]
                vc.headlines = ["\(selectedItem.capitalizingFirstLetter()) from \(selectedStore)"]
                RoutingService.shared.currentNavigationStackRoot?.pushViewController(vc, animated: true)
            })
        }
    }
}

extension SearchCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(component) {
        case 0: return pickerData[0][row]
        case 1: return pickerData[1][row]
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component) {
        case 0: return 8
        case 1: return 3
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(component) {
        case 0: selectedItem = pickerData[0][row]
        case 1: selectedStore = pickerData[1][row]
        default: return
        }
    }
}
