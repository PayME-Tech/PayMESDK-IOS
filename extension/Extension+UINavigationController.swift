//
//  Extension+UINavigationController.swift
//  Pods
//
//  Created by Minh Khoa on 4/16/21.
//
//

import Foundation

extension UINavigationController {
    public func pushViewController(
            _ viewController: UIViewController,
            animated: Bool,
            completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

    func popViewController(
            animated: Bool,
            completion: @escaping () -> Void) {
        popViewController(animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
}