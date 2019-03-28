//
//  TrashEmptyHomeControllerView.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 8.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class TrashEmptyHomeControllerView: UIView {
    
    public let backgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        v.clipsToBounds = true
        return v
    }()
    
    public let generalView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Empty"
        label.textAlignment = .center
        return label
    }()
    
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private var value1: CGFloat!
    private var value2: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bounds = UIScreen.main.bounds
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            value1 = 10
            value2 = bounds.width > bounds.height ? bounds.height * 0.75 : bounds.width * 0.75
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            value1 = 20
            value2 = bounds.width > bounds.height ? bounds.width * 0.25 : bounds.height * 0.25
        }
        
        setupView()
        setUpTheming()
    }
    
    private func setupView() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(generalView)
        generalView.addSubview(headerLabel)
        generalView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(UIScreen.main.bounds.height / 2) + (value2 / 4)),
            backgroundView.widthAnchor.constraint(equalToConstant: value2),
            backgroundView.heightAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.5),
            
            generalView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            generalView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            generalView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -value1),
            generalView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: value1),
            
            headerLabel.topAnchor.constraint(equalTo: generalView.topAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: generalView.trailingAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: generalView.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: generalView.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: generalView.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: generalView.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TrashEmptyHomeControllerView: Themed {
    func applyTheme(_ theme: AppTheme) {
        self.backgroundView.backgroundColor = theme.tertiaryColor
        self.headerLabel.textColor = theme.secondaryColor
        self.headerLabel.font = theme.header2Font
        self.descriptionLabel.textColor = theme.secondaryColor
        self.descriptionLabel.font = theme.paragraph1Font
    }
}
