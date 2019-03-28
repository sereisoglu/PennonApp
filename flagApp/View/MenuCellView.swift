//
//  MenuCellView.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class MenuCellView: UITableViewCell {
    
    var menuController: MenuController?
    var iconViewLeadingAnchor: NSLayoutConstraint!
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.init(white: 0, alpha: 0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.alpha = 0.8
        return iv
    }()
    
    let arrowButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "rightExpand-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.init(white: 0, alpha: 0.8)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    func setupViews() {
        self.addSubview(iconView)
        self.addSubview(nameLabel)
        self.addSubview(arrowButton)
        
        arrowButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
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
    
    @objc func buttonAction() {
        self.menuController?.reloadTableSection(cell: self)
    }
    
    func animateButton(_ isOpened: Bool) {
        if #available(iOS 10.0, *) {
            let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            lightImpactFeedbackGenerator.prepare()
            lightImpactFeedbackGenerator.impactOccurred()
        }
        
        var angle: CGFloat
        
        if isOpened == true {
            angle = CGFloat.pi / 2
            self.arrowButton.setImage(#imageLiteral(resourceName: "rightExpand-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        } else {
            angle = -(CGFloat.pi / 2)
            self.arrowButton.setImage(#imageLiteral(resourceName: "bottomExpand-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        }
        
        self.arrowButton.transform = CGAffineTransform.identity
        
        arrowButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1, animations: {
            self.arrowButton.transform = CGAffineTransform(rotationAngle: angle)
        }) { (_) in
            self.arrowButton.isUserInteractionEnabled = true
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
