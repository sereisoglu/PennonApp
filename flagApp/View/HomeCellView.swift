//
//  HomeCellView.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class HomeCellView: UICollectionViewCell {
    
    var homeController: HomeController!
    
    var fileUrl: URL!
    var fileName: String!
    var folderName: String!
    var fileExtension: String!
    var fileSize: String!
    var thumbnail: UIImage?
    var videoDuration: String?
    var videoResolution: String?
    
    static let cornerRadius: CGFloat = 5
    static let scenterViewSize: CGFloat = 40
    let centerViewSize: CGFloat = 40
    let centerViewIconSize: CGFloat = 30
    let popupSizeWidth: CGFloat = 200
    let videoRatio: CGFloat = 9/16
    let popupLabelHeight: CGFloat = 25
    
    func setCell(fileUrl: URL,
                 fileName: String,
                 folderName: String,
                 fileExtension: String,
                 fileSize: String,
                 isNew: Bool = true,
                 thumbnail: UIImage = UIColor.init(white: 0, alpha: 0.2).image(),
                 videoDuration: String = "",
                 videoResolution: String = "",
                 videoRemainingDuration: String = ""
        ) {
        
        self.fileUrl = fileUrl
        self.fileName = fileName
        self.folderName = folderName
        self.fileExtension = fileExtension
        self.fileSize = fileSize
        self.thumbnail = thumbnail
        self.videoDuration = videoDuration
        self.videoResolution = videoResolution
        
        self.fileUrl = fileUrl
        self.thumbnailView.image = thumbnail
        self.label1.text = fileName
        
        if fileExtension != "srt" {
            self.thumbnailCenterViewIcon.image = #imageLiteral(resourceName: "play-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            self.label2.text = videoDuration
            self.rightCrossLabel.text = isNew ? "NEW" : videoRemainingDuration
            self.rightCrossView.isHidden = false
            self.rightCrossBlurEffectView.isHidden = false
            self.rightCrossLabel.isHidden = false
        } else {
            self.thumbnailCenterViewIcon.image = #imageLiteral(resourceName: "subtitle-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            self.label2.text = fileSize
            self.rightCrossView.isHidden = true
            self.rightCrossBlurEffectView.isHidden = true
            self.rightCrossLabel.isHidden = true
        }
    }
    
    let thumbnailView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = cornerRadius
        iv.clipsToBounds = true
        return iv
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor.init(white: 0, alpha: 0.8)
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.init(white: 0, alpha: 0.4)
        label.textAlignment = .center
        return label
    }()
    
    let rightCrossView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let rightCrossBlurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = cornerRadius
        blurEffectView.clipsToBounds = true
        return blurEffectView
    }()
    
    let rightCrossLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 8)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let thumbnailCenterView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let thumbnailCenterViewBlurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = scenterViewSize / 2
        blurEffectView.clipsToBounds = true
        return blurEffectView
    }()
    
    let thumbnailCenterViewIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        iv.tintColor = .white
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCellView()

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        self.addGestureRecognizer(longPress)
    }
    
    func setupCellView() {
        self.addSubview(thumbnailView)
        thumbnailView.addSubview(thumbnailCenterView)
        self.addSubview(rightCrossView)
        rightCrossView.addSubview(rightCrossBlurEffectView)
        thumbnailCenterView.addSubview(thumbnailCenterViewBlurEffectView)
        thumbnailCenterView.addSubview(thumbnailCenterViewIcon)
        self.addSubview(label1)
        self.addSubview(label2)
        self.addSubview(rightCrossLabel)
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: self.topAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            thumbnailView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            thumbnailView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: videoRatio),
            
            thumbnailCenterView.centerXAnchor.constraint(equalTo: thumbnailView.centerXAnchor),
            thumbnailCenterView.centerYAnchor.constraint(equalTo: thumbnailView.centerYAnchor),
            thumbnailCenterView.heightAnchor.constraint(equalToConstant: centerViewSize),
            thumbnailCenterView.widthAnchor.constraint(equalToConstant: centerViewSize),
            
            thumbnailCenterViewIcon.centerXAnchor.constraint(equalTo: thumbnailCenterView.centerXAnchor),
            thumbnailCenterViewIcon.centerYAnchor.constraint(equalTo: thumbnailCenterView.centerYAnchor),
            thumbnailCenterViewIcon.heightAnchor.constraint(equalToConstant: centerViewIconSize),
            thumbnailCenterViewIcon.widthAnchor.constraint(equalToConstant: centerViewIconSize),
            
            label1.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 2),
            label1.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label1.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 2),
            label2.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            rightCrossLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            rightCrossLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7),
            
            rightCrossView.centerXAnchor.constraint(equalTo: rightCrossLabel.centerXAnchor),
            rightCrossView.centerYAnchor.constraint(equalTo: rightCrossLabel.centerYAnchor),
            rightCrossView.heightAnchor.constraint(equalTo: rightCrossLabel.heightAnchor, constant: 7),
            rightCrossView.widthAnchor.constraint(equalTo: rightCrossLabel.widthAnchor, constant: 7)
            ])
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            if #available(iOS 10.0, *) {
                let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                lightImpactFeedbackGenerator.prepare()
                lightImpactFeedbackGenerator.impactOccurred()
            }
            
            if fileExtension != "srt" {
                homeController.setupPopupController(fileUrl: self.fileUrl,
                                                        fileName: self.fileName,
                                                        folderName: self.folderName,
                                                        fileExtension: self.fileExtension,
                                                        fileSize: self.fileSize,
                                                        thumbnail: self.thumbnail!,
                                                        videoDuration: self.videoDuration!,
                                                        videoResolution: self.videoResolution!)
            } else {
                homeController.setupPopupController(fileUrl: self.fileUrl,
                                                        fileName: self.fileName,
                                                        folderName: self.folderName,
                                                        fileExtension: self.fileExtension,
                                                        fileSize: self.fileSize)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
