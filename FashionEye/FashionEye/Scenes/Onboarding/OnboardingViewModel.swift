//
//  OnboardingViewModel.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 14.8.22..
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Models

struct OnboardingModel {
    
}

// MARK: - OnboardingViewModel

class OnboardingViewModel {
    lazy var currentState: BehaviorSubject<OnboardingModel> = BehaviorSubject(value: prepareInitialState())
    private let router = OnboardingRouter()
    
    
    func goToMainPage() {
        router.goToMainPage()
    }
}

// MARK: - Utils

extension OnboardingViewModel {
    private func prepareInitialState() -> OnboardingModel {
        return OnboardingModel()
    }
    
    func prepareInfoCell() -> OnboardingInfoCellModel {
        let text =
        """
        Let's research some
        fashion combos :)
        """
        let infoLabel = LabelStateModel(text: text,
                                        textColor: .white, font: .m24, numberOfLines: 2, textAlignment: .center)
        return OnboardingInfoCellModel(infoLabel: infoLabel,
                                       button: ThemeComponents.enabledButton(title: "Let's start!"),
                                       action: goToMainPage)
    }
}
