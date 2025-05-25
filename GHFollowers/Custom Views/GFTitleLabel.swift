//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Surajit Shaw on 25/05/25.
//

import UIKit

class GFTitleLabel: UILabel {


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byTruncatingTail
        tintColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
    }

}
