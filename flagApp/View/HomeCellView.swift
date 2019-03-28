//
//  HomeCellView.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class HomeCellView: UICollectionViewCell {
    
    public var homeController: HomeController!
    
    public var file: File! {
        didSet {
            setupCellValue()
        }
    }
    
    // MARK: -------------------------------------------------- ACTIVITY INDICATOR
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .gray)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.transform = CGAffineTransform(scaleX: value4, y: value4)
        return aiv
    }()
    
    // MARK: -------------------------------------------------- THUMBNAIL
    
    private let thumbnailView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        return iv
    }()
    
    private let thumbnailCenterView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var thumbnailCenterVisualEffectView: UIVisualEffectView = {
        let blurEffectView = UIVisualEffectView()
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = value3
        blurEffectView.clipsToBounds = true
        return blurEffectView
    }()
    
    private let thumbnailCenterViewIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // STATUS VIEW
    
    private let statusView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let statusViewVisualEffectView: UIVisualEffectView = {
        let blurEffectView = UIVisualEffectView()
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.clipsToBounds = true
        return blurEffectView
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // INFO VIEW
    
    private let infoView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let infoViewVisualEffectView: UIVisualEffectView = {
        let bev = UIVisualEffectView()
        bev.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bev.layer.cornerRadius = 10
        bev.clipsToBounds = true
        return bev
    }()
    
    private let infoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "info")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private var infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: -------------------------------------------------- TEXT
    
    private let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    // MARK: -------------------------------------------------- SHRINK EFFECT
    
    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
    
    private func shrink(down: Bool) {
        UIView.animate(withDuration: 0.3) {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                self.transform = .identity
            }
        }
    }
    
    // MARK: -------------------------------------------------- FUNCTION
    
    private var value1: CGFloat!
    private var value2: CGFloat!
    private var value3: CGFloat!
    private var value4: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if UIDevice.current.userInterfaceIdiom == .phone && !(UIScreen.main.bounds.width == 320.0 || UIScreen.main.bounds.height == 320.0){
            value1 = 35
            value2 = 25
            value3 = value1 / 2
            value4 = 0.8
        } else {
            value1 = 45
            value2 = 30
            value3 = value1 / 2
            value4 = 1.1
        }
        
        setupHomeCellView()
        setUpTheming()
    }
    
    private func setupHomeCellView() {
        // TODO: contentView'in farki ne ( self.addSubview / self.contentView.addSubview)
        self.contentView.addSubview(thumbnailView)
        
        self.addSubview(thumbnailCenterView)
        thumbnailCenterView.addSubview(thumbnailCenterVisualEffectView)
        thumbnailCenterView.addSubview(thumbnailCenterViewIcon)
        thumbnailCenterView.addSubview(activityIndicator)
        
        thumbnailView.addSubview(statusView)
        statusView.addSubview(statusViewVisualEffectView)
        statusView.addSubview(statusLabel)
        
        thumbnailView.addSubview(infoView)
        infoView.addSubview(infoViewVisualEffectView)
        infoView.addSubview(infoImageView)
        // TODO: buttona target ekledigimizde calismasi icin self'e addsubview demeliyiz neden?
        self.contentView.addSubview(infoButton)
        
        self.contentView.addSubview(label1)
        self.contentView.addSubview(label2)
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: self.topAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            thumbnailView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            thumbnailView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/16),
            
            thumbnailCenterView.centerXAnchor.constraint(equalTo: thumbnailView.centerXAnchor),
            thumbnailCenterView.centerYAnchor.constraint(equalTo: thumbnailView.centerYAnchor),
            thumbnailCenterView.widthAnchor.constraint(equalToConstant: value1),
            thumbnailCenterView.heightAnchor.constraint(equalTo: thumbnailCenterView.widthAnchor),
            
            thumbnailCenterViewIcon.centerXAnchor.constraint(equalTo: thumbnailCenterView.centerXAnchor),
            thumbnailCenterViewIcon.centerYAnchor.constraint(equalTo: thumbnailCenterView.centerYAnchor),
            thumbnailCenterViewIcon.widthAnchor.constraint(equalToConstant: value2),
            thumbnailCenterViewIcon.heightAnchor.constraint(equalTo: thumbnailCenterViewIcon.widthAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: thumbnailCenterView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: thumbnailCenterView.centerYAnchor),
            
            statusView.topAnchor.constraint(equalTo: thumbnailView.topAnchor, constant: 7),
            statusView.leadingAnchor.constraint(equalTo: thumbnailView.leadingAnchor, constant: 7),
            
            statusLabel.topAnchor.constraint(equalTo: statusView.topAnchor, constant: 5),
            statusLabel.bottomAnchor.constraint(equalTo: statusView.bottomAnchor, constant: -5),
            statusLabel.trailingAnchor.constraint(equalTo: statusView.trailingAnchor, constant: -7),
            statusLabel.leadingAnchor.constraint(equalTo: statusView.leadingAnchor, constant: 7),
            
            infoView.topAnchor.constraint(equalTo: thumbnailView.topAnchor, constant: 7),
            infoView.trailingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: -7),
            infoView.widthAnchor.constraint(equalToConstant: 25),
            infoView.heightAnchor.constraint(equalTo: infoView.widthAnchor),
            
            infoImageView.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            infoImageView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            infoImageView.widthAnchor.constraint(equalToConstant: 20),
            infoImageView.heightAnchor.constraint(equalTo: infoImageView.widthAnchor),
            
            infoButton.topAnchor.constraint(equalTo: self.topAnchor),
            infoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: 50),
            infoButton.heightAnchor.constraint(equalTo: infoButton.widthAnchor),
            
            label1.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 2),
            label1.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor),
            label2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label2.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            ])
    }
    
    private func setupCellValue() {
        if file.isReady {
            activityIndicator.stopAnimating()
            self.contentView.alpha = 1
            thumbnailCenterViewIcon.alpha = 1.0
            infoButton.isUserInteractionEnabled = true
        } else {
            activityIndicator.startAnimating()
            self.contentView.alpha = 0.5
            thumbnailCenterViewIcon.alpha = 0.0
            infoButton.isUserInteractionEnabled = false
        }
        
        label1.text = file.name
        
        if let thumbnail = file.thumbnail {
            thumbnailView.image = AppUtility.dataToImage(data: thumbnail)
        }

        if AppUtility.whichFileFormat(fileExtension: file.fileExtension!) != .SubRipSubtitleFormat {
            self.thumbnailCenterViewIcon.image = #imageLiteral(resourceName: "play")
            label2.text = file.video?.timeFormat
            if file.isNew {
                statusView.isHidden = false
                statusLabel.text = "NEW"
            } else if (file.video?.isDone)! {
                statusView.isHidden = false
                statusLabel.text = "DONE"
            } else {
                statusView.isHidden = false
                statusLabel.text = AppUtility.remainingTimeFormat(position: (file.video?.position)!, time: (file.video?.time)!, numberOfLines: 1)
            }
        } else {
            self.thumbnailCenterViewIcon.image = #imageLiteral(resourceName: "subtitle")
            self.label2.text = AppUtility.fileSizeFormat(size: file.size)
            // TODO: surekli statusView.isHidden = true yapiyorsam statusView.isHidden = false yapiyorum digerleri etkilenmesin diye dogru mu?
            if file.isNew {
                statusView.isHidden = false
                statusLabel.text = "NEW"
            } else {
                statusView.isHidden = true
            }
        }
        
        if AppUtility.whichFileFormat(fileExtension: file.fileExtension!) != .SubRipSubtitleFormat && file.typeName != "trash" {
            infoView.isHidden = false
            infoButton.isHidden = false
            infoButton.addTarget(self, action: #selector(handleInfoButton(sender:)), for: .touchDown)
        } else {
            // TODO: ishidden olunca isUserInteractionEnabled false oluyor mu
            infoButton.isHidden = true
            infoView.isHidden = true
        }
        
    }
    
    @objc private func handleInfoButton(sender: UIButton) {

        if UIDevice.current.userInterfaceIdiom == .phone {
            let phoneDetailViewController = PhoneDetailController(homeController: homeController, file: file)
            homeController.present(phoneDetailViewController, animated: true, completion: nil)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let detailViewController = DetailController(homeController: homeController, file: file)
            detailViewController.modalPresentationStyle = .overFullScreen
            homeController.present(detailViewController, animated: false, completion: nil)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeCellView: Themed {
    func applyTheme(_ theme: AppTheme) {
        thumbnailCenterVisualEffectView.effect = UIBlurEffect(style: theme.collectionViewCellBlurEffectStyle)
        statusViewVisualEffectView.effect = UIBlurEffect(style: theme.collectionViewCellBlurEffectStyle)
        infoViewVisualEffectView.effect = UIBlurEffect(style: theme.collectionViewCellBlurEffectStyle)
        activityIndicator.color = theme.activityIndicatorColor
        thumbnailCenterViewIcon.tintColor = theme.collectionViewCellColor
        statusLabel.textColor = theme.collectionViewCellColor
        statusLabel.font = theme.custom3Font
        infoImageView.tintColor = theme.collectionViewCellColor
        label1.textColor = theme.primaryColor
        label1.font = theme.paragraph1Font
        label2.textColor = theme.secondaryColor
        label2.font = theme.paragraph2Font
    }
}
