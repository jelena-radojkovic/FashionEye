//
//  Anchors.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 30.7.22..
//

import Foundation
import UIKit

struct DefaultAnchors {
    static let leading: CGFloat = 30.0
    static let trailing: CGFloat = 30.0
}

// MARK: - Anchors
struct Anchors {
    let width: CGFloat?
    let height: CGFloat?
    let leading: CGFloat?
    let trailing: CGFloat?
    let top: CGFloat?
    let bottom: CGFloat?
    let centeredX: Bool
    let centeredY: Bool
    
    init(width: CGFloat? = nil,
         height: CGFloat? = nil,
         leading: CGFloat? = nil,
         trailing: CGFloat? = nil,
         top: CGFloat? = nil,
         bottom: CGFloat? = nil,
         centeredX: Bool = false,
         centeredY: Bool = false) {
        self.width = width
        self.height = height
        self.leading = leading
        self.trailing = trailing
        self.top = top
        self.bottom = bottom
        self.centeredX = centeredX
        self.centeredY = centeredY
    }
    
    enum AnchorsError: Error {
        case invalid
    }
    
    func validate() throws {
        guard (leading != nil && trailing != nil && top != nil && bottom != nil)
                || (leading != nil && top != nil && width != nil && height != nil)
                || (leading != nil && bottom != nil && width != nil && height != nil)
                || (trailing != nil && top != nil && width != nil && height != nil)
                || (leading != nil && trailing != nil && top != nil && height != nil)
                || (leading != nil && trailing != nil && bottom != nil && height != nil)
                || (trailing != nil && bottom != nil && width != nil && height != nil)
                || (top != nil && bottom != nil && width != nil)
                || (centeredX && centeredY && width != nil && height != nil)
                || (centeredY && width != nil && height != nil && (leading != nil || trailing != nil))
                || (centeredY && leading != nil && trailing != nil && height != nil)
                || (centeredX && width != nil && height != nil && (top != nil || bottom != nil))
                || (centeredX && top != nil && bottom != nil && width != nil) else {
                    print("❌ Anchors: Invalid set up, missing some constraint(s)! ❌")
                    throw AnchorsError.invalid
                }
    }
}

// MARK: - ResizingManager
class ResizingManager {
    private init() {}
    static let shared = ResizingManager()
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    
    // Sizes: https://www.ios-resolution.com/
    // Coefficient is determined by size diffence on first decimal point.
    struct ScreenResizeCoefficient {
        let width: Double
        let height: Double
        
        static func getCoefficient() -> ScreenResizeCoefficient {
            switch (ResizingManager.shared.width, ResizingManager.shared.height) {
            case (320.0, 568.0):
                return ScreenResizeCoefficient(width: 0.85, height: 0.85)
            case (375.0, 667.0):
                return ScreenResizeCoefficient(width: 0.9, height: 0.9)
            case (414.0, 736.0):
                return ScreenResizeCoefficient(width: 1.1, height: 1.1)
            case (414.0, 896.0), (428.0, 926.0):
                return ScreenResizeCoefficient(width: 1.1, height: 1.1)
            case (476.0, 847.0):
                return ScreenResizeCoefficient(width: 1.3, height: 1.3)
            case (375.0, 812.0), (390.0, 844.0):
                return ScreenResizeCoefficient(width: 1.0, height: 1.0)
            default:
                print("❌ ScreenResizeCoefficient: Missing resize coefficent for current screen size: \(UIScreen.main.bounds.size.width), \(UIScreen.main.bounds.size.height)! ❌")
                return ScreenResizeCoefficient(width: 1.0, height: 1.0)
            }
        }
        
        static func applyConstraintAdapatationY(_ constraintValue: CGFloat) -> CGFloat {
            return constraintValue * ScreenResizeCoefficient.getCoefficient().height
        }
        
        static func applyConstraintAdapatationX(_ constraintValue: CGFloat) -> CGFloat {
            return constraintValue * ScreenResizeCoefficient.getCoefficient().width
        }
    }
    
    func adaptToDevice(_ anchors: Anchors) throws -> Anchors {
        try anchors.validate()
        let coefficient = ScreenResizeCoefficient.getCoefficient()
        return Anchors(width: anchors.width != nil ? anchors.width! * coefficient.width : nil,
                       height: anchors.height != nil ? anchors.height! * coefficient.height : nil,
                       leading: anchors.leading != nil ? anchors.leading! * coefficient.width : nil,
                       trailing: anchors.trailing != nil ? anchors.trailing! * coefficient.width : nil,
                       top: anchors.top != nil ? anchors.top! * coefficient.height : nil,
                       bottom: anchors.bottom != nil ? anchors.bottom! * coefficient.height : nil,
                       centeredX: anchors.centeredX,
                       centeredY: anchors.centeredY)
    }
}
