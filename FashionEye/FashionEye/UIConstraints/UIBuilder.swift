//
//  UIBuilder.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 30.7.22..
//

import Foundation
import UIKitSwiftDSL
import Anchorage

extension UIView {
    @discardableResult
    func viewWithAnchors(_ anchors: Anchors,
                         accordingTo view: UIView? = nil) -> UIView {
        let closure: (UIView) -> () = {
            if let view = view {
                view.applyAnchors(anchors, on: $0)
            } else {
                self.applyAnchors(anchors, on: $0)
            }
        }
        return self.view(apply: closure)
    }
    
    func pickerWithAnchors(_ anchors: Anchors,
                         accordingTo view: UIView? = nil) -> UIPickerView {
        let closure: (UIPickerView) -> () = {
            if let view = view {
                view.applyAnchors(anchors, on: $0)
            } else {
                self.applyAnchors(anchors, on: $0)
            }
        }
        return self.picker(apply: closure)
    }
    
    @discardableResult
    func hStack(distribution: UIStackView.Distribution = .fill, _ anchors: Anchors, apply closure: (UIStackView) -> Void) -> UIStackView {
        let handler: (UIStackView) -> () = {
            self.applyAnchors(anchors, on: $0)
            closure($0)
        }
        let stack = stack(apply: handler)
        stack.axis = .horizontal
        stack.distribution = distribution
        return stack
    }
    
    @discardableResult
    func labelWithAnchors(_ anchors: Anchors,
                          accordingTo view: UIView? = nil) -> UILabel {
        let closure: (UILabel) -> () = {
            if let view = view {
                view.applyAnchors(anchors, on: $0)
            } else {
                self.applyAnchors(anchors, on: $0)
            }
        }
        return label(apply: closure)
    }
    
    @discardableResult
    func buttonWithAnchors(_ anchors: Anchors,
                           accordingTo view: UIView? = nil) -> UIButton {
        let closure: (UIButton) -> () = {
            if let view = view {
                view.applyAnchors(anchors, on: $0)
            } else {
                self.applyAnchors(anchors, on: $0)
            }
        }
        return button(apply: closure)
    }
    
    @discardableResult
    func textFieldWithAnchors(_ anchors: Anchors,
                              accordingTo view: UIView? = nil) -> UITextField {
        let closure: (UITextField) -> () = {
            if let view = view {
                view.applyAnchors(anchors, on: $0)
            } else {
                self.applyAnchors(anchors, on: $0)
            }
        }
        return textField(apply: closure)
    }
    
    @discardableResult
    func imageWithAnchors(_ anchors: Anchors,
                          accordingTo view: UIView? = nil) -> UIImageView {
        let closure: (UIImageView) -> () = {
            if let view = view {
                view.applyAnchors(anchors, on: $0)
            } else {
                self.applyAnchors(anchors, on: $0)
            }
        }
        return image(apply: closure)
    }
    
    @discardableResult
    func textViewWithAnchors(_ anchors: Anchors,
                             accordingTo view: UIView? = nil) -> UITextView {
        let closure: (UITextView) -> () = {
            if let view = view {
                view.applyAnchors(anchors, on: $0)
            } else {
                self.applyAnchors(anchors, on: $0)
            }
        }
        return textView(apply: closure)
    }
    
    @discardableResult
    func scrollViewWithAnchors(_ anchors: Anchors,
                               accordingTo view: UIView? = nil) -> UIScrollView {
        let closure: (UIScrollView) -> () = {
            if let view = view {
                view.applyAnchors(anchors, on: $0)
            } else {
                self.applyAnchors(anchors, on: $0)
            }
        }
        return scroll(apply: closure)
    }
    
    func tableViewWithAnchors(_ anchors: Anchors,
                              accordingTo view: UIView? = nil) -> UITableView {
        let closure: (UITableView) -> () = {
            if let view = view {
                view.applyAnchors(anchors, on: $0)
            } else {
                self.applyAnchors(anchors, on: $0)
            }
        }
        return table(apply: closure)
    }
    
    func collectionViewWithAnchors(_ anchors: Anchors,
                              accordingTo view: UIView? = nil) -> UICollectionView {
        let closure: (UICollectionView) -> () = {
            if let view = view {
                view.applyAnchors(anchors, on: $0)
            } else {
                self.applyAnchors(anchors, on: $0)
            }
        }
        return collection(apply: closure)
    }
    
    func switchWithAnchors(_ anchors: Anchors,
                           accordingTo view: UIView? = nil) -> UISwitch {
        let closure: (UISwitch) -> () = {
            if let view = view {
                view.applyAnchors(anchors, on: $0)
            } else {
                self.applyAnchors(anchors, on: $0)
            }
        }
        return uiswitch(apply: closure)
    }
    
    
    func applyAnchors(_ anchors: Anchors, on view: UIView) {
        do {
            let adaptedAnchors = try ResizingManager.shared.adaptToDevice(anchors)
            if let width = adaptedAnchors.width {
                view.widthAnchor == width
            }
            if let height = adaptedAnchors.height {
                view.heightAnchor == height
            }
            if let leading = anchors.leading {
                view.leadingAnchor == self.leadingAnchor + leading
            }
            if let trailing = anchors.trailing {
                view.trailingAnchor == self.trailingAnchor - trailing
            }
            if adaptedAnchors.centeredX {
                view.centerXAnchor == self.centerXAnchor
            }
            if adaptedAnchors.centeredY {
                view.centerYAnchor == self.centerYAnchor
            }
            if let top = adaptedAnchors.top {
                view.topAnchor == self.topAnchor + top
            }
            if let bottom = adaptedAnchors.bottom {
                view.bottomAnchor == self.bottomAnchor - bottom
            }
        } catch {
            print("❌ UIView applyAnchors: \(error) ❌")
        }
    }
}
