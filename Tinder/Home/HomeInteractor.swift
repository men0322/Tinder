//
//  HomeInteractor.swift
//  Tinder
//
//  Created by NGUYEN HUNG on 11/16/20.
//

import RIBs
import RxSwift
import RxCocoa
import HNService
import Action

protocol HomeRouting: ViewableRouting {
}

protocol HomePresentable: Presentable {
    var listener: HomePresentableListener? { get set }
}

protocol HomeListener: class {
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {

    weak var router: HomeRouting?
    weak var listener: HomeListener?
    
    let partnerService: HNPartnerServiceType
    
    private lazy var getPartnersAction = buildGetPartnersAction()
    
    init(presenter: HomePresentable,
         partnerService: HNPartnerServiceType) {
        
        self.partnerService = partnerService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        configurePresenter()
        configureRouter()
        configureListener()
    }
}

private extension HomeInteractor {
    /// Interactor -> Presenter
    func configurePresenter() {
        getPartnersAction
            .elements
            .subscribe(onNext: { result in
                print(result)
            })
            .disposeOnDeactivate(interactor: self)
        
        getPartnersAction.execute((10,1))
    }

    /// Interactor -> Router
    func configureRouter() {

    }

    /// Interactor -> Parent
    func configureListener() {
        
    }
}

extension HomeInteractor {
    func buildGetPartnersAction() -> Action<(itemsPerPage: Int, page: Int), [HNPartner]> {
        return Action<(itemsPerPage: Int, page: Int), [HNPartner]> { [unowned self] param in
            self.partnerService.getPartners(itemsPerPage: param.itemsPerPage, page: param.page)
        }
    }
}
