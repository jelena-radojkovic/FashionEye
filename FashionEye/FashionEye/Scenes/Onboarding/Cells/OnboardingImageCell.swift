//
//  OnboardingImageCell.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 14.8.22..
//

import Foundation
import UIKit
import UIKitSwiftDSL
import Anchorage

class OnboardingImageCell: UITableViewCell {
    static let identifier = "onboardingCell"
    
    var image: UIImageView!
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
        let imageAnchors = Anchors(height: 90, leading: 60, trailing: 60, top: 120)
        let backgroundAnchors = Anchors(height: 350, leading: 0, trailing: 0, top: 0)
        
        background = contentView.viewWithAnchors(backgroundAnchors)
        contentView.addSubview(background)
        
        image = contentView.imageWithAnchors(imageAnchors)
        contentView.addSubview(image)
    }
    
    
    private func createOnboardingImage() -> ImageViewStateModel {
        return ImageViewStateModel(image: UIImage(named: "woman"), contentMode: .scaleAspectFill, sizeToFit: true)
    }
    
    private func configureStyle() {
        contentView.backgroundColor = .primaryBrandColor
        background.layer.cornerRadius = 70
        background.layer.maskedCorners = [.layerMaxXMaxYCorner]
        background.clipsToBounds = true
        background.backgroundColor = .white
        
        image.update(with: createOnboardingImage())
    }
}
