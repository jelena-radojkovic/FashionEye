//
//  OnboardingInfoCell.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 14.8.22..
//

import Foundation
import UIKit

struct OnboardingInfoCellModel {
    let infoLabel: LabelStateModel
    let button: ButtonStateModel
    let action: (() -> Void)?
}

class OnboardingInfoCell: UITableViewCell {
    static let identifier = "onboardingInfoCell"
    private var model: OnboardingInfoCellModel? = nil
        
    // ui
    var infoLabel: UILabel!
    var button: UIButton!
    
    
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
        let labelAnchors = Anchors(height: 100, leading: 70, trailing: 70, top: 70)
        let buttonAnchors = Anchors(width: 120, height: 75, top: 220, centeredX: true)
        let backgroundAnchors = Anchors(height: 350, leading: 0, trailing: 0, top: 0)
        
        background = contentView.viewWithAnchors(backgroundAnchors)
        contentView.addSubview(background)
        
        infoLabel = contentView.labelWithAnchors(labelAnchors)
        contentView.addSubview(infoLabel)
        
        button = contentView.buttonWithAnchors(buttonAnchors)
        contentView.addSubview(button)
        
        button.addTarget(self, action: #selector(onClicked), for: .touchUpInside)
    }
    
    private func configureStyle() {
        contentView.backgroundColor = .white
        background.layer.cornerRadius = 70
        background.layer.maskedCorners = [.layerMinXMinYCorner]
        background.clipsToBounds = true
        background.backgroundColor = .primaryBrandColor
    }
    
    func update(with model: OnboardingInfoCellModel) {
        self.model = model
        self.infoLabel.update(with: model.infoLabel)
        self.button.update(with: model.button)
    }
    
    @objc
    func onClicked() {
        guard let model = model, let action = model.action else {
            return
        }
       action()
    }
    
}
