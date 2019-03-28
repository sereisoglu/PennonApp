//
//  InfoView.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
    var menuController: MenuController?
    
    let centerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "FLAG PLAYER"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "flagplayerapp@gmail.com"
        label.textColor = .white
        return label
    }()
    
    let topImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "flagLogo-48")
        return iv
    }()
    
    let bottomImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "ser-48")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupBackgroundVisualEffectView()
        setupCenterView()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        self.addGestureRecognizer(singleTap)
    }
    
    func setupBackgroundVisualEffectView() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    
    func setupCenterView() {
        self.addSubview(centerView)
        centerView.addSubview(topImageView)
        centerView.addSubview(topLabel)
        centerView.addSubview(bottomLabel)
        centerView.addSubview(bottomImageView)
        
        NSLayoutConstraint.activate([
            centerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            centerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            centerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            topImageView.topAnchor.constraint(equalTo: centerView.topAnchor, constant: 10),
            topImageView.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            
            topLabel.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 10),
            topLabel.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
            bottomLabel.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            
            bottomImageView.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor),
            bottomImageView.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            bottomImageView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor)
            ])
    }
    
    @objc func handleSingleTap() {
        menuController!.closeInfoController(infoView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
