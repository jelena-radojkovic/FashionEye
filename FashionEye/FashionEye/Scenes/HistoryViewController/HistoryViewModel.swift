//
//  HistoryViewModel.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 22.8.22..
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Models

struct HistoryModel {
    
}

// MARK: - HistoryViewModel

class HistoryViewModel {
    lazy var currentState: BehaviorSubject<HistoryModel> = BehaviorSubject(value: prepareInitialState())
    private let router = HistoryRouter()
    let visitedApparel = DBRealmManager.shared.fetchApparel()
    
}

// MARK: - Utils

extension HistoryViewModel {
    enum Constants {
        // fonts and other ui related stuff
    
    }
    
    private func prepareInitialState() -> HistoryModel {
        return HistoryModel()
    }
    
    func prepareTitleLabel() -> LabelStateModel {
        return LabelStateModel(text: "History", textColor: .primaryTextColor, font: .m20)
    }
    
    func prepareListCells() -> [ListPreviewCellModel] {
        return visitedApparel.map { ListPreviewCellModel(button: ThemeComponents.enabledButton(title: "Visit for more info"),
                                                         apparel: $0) }
    }
}
