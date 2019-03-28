//
//  DetailViewController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.02.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class DetailController: UIViewController, UIGestureRecognizerDelegate {
    
    private var homeController: HomeController!
    public var file: File!
    public var detailView: UIView!
    private var detailViewNameLabel: UILabel!
    
    convenience init(homeController: HomeController, file: File) {
        self.init(nibName:nil, bundle:nil)
        
        self.homeController = homeController
        self.file = file
        
        if AppUtility.whichFileFormat(fileExtension: file.fileExtension!) != .SubRipSubtitleFormat {
            if file.typeName != "trash" {
                detailView = VideoDetailView()
            } else {
                detailView = TrashVideoDetailView()
            }
        } else {
            if file.typeName != "trash" {
                detailView = SubtitleDetailView()
            } else {
                detailView = TrashSubtitleDetailView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisualEffectView()
        setupDetailView()
        
        self.view.alpha = 0.0
        self.detailView.alpha = 0.0
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTap.delegate = self
        self.view.addGestureRecognizer(singleTap)
        
        setUpTheming()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 1.0
        }) { (_) in
            self.detailView.alpha = 1.0
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view != self.detailView {
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
    
    private func setupDetailView() {
        self.view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: self.view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            detailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            detailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
            ])
        setDetailViewValue()
    }
    
    func setDetailViewValue() {
        
        if let videoDetailView = detailView as? VideoDetailView {
            self.detailViewNameLabel = videoDetailView.label1
            videoDetailView.closeButton.addTarget(self, action: #selector(handleCloseTouchDown), for: .touchDown)
            videoDetailView.button1.addTarget(self, action: #selector(handlePlayResumeTouchDown), for: .touchDown)
            videoDetailView.button2.addTarget(self, action: #selector(handleSelectSubtitleTouchDown), for: .touchDown)
            videoDetailView.button3.addTarget(self, action: #selector(handleShareTouchDown), for: .touchDown)
            videoDetailView.button4.addTarget(self, action: #selector(handleRenameTouchDown), for: .touchDown)
            videoDetailView.button5.addTarget(self, action: #selector(handleTrashTouchDown), for: .touchDown)
            
            if let thumbnail = file.thumbnail {
                videoDetailView.thumbnailView.image = AppUtility.dataToImage(data: thumbnail)
            }
            
            videoDetailView.label1.text = file.name
            videoDetailView.label2.text = ".\(file.fileExtension!)"
            
            if file.isNew {
                videoDetailView.statusNewView.isHidden = false
                videoDetailView.statusRemainingView.isHidden = true
                videoDetailView.statusNewLabel.text = "NEW"
                videoDetailView.button1Label.text = "PLAY"
            } else if (file.video?.isDone)! {
                videoDetailView.statusNewView.isHidden = false
                videoDetailView.statusRemainingView.isHidden = true
                videoDetailView.statusNewLabel.text = "DONE"
                videoDetailView.button1Label.text = "PLAY"
            } else {
                videoDetailView.statusNewView.isHidden = true
                videoDetailView.statusRemainingView.isHidden = false
                videoDetailView.statusRemainingLabel.text = AppUtility.remainingTimeFormat(position: (file.video?.position)!, time: (file.video?.time)!, numberOfLines: 2)
                videoDetailView.button1Label.text = "RESUME"
            }
            //videoDetailView.button1.textAndImageButton()
            
            var attributeText: String = "\(file.video?.timeFormat ?? "Non")\n"
            attributeText += "\(AppUtility.fileSizeFormat(size: file.size))\n"
            attributeText += "\(file.video?.resolution ?? "Non")\n"
            attributeText += "\(file.video?.subtitle?.name ?? "Non")"
            videoDetailView.attributeLabel2.text = attributeText
            
        } else if let subtitleDetailView = detailView as? SubtitleDetailView {
            
            self.detailViewNameLabel = subtitleDetailView.label1
            subtitleDetailView.closeButton.addTarget(self, action: #selector(handleCloseTouchDown), for: .touchDown)
            subtitleDetailView.button3.addTarget(self, action: #selector(handleShareTouchDown), for: .touchDown)
            subtitleDetailView.button4.addTarget(self, action: #selector(handleRenameTouchDown), for: .touchDown)
            subtitleDetailView.button5.addTarget(self, action: #selector(handleTrashTouchDown), for: .touchDown)
            
            if let thumbnail = file.thumbnail {
                subtitleDetailView.thumbnailView.image = AppUtility.dataToImage(data: thumbnail)
            }
            
            subtitleDetailView.label1.text = file.name
            subtitleDetailView.label2.text = ".\(file.fileExtension!)"
            
            if file.isNew {
                subtitleDetailView.statusView.isHidden = false
                file.isNew = false
                CoreDataManager.shared.save = true
            } else {
                subtitleDetailView.statusView.isHidden = true
            }
            
            subtitleDetailView.attributeLabel2.text = "\(AppUtility.fileSizeFormat(size: file.size))\nWindowsCP1254"
            
        } else if let trashVideoDetailView = detailView as? TrashVideoDetailView {
            
            self.detailViewNameLabel = trashVideoDetailView.label1
            trashVideoDetailView.closeButton.addTarget(self, action: #selector(handleCloseTouchDown), for: .touchDown)
            trashVideoDetailView.button1.addTarget(self, action: #selector(handleRestoreTouchDown), for: .touchDown)
            trashVideoDetailView.button3.addTarget(self, action: #selector(handleShareTouchDown), for: .touchDown)
            trashVideoDetailView.button4.addTarget(self, action: #selector(handleRenameTouchDown), for: .touchDown)
            trashVideoDetailView.button5.addTarget(self, action: #selector(handleDeleteTouchDown), for: .touchDown)
            
            if let thumbnail = file.thumbnail {
                trashVideoDetailView.thumbnailView.image = AppUtility.dataToImage(data: thumbnail)
            }
            
            trashVideoDetailView.label1.text = file.name
            trashVideoDetailView.label2.text = ".\(file.fileExtension!)"
            
            if file.isNew {
                trashVideoDetailView.statusNewView.isHidden = false
                trashVideoDetailView.statusRemainingView.isHidden = true
                trashVideoDetailView.statusNewLabel.text = "NEW"
            } else if (file.video?.isDone)! {
                trashVideoDetailView.statusNewView.isHidden = false
                trashVideoDetailView.statusRemainingView.isHidden = true
                trashVideoDetailView.statusNewLabel.text = "DONE"
            } else {
                trashVideoDetailView.statusNewView.isHidden = true
                trashVideoDetailView.statusRemainingView.isHidden = false
                trashVideoDetailView.statusRemainingLabel.text = AppUtility.remainingTimeFormat(position: (file.video?.position)!, time: (file.video?.time)!, numberOfLines: 2)
            }
            //trashVideoDetailView.button1.textAndImageButton()
            
            var attributeText: String = "\(file.video?.timeFormat ?? "Non")\n"
            attributeText += "\(AppUtility.fileSizeFormat(size: file.size))\n"
            attributeText += "\(file.video?.resolution ?? "Non")\n"
            attributeText += "\(file.video?.subtitle?.name ?? "Non")"
            trashVideoDetailView.attributeLabel2.text = attributeText
            
        } else if let trashSubtitleDetailView = detailView as? TrashSubtitleDetailView {
            
            self.detailViewNameLabel = trashSubtitleDetailView.label1
            trashSubtitleDetailView.closeButton.addTarget(self, action: #selector(handleCloseTouchDown), for: .touchDown)
            trashSubtitleDetailView.button1.addTarget(self, action: #selector(handleRestoreTouchDown), for: .touchDown)
            trashSubtitleDetailView.button3.addTarget(self, action: #selector(handleShareTouchDown), for: .touchDown)
            trashSubtitleDetailView.button4.addTarget(self, action: #selector(handleRenameTouchDown), for: .touchDown)
            trashSubtitleDetailView.button5.addTarget(self, action: #selector(handleDeleteTouchDown), for: .touchDown)
            
            if let thumbnail = file.thumbnail {
                trashSubtitleDetailView.thumbnailView.image = AppUtility.dataToImage(data: thumbnail)
            }
            
            trashSubtitleDetailView.label1.text = file.name
            trashSubtitleDetailView.label2.text = ".\(file.fileExtension!)"
            
//            if file.isNew {
//                trashSubtitleDetailView.statusView.isHidden = false
//                file.isNew = false
//                CoreDataManager.shared.save = true
//            } else {
//                trashSubtitleDetailView.statusView.isHidden = true
//            }
            
            trashSubtitleDetailView.statusView.isHidden = true
            
            trashSubtitleDetailView.attributeLabel2.text = "\(AppUtility.fileSizeFormat(size: file.size))\nWindowsCP1254"
        }
        
    }
    
    @objc private func handleCloseTouchDown() {
        closeDetailController()
    }
    
    @objc private func handlePlayResumeTouchDown() {
        closeDetailController()
        homeController.openVideoPlayer(file: file)
    }
    
    @objc private func handleSelectSubtitleTouchDown() {
        if let videoDetailView = detailView as? VideoDetailView {
            videoDetailView.closeButton.isHidden = true
            let selectSubtitleController = SelectSubtitleController(detailController: self,
                                                                    width: videoDetailView.backgroundView.bounds.width,
                                                                    height: videoDetailView.backgroundView.bounds.height - videoDetailView.thumbnailView.bounds.height)
            selectSubtitleController.modalPresentationStyle = .overFullScreen
            present(selectSubtitleController, animated: true, completion: nil)
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
        closeDetailController()
    }
    
    @objc private func handleRestoreTouchDown() {
        if AppUtility.whichFileFormat(fileExtension: file.fileExtension!) != .SubRipSubtitleFormat {
            file.typeName = "video"
        } else {
            file.typeName = "subtitle"
        }
        CoreDataManager.shared.save = true
        closeDetailController()
    }
    
    @objc private func handleDeleteTouchDown() {
        do{
            try FileManager.default.removeItem(atPath: file.path!)
        } catch{
            print(error)
        }
        CoreDataManager.shared.save = true
        closeDetailController()
    }
    
    private func closeDetailController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSingleTap() {
        closeDetailController()
    }
    
    //TODO: self.file.name = text CoreDataManager.shared.save = true yaptigimizda nasil hemen update yapabiliyor?
    //TODO: Normalde hep CoreDataManager.shared.save = true bu sekilde kayit ediyoruz ama program kapatilirken save.context() diye kayit ediyoruz bu soruna neden olabilir mi?
    //TODO: addChild() self.view.removeFromSuperview() self.removeFromParent() ne zaman kullanilmalidir.
    
    func showAlertWithTextField() {
        let alertController = UIAlertController(title: "Rename File", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Rename", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                if !text.isEmpty {
                    self.file.name = text
                    self.detailViewNameLabel.text = text
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

extension DetailController: Themed {
    func applyTheme(_ theme: AppTheme) {
        visualEffectView.effect = UIBlurEffect(style: theme.blurEffectStyle)
    }
}
