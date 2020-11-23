//
//  RootInteractor.swift
//  Tinder
//
//  Created by NGUYEN HUNG on 11/16/20.
//

import RIBs
import RxSwift
import RxCocoa

protocol RootRouting: ViewableRouting {
    func attachHomeView()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

protocol RootListener: class {
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        configureHomeView()
    }
}

extension RootInteractor {
    func configureHomeView() {
        router?.attachHomeView()
    }
}
