//
//  PopupController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class PopupController: UIViewController{
    
    var homeController: HomeController!
    var fileUrl: URL!
    
    static let cornerRadius: CGFloat = 5
    static let scenterViewSize: CGFloat = 40
    let centerViewSize: CGFloat = 40
    let centerViewIconSize: CGFloat = 30
    let popupSizeWidth: CGFloat = 200
    let videoRatio: CGFloat = 9/16
    let popupLabelHeight: CGFloat = 25
    
    convenience init(homeController: HomeController,
                     fileUrl: URL,
                     fileName: String,
                     folderName: String,
                     fileExtension: String,
                     fileSize: String,
                     thumbnail: UIImage = UIColor.init(white: 0, alpha: 0.2).image(),
                     videoDuration: String = "",
                     videoResolution: String = "") {
        self.init(nibName:nil, bundle:nil)
        
        self.homeController = homeController
        self.fileUrl = fileUrl
        self.popupThumbnailView.image = thumbnail
        self.textField.placeholder = fileName
        self.popupLabel1.text = ".\(fileExtension)"
        
        if fileExtension != "srt" {
            self.popupThumbnailCenterViewIcon.image = #imageLiteral(resourceName: "play-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            self.popupLabel2.text = videoDuration
            self.popupLabel3.text = fileSize
            self.popupLabel4.text = videoResolution
        } else {
            self.popupThumbnailCenterViewIcon.image = #imageLiteral(resourceName: "subtitle-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            self.popupLabel2.text = fileSize
        }
        
        if folderName != "Trash" {
            popupLeftButton.setTitle("Move to Trash", for: .normal)
            popupRightButton.setTitle("Rename", for: .normal)
            textField.isEnabled = true
            textField.isUserInteractionEnabled = true
        } else {
            popupLeftButton.setTitle("Delete", for: .normal)
            popupRightButton.setTitle("Put Back", for: .normal)
            textField.isEnabled = false
            textField.isUserInteractionEnabled = false
        }
        
    }
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let popupGeneralView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var popupThumbnailView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = cornerRadius
        iv.clipsToBounds = true
        return iv
    }()
    
    let popupThumbnailCenterView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let popupThumbnailCenterViewBlurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = scenterViewSize / 2
        blurEffectView.clipsToBounds = true
        return blurEffectView
    }()
    
    let popupThumbnailCenterViewIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .white
        return iv
    }()
    
    let popupCenterView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.init(white: 0, alpha: 0.05)
        v.layer.cornerRadius = cornerRadius
        v.clipsToBounds = true
        return v
    }()
    
    let popupBottomView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = cornerRadius
        v.clipsToBounds = true
        return v
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.backgroundColor = UIColor.clear
        tf.layer.cornerRadius = cornerRadius
        tf.borderStyle = .roundedRect
        tf.font = UIFont.boldSystemFont(ofSize: 12)
        tf.clipsToBounds = true
        return tf
    }()
    
    let popupLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let popupLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let popupLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let popupLabel4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let popupLeftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
        return button
    }()
    
    let popupRightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundVisualEffectView()
        setupPopupView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.view.addGestureRecognizer(tap)
        
        popupLeftButton.addTarget(self, action: #selector(popupLeftButtonAction), for: .touchUpInside)
        popupRightButton.addTarget(self, action: #selector(popupRightButtonAction), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupBackgroundVisualEffectView() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.view.backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(blurEffectView)
        } else {
            self.view.backgroundColor = .white
        }
    }
    
    func setupPopupView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(popupGeneralView)
        
        popupGeneralView.addSubview(popupThumbnailView)
        popupThumbnailView.addSubview(popupThumbnailCenterView)
        popupThumbnailCenterView.addSubview(popupThumbnailCenterViewBlurEffectView)
        popupThumbnailCenterView.addSubview(popupThumbnailCenterViewIcon)
        popupGeneralView.addSubview(popupCenterView)
        popupGeneralView.addSubview(popupBottomView)
        
        popupCenterView.addSubview(textField)
        popupCenterView.addSubview(popupLabel1)
        popupCenterView.addSubview(popupLabel3)
        popupCenterView.addSubview(popupLabel4)
        popupCenterView.addSubview(popupLabel2)
        
        popupBottomView.addSubview(popupLeftButton)
        popupBottomView.addSubview(popupRightButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            popupGeneralView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            popupGeneralView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            popupGeneralView.topAnchor.constraint(equalTo: popupThumbnailView.topAnchor),
            popupGeneralView.bottomAnchor.constraint(equalTo: popupBottomView.bottomAnchor),
            popupGeneralView.widthAnchor.constraint(equalToConstant: popupSizeWidth),
            
            popupThumbnailView.widthAnchor.constraint(equalTo: popupGeneralView.widthAnchor),
            popupThumbnailView.heightAnchor.constraint(equalToConstant: popupSizeWidth * videoRatio),
            popupThumbnailView.bottomAnchor.constraint(equalTo: popupCenterView.topAnchor, constant: -15),
            
            popupThumbnailCenterView.centerXAnchor.constraint(equalTo: popupThumbnailView.centerXAnchor),
            popupThumbnailCenterView.centerYAnchor.constraint(equalTo: popupThumbnailView.centerYAnchor),
            popupThumbnailCenterView.heightAnchor.constraint(equalToConstant: centerViewSize),
            popupThumbnailCenterView.widthAnchor.constraint(equalToConstant: centerViewSize),
            
            popupThumbnailCenterViewIcon.centerXAnchor.constraint(equalTo: popupThumbnailCenterView.centerXAnchor),
            popupThumbnailCenterViewIcon.centerYAnchor.constraint(equalTo: popupThumbnailCenterView.centerYAnchor),
            popupThumbnailCenterViewIcon.heightAnchor.constraint(equalToConstant: centerViewIconSize),
            popupThumbnailCenterViewIcon.widthAnchor.constraint(equalToConstant: centerViewIconSize),
            
            popupCenterView.widthAnchor.constraint(equalTo: popupGeneralView.widthAnchor),
            
            textField.topAnchor.constraint(equalTo: popupCenterView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: popupCenterView.leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: popupLabelHeight),
            
            popupLabel1.topAnchor.constraint(equalTo: popupCenterView.topAnchor),
            popupLabel1.trailingAnchor.constraint(equalTo: popupCenterView.trailingAnchor),
            popupLabel1.leadingAnchor.constraint(equalTo: textField.trailingAnchor),
            popupLabel1.heightAnchor.constraint(equalToConstant: popupLabelHeight),
            popupLabel1.widthAnchor.constraint(equalToConstant: 40),
            
            popupLabel2.centerXAnchor.constraint(equalTo: popupCenterView.centerXAnchor),
            popupLabel2.topAnchor.constraint(equalTo: textField.bottomAnchor),
            popupLabel2.heightAnchor.constraint(equalToConstant: popupLabelHeight),
            
            popupLabel3.centerXAnchor.constraint(equalTo: popupCenterView.centerXAnchor),
            popupLabel3.topAnchor.constraint(equalTo: popupLabel2.bottomAnchor),
            popupLabel3.heightAnchor.constraint(equalToConstant: popupLabelHeight),
            
            popupLabel4.centerXAnchor.constraint(equalTo: popupCenterView.centerXAnchor),
            popupLabel4.topAnchor.constraint(equalTo: popupLabel3.bottomAnchor),
            popupLabel4.heightAnchor.constraint(equalToConstant: popupLabelHeight),
            
            popupBottomView.topAnchor.constraint(equalTo: popupCenterView.bottomAnchor, constant: 15),
            popupBottomView.widthAnchor.constraint(equalTo: popupGeneralView.widthAnchor),
            popupBottomView.heightAnchor.constraint(equalToConstant: popupLabelHeight),
            
            popupLeftButton.topAnchor.constraint(equalTo: popupBottomView.topAnchor),
            popupLeftButton.bottomAnchor.constraint(equalTo: popupBottomView.bottomAnchor),
            popupLeftButton.leadingAnchor.constraint(equalTo: popupBottomView.leadingAnchor),
            popupLeftButton.trailingAnchor.constraint(equalTo: popupRightButton.leadingAnchor, constant: -10),
            
            popupRightButton.topAnchor.constraint(equalTo: popupBottomView.topAnchor),
            popupRightButton.bottomAnchor.constraint(equalTo: popupBottomView.bottomAnchor),
            popupRightButton.trailingAnchor.constraint(equalTo: popupBottomView.trailingAnchor),
            popupRightButton.leadingAnchor.constraint(equalTo: popupLeftButton.trailingAnchor, constant: 10),
            
            popupLeftButton.widthAnchor.constraint(equalTo: popupRightButton.widthAnchor)
            ])
        
        if fileUrl.pathExtension != "srt" {
            popupCenterView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        } else {
            popupCenterView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            selfClose()
        }
    }
    
    @objc func popupLeftButtonAction() {
        if popupLeftButton.title(for: .normal) != "Delete" {
            ControlData.shared.updateFile(url: fileUrl, newValue: "Trash", forKey: "folderName")
        } else {
            do{
                try FileManager.default.removeItem(at: fileUrl)
            } catch{
                print(error)
            }
            ControlData.shared.controlData()
        }
        
        self.homeController.numberOfItemsInSection -= 1
        selfClose()
        DispatchQueue.main.async {
            self.homeController.collectionView.reloadData()
        }
    }
    
    @objc func popupRightButtonAction() {
        if popupRightButton.title(for: .normal) == "Rename" && textField.text! != "" {
            ControlData.shared.updateFile(url: fileUrl, newValue: textField.text!, forKey: "fileName")
        } else {
            if fileUrl.pathExtension != "srt" {
                ControlData.shared.updateFile(url: fileUrl, newValue: "Videos", forKey: "folderName")
            } else {
                ControlData.shared.updateFile(url: fileUrl, newValue: "Subtitles", forKey: "folderName")
            }
            self.homeController.numberOfItemsInSection -= 1
        }
        
        selfClose()
        DispatchQueue.main.async {
            self.homeController.collectionView.reloadData()
        }
    }
    
    @objc func keyboardWillAppear(notification: NSNotification) {
        var keyboardHeight: CGFloat = 125.0
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        scrollView.setContentOffset(CGPoint(x: 0, y: keyboardHeight / 2), animated: true)
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + keyboardHeight / 2 + 35)
    }
    
    @objc func keyboardWillDisappear() {
    }
    
    func selfClose() {
        homeController.closePopupController()
    }

}
