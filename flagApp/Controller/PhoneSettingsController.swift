//
//  PhoneSettingsController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 7.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class PhoneSettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    private var themedStatusBarStyle: UIStatusBarStyle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themedStatusBarStyle ?? super.preferredStatusBarStyle
    }
    
    private var tableViewData = [SettingsModel]()
    
    private let generalView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        return label
    }()
    
    private let tableViewCellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tableViewCellColor: UIColor = {
        let color = UIColor()
        return color
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
    
    private let tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "black_icon")
        iv.alpha = 0.25
        return iv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData = [
            SettingsModel(title: "Theme and Icon Badge"),
            SettingsModel(title: "Tutorial"),
            SettingsModel(title: "About Flag Player")
        ]
        
        self.view.backgroundColor = .clear
        setupView()
        
        closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchDown)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false
        
        setUpTheming()
    }
    
    private func setupView() {
        self.view.addSubview(generalView)
        generalView.addSubview(label1)
        generalView.addSubview(closeButton)
        closeButton.addSubview(closeImageView)
        generalView.addSubview(tableView)
        generalView.addSubview(logoImageView)
        
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
            
            tableView.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: generalView.trailingAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: generalView.leadingAnchor, constant: 10),
            tableView.heightAnchor.constraint(equalToConstant: 40*3),
            
            logoImageView.centerXAnchor.constraint(equalTo: generalView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 50),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor)
            ])
    }
    
    @objc private func handleCloseButton() {
        closePhoneSettingsController()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = tableViewCellLabel.font
        cell.textLabel?.textColor = tableViewCellLabel.textColor
        cell.backgroundColor = tableViewCellColor
        cell.selectionStyle = .none
        cell.textLabel?.text = tableViewData[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            openPhoneThemeController()
        } else if indexPath.row == 1 {
            openPhoneTutorialController()
        } else if indexPath.row == 2 {
            openPhoneAboutController()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    public func openPhoneThemeController() {
        let phoneThemeController = PhoneThemeController()
        present(phoneThemeController, animated: true, completion: nil)
    }
    
    public func openPhoneTutorialController() {
        let phoneTutorialController = PhoneTutorialController()
        present(phoneTutorialController, animated: true, completion: nil)
    }
    
    public func openPhoneAboutController() {
        let phoneAboutController = PhoneAboutController()
        present(phoneAboutController, animated: true, completion: nil)
    }
    
    private func closePhoneSettingsController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PhoneSettingsController: Themed {
    func applyTheme(_ theme: AppTheme) {
        themedStatusBarStyle = theme.statusBarStyle
        setNeedsStatusBarAppearanceUpdate()
        
        self.view.backgroundColor = theme.backgroundColor
        label1.textColor = theme.primaryColor
        label1.font = theme.header1Font
        closeButton.backgroundColor = theme.primaryColor
        closeImageView.tintColor = theme.tertiaryColor
        tableViewCellColor = theme.backgroundColor
        tableViewCellLabel.textColor = theme.primaryColor
        tableViewCellLabel.font = theme.custom2Font
        tableView.backgroundColor = theme.backgroundColor
        // TODO: Sorun olusturur mu? kontrol et
        tableView.reloadData()
        logoImageView.tintColor = theme.tertiaryColor
        tableView.separatorColor = theme.tertiaryColor
    }
}
