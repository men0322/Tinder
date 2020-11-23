//
//  HomeViewModel.swift
//  Tinder
//
//  Created by NGUYEN HUNG on 11/23/20.
//

import Foundation
import HNService
import RxDataSources

public struct HomeViewModel {
    private(set) var sections: [Section] = []
    
    init(partners: [HNPartner]) {
        let cells = partners.map { CardCellModel(partner: $0) }
        let section = Section(model: "", items: cells)
        sections.append(section)
    }
}

extension HomeViewModel {
    typealias Section = SectionModel<String, CardCellModel>
}
