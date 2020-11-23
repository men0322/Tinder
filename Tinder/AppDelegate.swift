//
//  AppDelegate.swift
//  Tinder
//
//  Created by NGUYEN HUNG on 11/16/20.
//

import UIKit
import RIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?
    private var launchRouter: LaunchRouting?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let launchRouter = RootBuilder(dependency: AppComponent()).build(window: window)
        self.launchRouter = launchRouter
        launchRouter.launch(from: window)
        return true
    }
}

