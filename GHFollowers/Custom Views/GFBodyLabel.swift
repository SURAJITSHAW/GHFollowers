//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Surajit Shaw on 25/05/25.
//

import UIKit

class GFBodyLabel: UILabel {


    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .body)
        lineBreakMode = .byWordWrapping
        tintColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
    }

}
