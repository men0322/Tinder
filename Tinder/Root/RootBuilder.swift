//
//  RootBuilder.swift
//  Tinder
//
//  Created by NGUYEN HUNG on 11/16/20.
//

import RIBs
import UIKit

protocol RootDependency: Dependency {

}

final class RootComponent: Component<RootDependency>, HomeDependency {

}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build(window: UIWindow) -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build(window: UIWindow) -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let homeBuidler = HomeBuilder(dependency: component)
        let interactor = RootInteractor(presenter: viewController)
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          homeBuilder: homeBuidler,
                          window: window)
    }
}
