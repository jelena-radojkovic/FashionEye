//
//  ButtonCommonCell.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 25.8.22..
//

import Foundation
import UIKit

struct ButtonCommonCellModel {
    let title: String
}

protocol NavigationDelegate {
    func navigateTo()
}

class ButtonCommonCell: UITableViewCell {
    static let identifier = "buttonCommonCell"
    var delegate: NavigationDelegate? = nil
    
    // ui
    var button: UIButton!
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        
        setInitialState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setInitialState() {
        let buttonAnchors = Anchors(height: 80, leading: 70, trailing: 70, top: 10)
        
        button = contentView.buttonWithAnchors(buttonAnchors)
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    func update(with model: ButtonCommonCellModel) {
        self.button.update(with: ThemeComponents.enabledButton(title: model.title))
    }
    
    @objc
    func buttonClicked() {
        delegate?.navigateTo()
    }
}
