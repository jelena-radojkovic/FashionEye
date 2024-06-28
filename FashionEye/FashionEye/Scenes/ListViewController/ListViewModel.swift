//
//  ListViewModel.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 22.8.22..
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Models

struct ListModel {
    
}

// MARK: - ListViewModel

class ListViewModel {
    lazy var currentState: BehaviorSubject<ListModel> = BehaviorSubject(value: prepareInitialState())
    private let router = ListRouter()
    
}

// MARK: - Utils

extension ListViewModel {
    enum Constants {
        // fonts and other ui related stuff
    
    }
    
    
    func prepareTitleLabel() -> LabelStateModel {
        return LabelStateModel(text: "List preview", textColor: .primaryTextColor, font: .m20)
    }
    
    private func prepareInitialState() -> ListModel {
        return ListModel()
    }
    
    func prepareListCell(with apparel: Apparel) -> ListPreviewCellModel {
        return ListPreviewCellModel(button: ThemeComponents.enabledButton(title: "Visit for more info"),
                                    apparel: apparel)
    }
    
//    func prepareListCells() -> ListPreviewCellModel {
//        return ListPreviewCellModel(button: ThemeComponents.enabledButton(title: "Visit for more info"),
//                                     imageUrlPath: "https://static.bershka.net/4/photos2/2022/I/0/1/p/6300/187/700/4baaebcb9c64c04b9ad9de66e60f3b60-6300187700_2_3_0.jpg?imwidth=850&impolicy=bershka-itxmedium&imformat=generic",
//                                     purchaseUrlPath: "https://www.bershka.com/rs/en/creased-effect-crepe-long-sleeve-shirt-c0p119364279.html?colorId=700")
//    }
}
