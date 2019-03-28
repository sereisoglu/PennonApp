//
//  PhoneThemeController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 7.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class PhoneThemeController: UIViewController {
    
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
        label.text = "Theme and Icon Badge"
        label.numberOfLines = 2
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
    
    private let stackBackgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 15
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [themeView1, themeView2])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 15
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Theme"
        label.textAlignment = .center
        return label
    }()
    
    private let themeView1: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let lightThemeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "theme"), for: .normal)
        button.tintColor = UIColor.init(white: 1, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let themeView2: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let darkThemeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "theme"), for: .normal)
        button.tintColor = UIColor.init(white: 0.1, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let stack2BackgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 15
        return v
    }()
    
    private lazy var stackView2: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [iconBadgeView1, iconBadgeView2])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 25
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let iconBadgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Icon\nBadge"
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let iconBadgeView1: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let lightIconButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "light_icon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let iconBadgeView2: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let darkIconButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "dark_icon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchDown)
        lightThemeButton.addTarget(self, action: #selector(handleLightThemeButton), for: .touchDown)
        darkThemeButton.addTarget(self, action: #selector(handleDarkThemeButton), for: .touchDown)
        lightIconButton.addTarget(self, action: #selector(handleLightIconButton), for: .touchDown)
        darkIconButton.addTarget(self, action: #selector(handleDarkIconButton), for: .touchDown)
        
        setUpTheming()
    }
    
    private func setupView() {
        self.view.addSubview(generalView)
        generalView.addSubview(label1)
        generalView.addSubview(closeButton)
        closeButton.addSubview(closeImageView)
        
        generalView.addSubview(stackBackgroundView)
        stackBackgroundView.addSubview(themeLabel)
        stackBackgroundView.addSubview(stackView)
        themeView1.addSubview(lightThemeButton)
        themeView2.addSubview(darkThemeButton)
        generalView.addSubview(stack2BackgroundView)
        stack2BackgroundView.addSubview(iconBadgeLabel)
        stack2BackgroundView.addSubview(stackView2)
        iconBadgeView1.addSubview(lightIconButton)
        iconBadgeView2.addSubview(darkIconButton)
        
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
            
            stackBackgroundView.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 10),
            stackBackgroundView.centerXAnchor.constraint(equalTo: generalView.centerXAnchor),
            stackBackgroundView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
            stackBackgroundView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),
            stackBackgroundView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            themeLabel.topAnchor.constraint(equalTo: stackBackgroundView.topAnchor, constant: 20),
            themeLabel.centerXAnchor.constraint(equalTo: stackBackgroundView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 5),
            stackView.centerXAnchor.constraint(equalTo: stackBackgroundView.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: generalView.widthAnchor, multiplier: 0.5),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            lightThemeButton.widthAnchor.constraint(equalToConstant: 50),
            lightThemeButton.heightAnchor.constraint(equalTo: lightThemeButton.widthAnchor),
            lightThemeButton.centerXAnchor.constraint(equalTo: themeView1.centerXAnchor),
            lightThemeButton.centerYAnchor.constraint(equalTo: themeView1.centerYAnchor),
            
            darkThemeButton.widthAnchor.constraint(equalToConstant: 50),
            darkThemeButton.heightAnchor.constraint(equalTo: darkThemeButton.widthAnchor),
            darkThemeButton.centerXAnchor.constraint(equalTo: themeView2.centerXAnchor),
            darkThemeButton.centerYAnchor.constraint(equalTo: themeView2.centerYAnchor),
            
            stack2BackgroundView.topAnchor.constraint(equalTo: stackBackgroundView.bottomAnchor, constant: 10),
            stack2BackgroundView.centerXAnchor.constraint(equalTo: generalView.centerXAnchor),
            stack2BackgroundView.trailingAnchor.constraint(equalTo: stackView2.trailingAnchor, constant: 10),
            stack2BackgroundView.leadingAnchor.constraint(equalTo: stackView2.leadingAnchor, constant: -10),
            stack2BackgroundView.bottomAnchor.constraint(equalTo: stackView2.bottomAnchor),
            
            iconBadgeLabel.topAnchor.constraint(equalTo: stack2BackgroundView.topAnchor, constant: 20),
            iconBadgeLabel.centerXAnchor.constraint(equalTo: stack2BackgroundView.centerXAnchor),
            
            stackView2.topAnchor.constraint(equalTo: iconBadgeLabel.bottomAnchor, constant: 5),
            stackView2.centerXAnchor.constraint(equalTo: stack2BackgroundView.centerXAnchor),
            stackView2.widthAnchor.constraint(equalTo: generalView.widthAnchor, multiplier: 0.5),
            stackView2.heightAnchor.constraint(equalToConstant: 100),
            
            lightIconButton.widthAnchor.constraint(equalToConstant: 50),
            lightIconButton.heightAnchor.constraint(equalTo: lightIconButton.widthAnchor),
            lightIconButton.centerXAnchor.constraint(equalTo: iconBadgeView1.centerXAnchor),
            lightIconButton.centerYAnchor.constraint(equalTo: iconBadgeView1.centerYAnchor),
            
            darkIconButton.widthAnchor.constraint(equalToConstant: 50),
            darkIconButton.heightAnchor.constraint(equalTo: darkIconButton.widthAnchor),
            darkIconButton.centerXAnchor.constraint(equalTo: iconBadgeView2.centerXAnchor),
            darkIconButton.centerYAnchor.constraint(equalTo: iconBadgeView2.centerYAnchor)
            ])
    }
    
    @objc private func handleLightThemeButton() {
        AppUtility.toggleTheme(theme: "lightPhone")
    }
    
    @objc private func handleDarkThemeButton() {
        AppUtility.toggleTheme(theme: "darkPhone")
    }
    
    @objc private func handleLightIconButton() {
        // TODO: current'e gore icon zaten set edilmisse ayni icon set edilemesin.
        AppIconService.changeAppIcon(to: .iconDefault)
    }
    
    @objc private func handleDarkIconButton() {
        AppIconService.changeAppIcon(to: .iconDarkPhone)
    }
    
    @objc private func handleCloseButton() {
        closePhoneThemeController()
    }
    
    private func closePhoneThemeController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PhoneThemeController: Themed {
    func applyTheme(_ theme: AppTheme) {
        themedStatusBarStyle = theme.statusBarStyle
        setNeedsStatusBarAppearanceUpdate()
        
        generalView.backgroundColor = theme.backgroundColor
        label1.textColor = theme.primaryColor
        label1.font = theme.header1Font
        closeButton.backgroundColor = theme.primaryColor
        closeImageView.tintColor = theme.tertiaryColor
        themeLabel.textColor = theme.secondaryColor
        themeLabel.font = theme.header2Font
        iconBadgeLabel.textColor = theme.secondaryColor
        iconBadgeLabel.font = theme.header2Font
        stackBackgroundView.backgroundColor = theme.tertiaryColor
        stack2BackgroundView.backgroundColor = theme.tertiaryColor
    }
}

