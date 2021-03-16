//
//  ViewModifiers.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/29.
//


import SwiftUI

// Add Swipe Gesture back when customizing navigation bar
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self // The delegate of the gesture recognizer.
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool { // Asks the delegate if a gesture recognizer should begin interpreting touches.
        return viewControllers.count > 1
    }
}

// Snap shot of a view
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self) // Initialize view controller
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize // Set target size
        view?.bounds = CGRect(origin: .zero, size: targetSize) // get bounds of the view
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in // Render and output as UIImage
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
