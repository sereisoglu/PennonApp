//
//  MenuCellView.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class MenuCellView: UITableViewCell {
    
    internal var menuController: MenuController?
    internal var iconViewLeadingAnchor: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setUpTheming()
    }
    
    internal let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal let iconView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    internal let arrowButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "arrow_right"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        self.addSubview(iconView)
        self.addSubview(nameLabel)
        self.addSubview(arrowButton)
        
        arrowButton.addTarget(self, action: #selector(buttonAction), for: .touchDown)
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            iconView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            iconView.widthAnchor.constraint(equalToConstant: 29),
            iconView.heightAnchor.constraint(equalToConstant: 29),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10),
            
            arrowButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            arrowButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            arrowButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            arrowButton.widthAnchor.constraint(equalToConstant: 29),
            arrowButton.heightAnchor.constraint(equalToConstant: 29)
            ])
        
        iconViewLeadingAnchor = iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 49)
        iconViewLeadingAnchor.isActive = true
    }
    
    func animateButton(_ isOpened: Bool) {
        let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        lightImpactFeedbackGenerator.prepare()
        lightImpactFeedbackGenerator.impactOccurred()
        
        var angle: CGFloat
        
        if isOpened == true {
            angle = CGFloat.pi / 2
            self.arrowButton.setImage(#imageLiteral(resourceName: "arrow_right"), for: .normal)
        } else {
            angle = -(CGFloat.pi / 2)
            self.arrowButton.setImage(#imageLiteral(resourceName: "arrow_bottom"), for: .normal)
        }
        
        self.arrowButton.transform = CGAffineTransform.identity
        
        arrowButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1, animations: {
            self.arrowButton.transform = CGAffineTransform(rotationAngle: angle)
        }) { (_) in
            self.arrowButton.isUserInteractionEnabled = true
        }
        
    }
    
    @objc func buttonAction() {
        self.menuController?.reloadTableSection(cell: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MenuCellView: Themed {
    func applyTheme(_ theme: AppTheme) {
        self.backgroundColor = theme.backgroundColor
        nameLabel.textColor = theme.primaryColor
        nameLabel.font = theme.paragraph1Font
        iconView.tintColor = theme.primaryColor
        arrowButton.tintColor = theme.primaryColor
    }
}
