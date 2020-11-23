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
import RxDataSources

public protocol CardStackDelegate  {
    func cardDidChangeState(_ cardIndex: Int)
}

protocol HomePresentableListener: class {
    var loadNextTrigger: PublishRelay<Void> { get set }
}

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {
    weak var listener: HomePresentableListener?
    
    // IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Presenter
    let homeViewModel = BehaviorRelay<HomeViewModel?>(value: nil)
    
    // Global variable
    private lazy var dataSource = self.buildDataSource()
    let disposeBag = DisposeBag()
    
    var layout: CardStackViewLayout? { return collectionView.collectionViewLayout as? CardStackViewLayout }
    
    private struct Constants {
        static let cardsPadding: CGFloat = 20
        static let cardsHeightFactor: CGFloat = 0.33

    }
}

// MARK: - Life cycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureCollectionView()
        configureListener()
        configurePresenter()
    }
}

// MARK: - Configure
extension HomeViewController {

    private func configurePresenter() {
        homeViewModel
            .asDriver()
            .map { $0?.sections ?? [] }
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        homeViewModel
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] _ in
                self?.initFlowLayout()
            })
            .disposed(by: disposeBag)
        
    }
    
    private func configureViews() {

    }

    private func configureListener() {

    }
}

// MARK: - CollectionView
extension HomeViewController {
    
    func initFlowLayout() {
        layout?.gesturesEnabled = true
        layout?.delegate = self
        collectionView!.isScrollEnabled = false
        setCardSize(CGSize(width: collectionView!.bounds.width - 2 * Constants.cardsPadding, height: Constants.cardsHeightFactor * collectionView!.bounds.height))
    }
    
    func setCardSize(_ size: CGSize) {
        layout?.cardSize = size
    }
    
    func configureCollectionView() {
        collectionView.register(R.nib.cardCollectionViewCell)
    }
    
    func buildDataSource() -> RxCollectionViewSectionedReloadDataSource<Section> {
        return RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { (_, collectionView, indexPath, model) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.cardCollectionViewCell, for: indexPath)
                cell?.contentView.backgroundColor = (indexPath.row % 2 == 0) ? .red : .cyan
                cell?.model = model
                return cell ?? UICollectionViewCell()
        })
    }
    
    
}

// CollectionView Datasource
extension HomeViewController {

    typealias Section = HomeViewModel.Section
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<Section>
}

extension HomeViewController: CardStackDelegate {
    func cardDidChangeState(_ cardIndex: Int) {
        //layout?.cardDidRemoved(cardIndex)
    }
}
