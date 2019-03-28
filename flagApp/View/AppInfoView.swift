//
//  AppInfoView.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class AppInfoView: UIView {
    
    var homeController: HomeController?
    
    let centerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let centerImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "appInfo-256")
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
        centerView.addSubview(centerImageView)
        
        NSLayoutConstraint.activate([
            centerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            centerView.widthAnchor.constraint(equalToConstant: 300),
            centerView.heightAnchor.constraint(equalToConstant: 300),
            
            centerImageView.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            centerImageView.centerYAnchor.constraint(equalTo: centerView.centerYAnchor)
            ])
    }
    
    @objc func handleSingleTap() {
        homeController!.closeAppInfoController(appInfoView: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
