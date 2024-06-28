//
//  PhotoMainCell.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 14.8.22..
//

import Foundation
import UIKit

struct PhotoMainCellModel {
    let title: LabelStateModel
    let imageView: ImageViewStateModel
    let descriptionLabel: LabelStateModel?
    let backgroundColor: UIColor?
}

protocol ImagePickerDelegate {
    func imageTapped()
}

class PhotoMainCell: UITableViewCell {
    static let identifier = "photoMainCell"
    private var model: PhotoMainCellModel? = nil
    var delegate: ImagePickerDelegate? = nil
        
    // ui
    var infoLabel: UILabel!
    var image: UIImageView!
    var descriptionLabel: UILabel!
    var background: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        
        setInitialState()
        configureStyle()
        addImageTapRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: PhotoMainCellModel) {
        self.model = model
        self.infoLabel.update(with: model.title)
        self.image.update(with: model.imageView)
        if let labelModel = model.descriptionLabel {
            self.descriptionLabel.update(with: labelModel)
        }
        contentView.backgroundColor = model.backgroundColor ?? .primaryBrandColor
    }
    
    private func setInitialState() {
        let labelAnchors = Anchors(height: 100, leading: 70, trailing: 70, top: 50)
        let backgroundAnchors = Anchors(height: 650, leading: 0, trailing: 0, top: 0)
        let imageAnchors = Anchors(height: 300, leading: 70, trailing: 70, top: 180)
        let descriptionAnchors = Anchors(height: 60, leading: 70, trailing: 70, top: 500)
        
        background = contentView.viewWithAnchors(backgroundAnchors)
        contentView.addSubview(background)
        
        infoLabel = contentView.labelWithAnchors(labelAnchors)
        contentView.addSubview(infoLabel)
        
        image = contentView.imageWithAnchors(imageAnchors)
        image.backgroundColor = UIColor.tertiaryTextColor
        image.layer.cornerRadius = 20
        contentView.addSubview(image)
        
        descriptionLabel = contentView.labelWithAnchors(descriptionAnchors)
        contentView.addSubview(descriptionLabel)
    }
    
    private func configureStyle() {
        background.layer.cornerRadius = 70
        background.layer.maskedCorners = [.layerMaxXMinYCorner]
        background.clipsToBounds = true
        background.backgroundColor = .white
    }
    
    private func addImageTapRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        delegate?.imageTapped()
    }
}
