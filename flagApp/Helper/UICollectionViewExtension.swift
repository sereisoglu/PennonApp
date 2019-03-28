//
//  UICollectionViewExtension.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 22.01.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func setEmptyCollectionView(labelText: String, buttonIsHide: Bool, buttonText: String = "", button: UIButton = UIButton()) {
        button.isHidden = buttonIsHide
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "flag-48")
        imageView.alpha = 0.1
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = labelText
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textAlignment = .center;
        label.alpha = 0.8
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(buttonText, for: .normal)
        button.tintColor = .white
        button.titleLabel!.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.adjustsImageWhenHighlighted = false
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.alpha = 0.8
        
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: self.bounds.size.width),
            view.heightAnchor.constraint(equalToConstant: self.bounds.size.height),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: button.topAnchor,  constant: -15),
            imageView.widthAnchor.constraint(equalToConstant: 75),
            imageView.heightAnchor.constraint(equalToConstant: 75),
            
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        self.backgroundView = view
    }
    
    //    func setNotEmptyCollectionView() {
    //        self.backgroundView = nil
    //    }
}
