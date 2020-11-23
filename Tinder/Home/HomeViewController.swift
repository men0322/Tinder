//
//  HomeViewController.swift
//  Tinder
//
//  Created by NGUYEN HUNG on 11/16/20.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol HomePresentableListener: class {

}

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {

    weak var listener: HomePresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        configureListener()
        configurePresenter()
    }

    private func configureViews() {

    }

    /// Presenter -> Interactor
    private func configureListener() {

    }
}

private extension HomeViewController {
    /// Presenter <-> Interactor
    private func configurePresenter() {

    }
}
