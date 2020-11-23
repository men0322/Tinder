//
//  CardCollectionViewCell.swift
//  Tinder
//
//  Created by NGUYEN HUNG on 11/23/20.
//

import UIKit
import HNService

struct CardCellModel {
    init(partner: HNPartner) {
        
    }
}

class CardCollectionViewCell: UICollectionViewCell {

    private struct Constants {
        static let cellCornerRadius: CGFloat = 12
        static let animationSpeed: Float = 0.86
        static let rotationRadius: CGFloat = 15
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var model: CardCellModel? {
        didSet {
        }
    }
    
    override var center: CGPoint {
        didSet {
            updateSmileVote()
        }
    }
    
    override internal func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        updateSmileVote()
    }
    
    func updateSmileVote() {
        let rotation = atan2(transform.b, transform.a) * 100
        
        switch rotation {
        case -1 * Constants.rotationRadius ..< 0:
            //left
            contentView.backgroundColor = .gray
        case 1..<Constants.rotationRadius:
            //right
            contentView.backgroundColor = .black
        default:
            break
        }
    }
}
