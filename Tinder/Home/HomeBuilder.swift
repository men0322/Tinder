//
//  HomeBuilder.swift
//  Tinder
//
//  Created by NGUYEN HUNG on 11/16/20.
//

import RIBs
import UIKit
import HNService

protocol HomeDependency: Dependency {

}

final class HomeComponent: Component<HomeDependency>, HomeDependency {

}

// MARK: - Builder

protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener) -> HomeRouting
}

final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {

    override init(dependency: HomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HomeListener) -> HomeRouting {
        let component = HomeComponent(dependency: dependency)
        let viewController = R.storyboard.homeViewController.homeViewController() ?? HomeViewController()
        let interactor = HomeInteractor(presenter: viewController,
                                        partnerService: HNPartnerService())
        interactor.listener = listener
        return HomeRouter(interactor: interactor, viewController: viewController)
    }
}
