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
    var homeViewModel: BehaviorRelay<HomeViewModel?> { get }
}

protocol HomeListener: class {
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {

    weak var router: HomeRouting?
    weak var listener: HomeListener?
    
    let partnerService: HNPartnerServiceType
    
    private lazy var getPartnersAction = buildGetPartnersAction()

    var partnersRelay = BehaviorRelay<[HNPartner]>(value: [])
    
    var currentPage: Int = 1
    
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
            .subscribe(onNext: { [weak self] newPartners in
                guard let self = self else { return }
                var currentPartners = self.partnersRelay.value
                currentPartners += newPartners
                self.partnersRelay.accept(currentPartners)
            })
            .disposeOnDeactivate(interactor: self)
        
        partnersRelay
            .map { HomeViewModel(partners: $0) }
            .bind(to: presenter.homeViewModel)
            .disposeOnDeactivate(interactor: self)
        
        getPartnersAction.execute((10, currentPage))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            // your code here
            self.currentPage += 1
            self.getPartnersAction.execute((10, self.currentPage))
        }
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
