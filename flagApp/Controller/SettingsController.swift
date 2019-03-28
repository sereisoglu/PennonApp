//
//  SettingsController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 4.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

struct SettingsModel {
    //var icon: UIImage
    var title: String
}

class SettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    private var tableViewData = [SettingsModel]()

    private let shadowLayer: CAShapeLayer = {
        let sl = CAShapeLayer()
        sl.shadowOffset = CGSize(width: 0.0, height: 1.0)
        sl.shadowOpacity = 0.1
        sl.shadowRadius = 20
        return sl
    }()
    
    private var viewWidth: CGFloat!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        shadowLayer.path = UIBezierPath(roundedRect: generalView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20.0, height: 0.0)).cgPath
    }
    
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
        
        setupVisualEffectView()
        
        let bounds = UIScreen.main.bounds
        viewWidth = bounds.width > bounds.height ? bounds.width / 2 : bounds.height / 2
        
        generalView.layer.insertSublayer(shadowLayer, at: 0)
        
        setupView()
        
        closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchDown)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTap.delegate = self
        self.view.addGestureRecognizer(singleTap)
        
        setUpTheming()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view != self.view {
            return false
        }
        return true
    }
    
    private lazy var visualEffectView: UIVisualEffectView = {
        let blurEffectView = UIVisualEffectView()
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = self.view.bounds
        blurEffectView.isUserInteractionEnabled = false
        return blurEffectView
    }()
    
    private func setupVisualEffectView() {
        self.view.backgroundColor = .clear
        self.view.addSubview(visualEffectView)
    }
    
    @objc func handleSingleTap() {
        closeSettingsController()
    }
    
    private func setupView() {
        self.view.addSubview(generalView)
        generalView.addSubview(label1)
        generalView.addSubview(closeButton)
        closeButton.addSubview(closeImageView)
        generalView.addSubview(tableView)
        generalView.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            generalView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            generalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            generalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            generalView.widthAnchor.constraint(equalToConstant: viewWidth),
            
            label1.topAnchor.constraint(equalTo: generalView.topAnchor, constant: 15),
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
        closeSettingsController()
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
            openThemeController()
        } else if indexPath.row == 1 {
            openTutorialController()
        } else if indexPath.row == 2 {
            openAboutController()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    public func openThemeController() {
        let themeController = ThemeController()
        themeController.modalPresentationStyle = .overFullScreen
        present(themeController, animated: true, completion: nil)
    }
    
    public func openTutorialController() {
        let tutorialController = TutorialController()
        tutorialController.modalPresentationStyle = .overFullScreen
        present(tutorialController, animated: true, completion: nil)
    }
    
    public func openAboutController() {
        let aboutController = AboutController()
        aboutController.modalPresentationStyle = .overFullScreen
        present(aboutController, animated: true, completion: nil)
    }
    
    private func closeSettingsController() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension SettingsController: Themed {
    func applyTheme(_ theme: AppTheme) {
        visualEffectView.effect = UIBlurEffect(style: theme.blurEffectStyle)
        shadowLayer.fillColor = theme.backgroundColor.cgColor
        shadowLayer.shadowColor = theme.shadowColor.cgColor
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
