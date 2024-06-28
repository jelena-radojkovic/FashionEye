//
//  HeaderMainCell.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 14.8.22..
//

import Foundation
import UIKit

struct HeaderMainCellModel {
    let button1: ButtonStateModel
    let button2: ButtonStateModel
    let button3: ButtonStateModel
}

class HeaderMainCell: UITableViewCell {
    static let identifier = "headerMainCell"
    private var model: HeaderMainCellModel? = nil
        
    // ui
    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    var buttonsView: UIView!
    var stackView: UIStackView!
    var background: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        
        setInitialState()
        configureStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setInitialState() {
        let stackAnchors = Anchors(height: 60, leading: 70, trailing: 70, top: 50)
        let buttonsViewAnchors = Anchors(height: 80, leading: 60, trailing: 50, top: 40)
        let backgroundAnchors = Anchors(height: 200, leading: 0, trailing: 0, top: 0)
        
        background = contentView.viewWithAnchors(backgroundAnchors)
        contentView.addSubview(background)
        
        buttonsView = contentView.viewWithAnchors(buttonsViewAnchors)
        contentView.addSubview(buttonsView)
        button1 = UIButton()
        button2 = UIButton()
        button3 = UIButton()
        stackView = contentView.hStack(distribution: .fillEqually, stackAnchors) {
            
            $0.spacing = 15
            $0.addArrangedSubview(button1)
            $0.addArrangedSubview(button2)
            $0.addArrangedSubview(button3)
        }
        stackView.backgroundColor = .tertiaryBrandColor
        stackView.layer.cornerRadius = 20
        contentView.addSubview(stackView)
        
        button1.addTarget(self, action: #selector(button1Clicked), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Clicked), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3Clicked), for: .touchUpInside)
    }
    
    private func configureStyle() {
        contentView.backgroundColor = .white
        buttonsView.backgroundColor = .tertiaryBrandColor
        buttonsView.layer.cornerRadius = 20
        background.layer.cornerRadius = 70
        background.layer.maskedCorners = [.layerMinXMaxYCorner]
        background.clipsToBounds = true
        background.backgroundColor = .primaryBrandColor
    }
    
    func update(with model: HeaderMainCellModel) {
        self.model = model
        self.button1.update(with: model.button1)
        self.button2.update(with: model.button2)
        self.button3.update(with: model.button3)
    }
    
    @objc
    func button1Clicked() {
        RoutingService.shared.currentNavigationStackRoot?.pushViewController(HistoryViewController(), animated: false)
    }
    
    @objc
    func button2Clicked() {
        RoutingService.shared.currentNavigationStackRoot?.pushViewController(MainViewController(), animated: false)
    }
    
    @objc
    func button3Clicked() {
        RoutingService.shared.currentNavigationStackRoot?.pushViewController(SearchViewController(), animated: false)
    }
}
