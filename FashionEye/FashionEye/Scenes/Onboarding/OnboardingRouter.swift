//
//  OnboardingRouter.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 14.8.22..
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class OnboardingRouter {
    
    func goToMainPage() {
        RoutingService.shared.currentNavigationStackRoot?.pushViewController(MainViewController(), animated: true)
    }
}
