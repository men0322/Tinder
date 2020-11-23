//
//  AppComponent.swift
//  Tinder
//
//  Created by NGUYEN HUNG on 11/16/20.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}
