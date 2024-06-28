//
//  SearchViewModel.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 17.8.22..
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

// MARK: - Models

struct SearchModel {
    
}

// MARK: - SearchViewModel

class SearchViewModel {
    lazy var currentState: BehaviorSubject<SearchModel> = BehaviorSubject(value: prepareInitialState())

}

// MARK: - Utils

extension SearchViewModel {
    private func prepareInitialState() -> SearchModel {
        return SearchModel()
    }
    
    func prepareTitleLabel() -> LabelStateModel {
        return LabelStateModel(text: "Search for your favourite clothes", textColor: .white, font: .m20)
    }
    
    func prepareHeaderCell() -> HeaderMainCellModel {
        return HeaderMainCellModel(button1: ThemeComponents.customEnabledButton(title: "History", color: .tertiaryBrandColor),
                                   button2: ThemeComponents.customEnabledButton(title: "Main", color: .tertiaryBrandColor),
                                   button3: ThemeComponents.customDisabledButton(title: "Search", color: .primaryBrandColor))
    }
    
    func prepareSearchCell() -> SearchCellModel {
        let titleLabel = LabelStateModel(text: "Search your favourite items🥰",
                                         textColor: .primaryTextColor, font: .m24,
                                         numberOfLines: 2, textAlignment: .center)
        return SearchCellModel(titleLabel: titleLabel,
                               textField: TextFieldStateModel(), button: ThemeComponents.enabledButton(title: "Search"))
    }
}
