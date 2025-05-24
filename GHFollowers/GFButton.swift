//
//  GFButton.swift
//  GHFollowers
//
//  Created by Surajit Shaw on 24/05/25.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(bgColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = bgColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
