//
//  RoutingService.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 30.7.22..
//

import Foundation
import UIKit

class RoutingService {
    private init() {}
    static let shared = RoutingService()
    
    // Setting initial root view controller in navigation stack.
    func setInitialNavigationRoot(_ window: UIWindow) {
        var rootViewController: UINavigationController?
        rootViewController = MainNavigationViewController()
        setInitialViewController(rootViewController)
        window.rootViewController = rootViewController
    }
    
    // Setting view controllers in root navigation view controller.
    // This function can be used to set any available view controller
    // as entry point in the app.
    private func setInitialViewController(_ rootViewController: UINavigationController?) {
        rootViewController?.setViewControllers([getStartingDestination()], animated: false)
    }
    
    private func getStartingDestination() -> UIViewController {
        return OnboardingViewController()
    }
    
    var currentNavigationStackRoot: UINavigationController? {
        return UIApplication.shared.windows.first?.rootViewController as? UINavigationController
    }
    
    var viewControllerOnNavigatioStackTop: UIViewController? {
        return currentNavigationStackRoot?.visibleViewController
    }
}

class MainNavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = .white
        self.navigationBar.tintColor = UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }
}
