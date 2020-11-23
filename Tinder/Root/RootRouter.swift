//
//  RootRouter.swift
//  Tinder
//
//  Created by NGUYEN HUNG on 11/16/20.
//

import RIBs
import HNCommon

protocol RootInteractable: Interactable, HomeListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

public protocol RootViewControllable: ViewControllable {
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    let homeBuilder: HomeBuildable
    let window: UIWindow
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         homeBuilder: HomeBuildable,
         window: UIWindow) {
        
        self.window = window
        self.homeBuilder = homeBuilder
        super.init(interactor: interactor,
                   viewController: viewController)
        interactor.router = self
    }
    
    func attachHomeView() {
        let home = homeBuilder.build(withListener: interactor)
        attachChild(home)
        let navigationController = HNNavigationController(rootViewController: home.viewControllable.uiviewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
