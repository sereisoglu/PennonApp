//
//  PhoneAboutController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 7.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class PhoneAboutController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    private var themedStatusBarStyle: UIStatusBarStyle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themedStatusBarStyle ?? super.preferredStatusBarStyle
    }
    
    private let generalView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "About Flag Player"
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let closeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "close_bold")
        return iv
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [aboutView1, aboutView2])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 25
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    private let aboutView1: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let aboutLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Contact"
        return label
    }()
    
    private let mailButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("info@flagplayer.com", for: .normal)
        return b
    }()
    
    private let websiteButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("www.flagplayer.app", for: .normal)
        return b
    }()
    
    private let aboutView2: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let aboutImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "ser")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let aboutLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Created by Saffet Emin Reisoğlu"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchDown)
        
        setUpTheming()
    }
    
    private func setupView() {
        self.view.addSubview(generalView)
        generalView.addSubview(label1)
        generalView.addSubview(closeButton)
        closeButton.addSubview(closeImageView)
        
        generalView.addSubview(stackView)
        aboutView1.addSubview(aboutLabel1)
        aboutView1.addSubview(mailButton)
        aboutView1.addSubview(websiteButton)
        aboutView2.addSubview(aboutImageView)
        aboutView2.addSubview(aboutLabel2)
        
        NSLayoutConstraint.activate([
            generalView.topAnchor.constraint(equalTo: self.view.topAnchor),
            generalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            generalView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            generalView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            label1.topAnchor.constraint(equalTo: generalView.topAnchor, constant: 40),
            label1.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -20),
            label1.leadingAnchor.constraint(equalTo: generalView.leadingAnchor,constant: 20),
            
            closeButton.centerYAnchor.constraint(equalTo: label1.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: generalView.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            
            closeImageView.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor),
            closeImageView.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            closeImageView.widthAnchor.constraint(equalToConstant: 15),
            closeImageView.heightAnchor.constraint(equalTo: closeImageView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: generalView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: generalView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 150),
            
            aboutLabel1.topAnchor.constraint(equalTo: aboutView1.topAnchor),
            aboutLabel1.centerXAnchor.constraint(equalTo: aboutView1.centerXAnchor),
            
            mailButton.topAnchor.constraint(equalTo: aboutLabel1.bottomAnchor),
            mailButton.centerXAnchor.constraint(equalTo: aboutView1.centerXAnchor),
            mailButton.widthAnchor.constraint(equalToConstant: 200),
            mailButton.heightAnchor.constraint(equalToConstant: 40),
            
            websiteButton.topAnchor.constraint(equalTo: mailButton.bottomAnchor),
            websiteButton.centerXAnchor.constraint(equalTo: aboutView1.centerXAnchor),
            websiteButton.widthAnchor.constraint(equalToConstant: 200),
            websiteButton.heightAnchor.constraint(equalToConstant: 40),
            
            aboutImageView.topAnchor.constraint(equalTo: aboutView2.topAnchor),
            aboutImageView.centerXAnchor.constraint(equalTo: aboutView2.centerXAnchor),
            aboutImageView.widthAnchor.constraint(equalToConstant: 50),
            aboutImageView.heightAnchor.constraint(equalTo: aboutImageView.widthAnchor),
            
            aboutLabel2.topAnchor.constraint(equalTo: aboutImageView.bottomAnchor),
            aboutLabel2.centerXAnchor.constraint(equalTo: aboutView2.centerXAnchor)
            ])
        
        mailButton.addTarget(self, action: #selector(handleMailButton), for: .touchDown)
        websiteButton.addTarget(self, action: #selector(handleWebsiteButton), for: .touchDown)
    }
    
    @objc private func handleMailButton() {
        print("handleMailButton")
    }
    
    @objc private func handleWebsiteButton() {
        if let url = URL(string: "http://www.flagplayer.app"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @objc func handleSingleTap() {
        closeAboutController()
    }
    
    @objc private func handleCloseButton() {
        closeAboutController()
    }
    
    private func closeAboutController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PhoneAboutController: Themed {
    func applyTheme(_ theme: AppTheme) {
        themedStatusBarStyle = theme.statusBarStyle
        setNeedsStatusBarAppearanceUpdate()
        
        generalView.backgroundColor = theme.backgroundColor
        label1.textColor = theme.primaryColor
        label1.font = theme.header1Font
        closeButton.backgroundColor = theme.primaryColor
        closeImageView.tintColor = theme.tertiaryColor
        aboutLabel1.textColor = theme.secondaryColor
        aboutLabel1.font = theme.header2Font
        mailButton.setTitleColor(theme.secondaryColor, for: .normal)
        mailButton.titleLabel?.font = theme.custom1Font
        websiteButton.setTitleColor(theme.secondaryColor, for: .normal)
        websiteButton.titleLabel?.font = theme.custom1Font
        aboutImageView.tintColor = theme.tertiaryColor
        aboutLabel2.textColor = theme.tertiaryColor
        aboutLabel2.font = theme.paragraph1Font
    }
}
