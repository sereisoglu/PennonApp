//
//  PhoneDetailController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 6.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class PhoneDetailController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        let bounds = UIScreen.main.bounds
        if bounds.width > 800.0 || bounds.height > 800.0 {
            return false
        }
        return true
    }
    
    private var themedStatusBarStyle: UIStatusBarStyle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themedStatusBarStyle ?? super.preferredStatusBarStyle
    }
    
    public var file: File!
    private var homeController: HomeController!
    public var phoneDetailView: UIView!
    private var phoneDetailViewNameLabel: UILabel!
    
    convenience init(homeController: HomeController, file: File) {
        self.init(nibName:nil, bundle:nil)
        
        self.file = file
        self.homeController = homeController
        
        if AppUtility.whichFileFormat(fileExtension: file.fileExtension!) != .SubRipSubtitleFormat {
            if file.typeName != "trash" {
                phoneDetailView = PhoneVideoDetailView()
            } else {
                phoneDetailView = PhoneTrashVideoDetailView()
            }
        } else {
            if file.typeName != "trash" {
                phoneDetailView = PhoneSubtitleDetailView()
            } else {
                phoneDetailView = PhoneTrashSubtitleDetailView()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPhoneDetailView()
        setUpTheming()
    }
    
    private func setupPhoneDetailView() {
        self.view.addSubview(phoneDetailView)
        phoneDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneDetailView.topAnchor.constraint(equalTo: self.view.topAnchor),
            phoneDetailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            phoneDetailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            phoneDetailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
            ])
        setPhoneDetailViewValue()
    }
    
    public func setPhoneDetailViewValue() {
        if let phoneVideoDetailView = phoneDetailView as? PhoneVideoDetailView {
            self.phoneDetailViewNameLabel = phoneVideoDetailView.label1
            phoneVideoDetailView.closeButton.addTarget(self, action: #selector(handleCloseTouchDown), for: .touchDown)
            phoneVideoDetailView.button1.addTarget(self, action: #selector(handlePlayResumeTouchDown), for: .touchDown)
            phoneVideoDetailView.button2.addTarget(self, action: #selector(handleSelectSubtitleTouchDown), for: .touchDown)
            phoneVideoDetailView.button3.addTarget(self, action: #selector(handleShareTouchDown), for: .touchDown)
            phoneVideoDetailView.button4.addTarget(self, action: #selector(handleRenameTouchDown), for: .touchDown)
            phoneVideoDetailView.button5.addTarget(self, action: #selector(handleTrashTouchDown), for: .touchDown)
            
            if let thumbnail = file.thumbnail {
                phoneVideoDetailView.thumbnailView.image = AppUtility.dataToImage(data: thumbnail)
            }
            
            phoneVideoDetailView.label1.text = file.name
            phoneVideoDetailView.label2.text = ".\(file.fileExtension!)"
            
            if file.isNew {
                phoneVideoDetailView.statusNewView.isHidden = false
                phoneVideoDetailView.statusRemainingView.isHidden = true
                phoneVideoDetailView.statusNewLabel.text = "NEW"
                phoneVideoDetailView.button1Label.text = "PLAY"
            } else if (file.video?.isDone)! {
                phoneVideoDetailView.statusNewView.isHidden = false
                phoneVideoDetailView.statusRemainingView.isHidden = true
                phoneVideoDetailView.statusNewLabel.text = "DONE"
                phoneVideoDetailView.button1Label.text = "PLAY"
            } else {
                phoneVideoDetailView.statusNewView.isHidden = true
                phoneVideoDetailView.statusRemainingView.isHidden = false
                phoneVideoDetailView.statusRemainingLabel.text = AppUtility.remainingTimeFormat(position: (file.video?.position)!, time: (file.video?.time)!, numberOfLines: 2)
                phoneVideoDetailView.button1Label.text = "RESUME"
            }
            //videoDetailView.button1.textAndImageButton()
            
            var attributeText: String = "\(file.video?.timeFormat ?? "Non")\n"
            attributeText += "\(AppUtility.fileSizeFormat(size: file.size))\n"
            attributeText += "\(file.video?.resolution ?? "Non")\n"
            attributeText += "\(file.video?.subtitle?.name ?? "Non")"
            phoneVideoDetailView.attributeLabel2.text = attributeText
            
        } else if let phoneSubtitleDetailView = phoneDetailView as? PhoneSubtitleDetailView {
            
            self.phoneDetailViewNameLabel = phoneSubtitleDetailView.label1
            phoneSubtitleDetailView.closeButton.addTarget(self, action: #selector(handleCloseTouchDown), for: .touchDown)
            phoneSubtitleDetailView.button3.addTarget(self, action: #selector(handleShareTouchDown), for: .touchDown)
            phoneSubtitleDetailView.button4.addTarget(self, action: #selector(handleRenameTouchDown), for: .touchDown)
            phoneSubtitleDetailView.button5.addTarget(self, action: #selector(handleTrashTouchDown), for: .touchDown)
            
            if let thumbnail = file.thumbnail {
                phoneSubtitleDetailView.thumbnailView.image = AppUtility.dataToImage(data: thumbnail)
            }
            
            phoneSubtitleDetailView.label1.text = file.name
            phoneSubtitleDetailView.label2.text = ".\(file.fileExtension!)"
            
            if file.isNew {
                phoneSubtitleDetailView.statusView.isHidden = false
                file.isNew = false
                CoreDataManager.shared.save = true
            } else {
                phoneSubtitleDetailView.statusView.isHidden = true
            }
            
            phoneSubtitleDetailView.attributeLabel2.text = "\(AppUtility.fileSizeFormat(size: file.size))\nWinCP1254"
            
        } else if let phoneTrashVideoDetailView = phoneDetailView as? PhoneTrashVideoDetailView {
            
            self.phoneDetailViewNameLabel = phoneTrashVideoDetailView.label1
            phoneTrashVideoDetailView.closeButton.addTarget(self, action: #selector(handleCloseTouchDown), for: .touchDown)
            phoneTrashVideoDetailView.button1.addTarget(self, action: #selector(handleRestoreTouchDown), for: .touchDown)
            phoneTrashVideoDetailView.button3.addTarget(self, action: #selector(handleShareTouchDown), for: .touchDown)
            phoneTrashVideoDetailView.button4.addTarget(self, action: #selector(handleRenameTouchDown), for: .touchDown)
            phoneTrashVideoDetailView.button5.addTarget(self, action: #selector(handleDeleteTouchDown), for: .touchDown)
            
            if let thumbnail = file.thumbnail {
                phoneTrashVideoDetailView.thumbnailView.image = AppUtility.dataToImage(data: thumbnail)
            }
            
            phoneTrashVideoDetailView.label1.text = file.name
            phoneTrashVideoDetailView.label2.text = ".\(file.fileExtension!)"
            
            if file.isNew {
                phoneTrashVideoDetailView.statusNewView.isHidden = false
                phoneTrashVideoDetailView.statusRemainingView.isHidden = true
                phoneTrashVideoDetailView.statusNewLabel.text = "NEW"
            } else if (file.video?.isDone)! {
                phoneTrashVideoDetailView.statusNewView.isHidden = false
                phoneTrashVideoDetailView.statusRemainingView.isHidden = true
                phoneTrashVideoDetailView.statusNewLabel.text = "DONE"
            } else {
                phoneTrashVideoDetailView.statusNewView.isHidden = true
                phoneTrashVideoDetailView.statusRemainingView.isHidden = false
                phoneTrashVideoDetailView.statusRemainingLabel.text = AppUtility.remainingTimeFormat(position: (file.video?.position)!, time: (file.video?.time)!, numberOfLines: 2)
            }
            //trashVideoDetailView.button1.textAndImageButton()
            
            var attributeText: String = "\(file.video?.timeFormat ?? "Non")\n"
            attributeText += "\(AppUtility.fileSizeFormat(size: file.size))\n"
            attributeText += "\(file.video?.resolution ?? "Non")\n"
            attributeText += "\(file.video?.subtitle?.name ?? "Non")"
            phoneTrashVideoDetailView.attributeLabel2.text = attributeText
            
        } else if let phoneTrashSubtitleDetailView = phoneDetailView as? PhoneTrashSubtitleDetailView {
            
            self.phoneDetailViewNameLabel = phoneTrashSubtitleDetailView.label1
            phoneTrashSubtitleDetailView.closeButton.addTarget(self, action: #selector(handleCloseTouchDown), for: .touchDown)
            phoneTrashSubtitleDetailView.button1.addTarget(self, action: #selector(handleRestoreTouchDown), for: .touchDown)
            phoneTrashSubtitleDetailView.button3.addTarget(self, action: #selector(handleShareTouchDown), for: .touchDown)
            phoneTrashSubtitleDetailView.button4.addTarget(self, action: #selector(handleRenameTouchDown), for: .touchDown)
            phoneTrashSubtitleDetailView.button5.addTarget(self, action: #selector(handleDeleteTouchDown), for: .touchDown)
            
            if let thumbnail = file.thumbnail {
                phoneTrashSubtitleDetailView.thumbnailView.image = AppUtility.dataToImage(data: thumbnail)
            }
            
            phoneTrashSubtitleDetailView.label1.text = file.name
            phoneTrashSubtitleDetailView.label2.text = ".\(file.fileExtension!)"
            
            //            if file.isNew {
            //                trashSubtitleDetailView.statusView.isHidden = false
            //                file.isNew = false
            //                CoreDataManager.shared.save = true
            //            } else {
            //                trashSubtitleDetailView.statusView.isHidden = true
            //            }
            
            phoneTrashSubtitleDetailView.statusView.isHidden = true
            
            phoneTrashSubtitleDetailView.attributeLabel2.text = "\(AppUtility.fileSizeFormat(size: file.size))\nWinCP1254"
        }
    }
    
    @objc private func handleCloseTouchDown() {
        closePhoneDetailController()
    }
    
    @objc private func handlePlayResumeTouchDown() {
        closePhoneDetailController()
        homeController.openVideoPlayer(file: file)
    }
    
    @objc private func handleSelectSubtitleTouchDown() {
        if let phoneVideoDetailView = phoneDetailView as? PhoneVideoDetailView {
            phoneVideoDetailView.closeButton.isHidden = true
            let phoneSelectSubtitleController = PhoneSelectSubtitleController(phoneDetailController: self)
            phoneSelectSubtitleController.modalPresentationStyle = .overFullScreen
            present(phoneSelectSubtitleController, animated: true, completion: nil)
        }
    }
    
    @objc private func handleShareTouchDown(_ sender: UIButton) {
        let videoURL = URL(fileURLWithPath: file.path!)
        let activityController = UIActivityViewController(activityItems: [videoURL], applicationActivities: nil)
        activityController.modalPresentationStyle = .popover
        activityController.popoverPresentationController?.sourceView = sender
        activityController.popoverPresentationController?.sourceRect = sender.bounds
        self.present(activityController, animated: true, completion: nil)
    }
    
    @objc private func handleRenameTouchDown() {
        showAlertWithTextField()
    }
    
    @objc private func handleTrashTouchDown() {
        file.typeName = "trash"
        CoreDataManager.shared.save = true
        closePhoneDetailController()
    }
    
    @objc private func handleRestoreTouchDown() {
        if AppUtility.whichFileFormat(fileExtension: file.fileExtension!) != .SubRipSubtitleFormat {
            file.typeName = "video"
        } else {
            file.typeName = "subtitle"
        }
        CoreDataManager.shared.save = true
        closePhoneDetailController()
    }
    
    @objc private func handleDeleteTouchDown() {
        do{
            try FileManager.default.removeItem(atPath: file.path!)
        } catch{
            print(error)
        }
        CoreDataManager.shared.save = true
        closePhoneDetailController()
    }
    
    private func closePhoneDetailController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlertWithTextField() {
        let alertController = UIAlertController(title: "Rename File", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Rename", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                if !text.isEmpty {
                    self.file.name = text
                    self.phoneDetailViewNameLabel.text = text
                    CoreDataManager.shared.save = true
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = self.file.name
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}

extension PhoneDetailController: Themed {
    func applyTheme(_ theme: AppTheme) {
        themedStatusBarStyle = theme.statusBarStyle
        setNeedsStatusBarAppearanceUpdate()
    }
}
