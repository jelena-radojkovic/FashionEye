//
//  NavigationExtension.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 30.7.22..
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func showNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setNavigationBarColor(_ color: UIColor) {
        self.navigationController?.navigationBar.tintColor = color
    }
    
    func changeBackButtonAppearance(_ item: NavigationItemStateModel = .defaultBackItem) {
        self.navigationController?.navigationBar.backIndicatorImage = item.image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = item.image
        self.navigationController?.navigationBar.backItem?.title = item.text
    }
    
    func addCloseButton() {
        let closeBarItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(popViewController))
        self.navigationItem.rightBarButtonItem = closeBarItem
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func addRightBarButton(_ buttonItem: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    func enableRightBarButton() {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func disableRightBarButton() {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc
    func popViewController() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func popNavigationStack(to viewController: UIViewController.Type) {
        guard let navigationRoot = self.navigationController else { return }
        for controller in navigationRoot.viewControllers as Array
        {
            if controller.isKind(of: viewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
}
