//
//  DismissGestureRecognizer.swift
//  DismissGestureRecognizerDemo
//
//  Created by janlionly on 2019/8/21.
//  Copyright © 2019 Janlionly<janlionly@gmail.com>. All rights reserved.
//

import UIKit

private protocol PropertyStoring {
    associatedtype T = AnyObject
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: T) -> T
}

private extension PropertyStoring {
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: T) -> T {
        guard let value = objc_getAssociatedObject(self, key) as? T else {
            return defaultValue
        }
        return value
    }
}

extension UIViewController: PropertyStoring {
    public enum DismissType {
        case disableGesture
        case swipeRightForLeftEdgeScreen
        // case swipeRightForFullScreen
        case panRightForLeftEdgeScreen
        // case panRightForFullScreen
    }

    private struct CustomProperties {
        static var dismissType: DismissType = .disableGesture
        static var dismissTypeGesture: UIGestureRecognizer? = nil
    }

    public var dismissType: DismissType {
        get {
            let type = getAssociatedObject(&CustomProperties.dismissType, defaultValue: CustomProperties.dismissType as AnyObject) as? DismissType
            return type ?? .disableGesture
        }
        set {
            objc_setAssociatedObject(self, &CustomProperties.dismissType, newValue, .OBJC_ASSOCIATION_RETAIN)
            addPanGesture()
        }
    }
    
    private var dismissTypeGesture: UIGestureRecognizer? {
        get {
            let gesture = getAssociatedObject(&CustomProperties.dismissTypeGesture, defaultValue: CustomProperties.dismissTypeGesture as AnyObject) as? UIGestureRecognizer
            return gesture
        }
        set {
            objc_setAssociatedObject(self, &CustomProperties.dismissTypeGesture, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private func disableDismissTypeGesture() {
        if let g = dismissTypeGesture {
            g.isEnabled = false
            view.removeGestureRecognizer(g)
        }
    }

    private func addPanGesture() {
        disableDismissTypeGesture()
        if dismissType != .disableGesture {
            if (navigationController != nil && navigationController!.viewControllers.count == 1) || navigationController == nil {
                if dismissType == .panRightForLeftEdgeScreen {
                    let screenGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
                    dismissTypeGesture = screenGesture
                    screenGesture.edges = .left
                    view.addGestureRecognizer(screenGesture)
                }
//                else if dismissType == .panRightForFullScreen {
//                    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
//                    dismissTypeGesture = panGesture
//                    view.addGestureRecognizer(panGesture)
//                }
                else if dismissType == .swipeRightForLeftEdgeScreen {
                    let screenGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgePanGesture(_:)))
                    dismissTypeGesture = screenGesture
                     screenGesture.edges = .left
                     view.addGestureRecognizer(screenGesture)
                }
//                else if dismissType == .swipeRightForFullScreen {
//                    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleEdgePanGesture(_:)))
//                    dismissTypeGesture = panGesture
//                    view.addGestureRecognizer(panGesture)
//                }
            }
        }
    }
    
    @objc private func handleEdgePanGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            self.view.endEditing(true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        let percent = max(sender.translation(in: view).x, 0) / view.frame.width
        let velocity = sender.velocity(in: view).x
        var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
        let safeAreaInsets: UIEdgeInsets = {
            if #available(iOS 11.0, *) {
                if let win = UIApplication.shared.delegate?.window {
                    if let w = win {
                        return w.safeAreaInsets
                    }
                }
            }
            return UIEdgeInsets.zero
        }()

        let targetView = navigationController == nil ? self.view! : navigationController!.view!
        
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.x - initialTouchPoint.x > 0 {
                let topConstant: CGFloat = (navigationController != nil && !navigationController!.isNavigationBarHidden) ? safeAreaInsets.top : 0.0
                targetView.frame = CGRect(x: 0, y: touchPoint.x - initialTouchPoint.x + topConstant, width: targetView.frame.size.width, height: targetView.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if percent > 0.4 || velocity > 1000 {
                self.view.endEditing(true)
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    targetView.frame = CGRect(x: 0, y: 0, width: targetView.frame.size.width, height: targetView.frame.size.height)
                })
            }
        }
    }
}
