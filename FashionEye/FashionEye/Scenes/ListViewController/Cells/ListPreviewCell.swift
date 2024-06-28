//
//  ListPreviewCell.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 22.8.22..
//

import Foundation
import UIKit
import AlamofireImage

struct ListPreviewCellModel {
    let button: ButtonStateModel
    let apparel: Apparel
}

class ListPreviewCell: UITableViewCell {
    static let identifier = "listPreviewCellModel"
    private var model: ListPreviewCellModel? = nil
        
    // ui
    var image: UIImageView!
    var button: UIButton!
    var label: UILabel!
    
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
        let imageAnchors = Anchors(width: 100, height: 200, leading: 40, top: 50)
        let buttonAnchors = Anchors(width: 150, height: 60, trailing: 40, top: 100)
        let labelAnchors = Anchors(width: 150, height: 50, trailing: 40, top: 170)
        
        image = contentView.imageWithAnchors(imageAnchors)
        contentView.addSubview(image)
        
        button = contentView.buttonWithAnchors(buttonAnchors)
        contentView.addSubview(button)
        
        button.addTarget(self, action: #selector(onClicked), for: .touchUpInside)
        
        label = contentView.labelWithAnchors(labelAnchors)
        contentView.addSubview(label)
    }
    
    func update(with model: ListPreviewCellModel) {
        self.model = model
        self.image.af.setImage(withURL: URL(string: model.apparel.imagePath)!)
        self.image.contentMode = .scaleAspectFit
        self.button.update(with: model.button)
        self.label.update(with: getLabelModel(model: model))
    }
    
    private func getLabelModel(model: ListPreviewCellModel) -> LabelStateModel {
        let item = model.apparel.typeClass.capitalizingFirstLetter()
        let store = model.apparel.store.capitalizingFirstLetter()
        return LabelStateModel(text: "\(item) from \(store)",
                               textColor: .primaryTextColor, font: .m16)
    }
    
    
    @objc
    func onClicked() {
        guard let model = model else { return }
        let vc = WebPreiewViewController()
        vc.urlString = model.apparel.purchasePath
        DBRealmManager.shared.saveApparel(model.apparel)
        RoutingService.shared.currentNavigationStackRoot?.pushViewController(vc, animated: true)
   }
}
