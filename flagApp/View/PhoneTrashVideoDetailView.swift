//
//  PhoneTrashVideoDetailView.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 7.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class PhoneTrashVideoDetailView: UIView {
    
    // -------------------------------------------------- BACKGROUND
    
    public let backgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // -------------------------------------------------- THUMBNAIL
    
    public let thumbnailView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    public let closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.5
        // TODO: clipsToBounds = true yapmasakda radius oluyor neden?
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let closeVisualEffectView: UIVisualEffectView = {
        let blurEffectView = UIVisualEffectView()
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 12.5
        blurEffectView.clipsToBounds = true
        blurEffectView.isUserInteractionEnabled = false
        return blurEffectView
    }()
    
    private let closeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "close_bold")
        return iv
    }()
    
    // -------------------------------------------------- TOP
    
    public let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    public let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let statusView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    public let statusNewView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 30
        v.clipsToBounds = true
        return v
    }()
    
    public let statusNewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let statusRemainingView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    
    public let statusRemainingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    public let button1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    public let button1View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = false
        return view
    }()
    
    public let button1ImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "restore")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    public let button1Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RESTORE"
        return label
    }()
    
    // -------------------------------------------------- CENTER - ATTRIBUTES
    
    public lazy var attributeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [attributeLabel1, attributeLabel2])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 10
        sv.distribution = .fillEqually
        return sv
    }()
    
    public let attributeLabel1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Duration:\nSize:\nDimensions:\nSubtitle:"
        label.textAlignment = .right
        return label
    }()
    
    public let attributeLabel2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // -------------------------------------------------- BOTTOM
    
    public lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [button3, button4])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 15
        sv.distribution = .fillEqually
        return sv
    }()
    
    public lazy var buttonStackView2: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [button5])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 15
        sv.distribution = .fillEqually
        return sv
    }()
    
    public let button3: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    public let button3View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = false
        return view
    }()
    
    public let button3ImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "share")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    public let button3Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SHARE"
        return label
    }()
    
    public let button4: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    public let button4View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = false
        return view
    }()
    
    public let button4ImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "edit")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    public let button4Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RENAME"
        return label
    }()
    
    public let button5: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    public let button5View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = false
        return view
    }()
    
    public let button5ImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "trash")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    public let button5Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DELETE"
        return label
    }()
    
    // --------------------------------------------------
    
    //private var buttonHeight: CGFloat!
    private var padding: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        let bounds = UIScreen.main.bounds
        //        viewWidth = bounds.width > bounds.height ? bounds.width / 2 : bounds.height / 2
        //
        //        if bounds.width == 1366.0 || bounds.height == 1366.0 {
        //            buttonHeight = 75
        //        } else {
        //            buttonHeight = 60
        //        }
        
        padding = 15
        
        setupDetailView()
        setUpTheming()
    }
    
    private func setupDetailView() {
        
        self.addSubview(thumbnailView)
        // TODO: thumbnailView.addSubview(closeButton) yaparsak buton calismiyor neden
        self.addSubview(closeButton)
        closeButton.addSubview(closeVisualEffectView)
        closeButton.addSubview(closeImageView)
        
        self.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        
        backgroundView.addSubview(label1)
        backgroundView.addSubview(label2)
        
        backgroundView.addSubview(statusView)
        
        statusView.addSubview(statusNewView)
        statusNewView.addSubview(statusNewLabel)
        
        statusView.addSubview(statusRemainingView)
        statusRemainingView.addSubview(statusRemainingLabel)
        
        backgroundView.addSubview(button1)
        button1.addSubview(button1View)
        button1View.addSubview(button1ImageView)
        button1View.addSubview(button1Label)
        
        backgroundView.addSubview(attributeStackView)
        backgroundView.addSubview(buttonStackView)
        backgroundView.addSubview(buttonStackView2)
        
        button3.addSubview(button3View)
        button3View.addSubview(button3ImageView)
        button3View.addSubview(button3Label)
        button4.addSubview(button4View)
        button4View.addSubview(button4ImageView)
        button4View.addSubview(button4Label)
        button5.addSubview(button5View)
        button5View.addSubview(button5ImageView)
        button5View.addSubview(button5Label)
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            thumbnailView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            thumbnailView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/16),
            
            closeButton.topAnchor.constraint(equalTo: thumbnailView.topAnchor, constant: padding),
            closeButton.trailingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: -padding),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            
            closeImageView.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor),
            closeImageView.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            closeImageView.widthAnchor.constraint(equalToConstant: 15),
            closeImageView.heightAnchor.constraint(equalTo: closeImageView.widthAnchor),
            
            scrollView.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            label1.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: padding - 5),
            label1.trailingAnchor.constraint(equalTo: statusView.leadingAnchor, constant: -padding),
            label1.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: padding),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor),
            label2.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: padding),
            label2.bottomAnchor.constraint(equalTo: statusView.bottomAnchor),
            
            statusView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: padding),
            statusView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -padding),
            statusView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.2),
            
            statusNewView.centerXAnchor.constraint(equalTo: statusView.centerXAnchor),
            statusNewView.centerYAnchor.constraint(equalTo: statusView.centerYAnchor),
            statusNewView.widthAnchor.constraint(equalToConstant: 60),
            statusNewView.heightAnchor.constraint(equalTo: statusNewView.widthAnchor),
            
            statusNewLabel.centerXAnchor.constraint(equalTo: statusNewView.centerXAnchor),
            statusNewLabel.centerYAnchor.constraint(equalTo: statusNewView.centerYAnchor),
            
            statusRemainingView.centerXAnchor.constraint(equalTo: statusView.centerXAnchor),
            statusRemainingView.centerYAnchor.constraint(equalTo: statusView.centerYAnchor),
            
            statusRemainingLabel.trailingAnchor.constraint(equalTo: statusRemainingView.trailingAnchor, constant: -5),
            statusRemainingLabel.leadingAnchor.constraint(equalTo: statusRemainingView.leadingAnchor, constant: 5),
            statusRemainingLabel.topAnchor.constraint(equalTo: statusRemainingView.topAnchor, constant: 5),
            statusRemainingLabel.bottomAnchor.constraint(equalTo: statusRemainingView.bottomAnchor, constant: -5),
            
            button1.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: padding),
            button1.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            button1.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.5),
            button1.heightAnchor.constraint(equalToConstant: 65),
            button1View.centerXAnchor.constraint(equalTo: button1.centerXAnchor),
            button1View.centerYAnchor.constraint(equalTo: button1.centerYAnchor),
            button1ImageView.topAnchor.constraint(equalTo: button1View.topAnchor),
            button1ImageView.widthAnchor.constraint(equalToConstant: 35),
            button1ImageView.heightAnchor.constraint(equalTo: button1ImageView.widthAnchor),
            button1ImageView.centerXAnchor.constraint(equalTo: button1View.centerXAnchor),
            button1Label.topAnchor.constraint(equalTo: button1ImageView.bottomAnchor),
            button1Label.bottomAnchor.constraint(equalTo: button1View.bottomAnchor),
            button1Label.trailingAnchor.constraint(equalTo: button1View.trailingAnchor),
            button1Label.leadingAnchor.constraint(equalTo: button1View.leadingAnchor),
            button1Label.centerXAnchor.constraint(equalTo: button1View.centerXAnchor),
            
            attributeStackView.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: padding),
            attributeStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -padding),
            attributeStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: padding),
            
            buttonStackView.topAnchor.constraint(equalTo: attributeStackView.bottomAnchor, constant: padding),
            buttonStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -padding),
            buttonStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: padding),
            buttonStackView.heightAnchor.constraint(equalToConstant: 65),
            
            buttonStackView2.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: padding),
            buttonStackView2.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -padding),
            buttonStackView2.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -padding),
            buttonStackView2.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: padding),
            buttonStackView2.heightAnchor.constraint(equalToConstant: 65),
            
            button3View.centerXAnchor.constraint(equalTo: button3.centerXAnchor),
            button3View.centerYAnchor.constraint(equalTo: button3.centerYAnchor),
            button3ImageView.topAnchor.constraint(equalTo: button3View.topAnchor),
            button3ImageView.widthAnchor.constraint(equalToConstant: 35),
            button3ImageView.heightAnchor.constraint(equalTo: button3ImageView.widthAnchor),
            button3ImageView.centerXAnchor.constraint(equalTo: button3View.centerXAnchor),
            button3Label.topAnchor.constraint(equalTo: button3ImageView.bottomAnchor),
            button3Label.bottomAnchor.constraint(equalTo: button3View.bottomAnchor),
            button3Label.trailingAnchor.constraint(equalTo: button3View.trailingAnchor),
            button3Label.leadingAnchor.constraint(equalTo: button3View.leadingAnchor),
            button3Label.centerXAnchor.constraint(equalTo: button3View.centerXAnchor),
            
            button4View.centerXAnchor.constraint(equalTo: button4.centerXAnchor),
            button4View.centerYAnchor.constraint(equalTo: button4.centerYAnchor),
            button4ImageView.topAnchor.constraint(equalTo: button4View.topAnchor),
            button4ImageView.widthAnchor.constraint(equalToConstant: 35),
            button4ImageView.heightAnchor.constraint(equalTo: button4ImageView.widthAnchor),
            button4ImageView.centerXAnchor.constraint(equalTo: button4View.centerXAnchor),
            button4Label.topAnchor.constraint(equalTo: button4ImageView.bottomAnchor),
            button4Label.bottomAnchor.constraint(equalTo: button4View.bottomAnchor),
            button4Label.trailingAnchor.constraint(equalTo: button4View.trailingAnchor),
            button4Label.leadingAnchor.constraint(equalTo: button4View.leadingAnchor),
            button4Label.centerXAnchor.constraint(equalTo: button4View.centerXAnchor),
            
            button5View.centerXAnchor.constraint(equalTo: button5.centerXAnchor),
            button5View.centerYAnchor.constraint(equalTo: button5.centerYAnchor),
            button5ImageView.topAnchor.constraint(equalTo: button5View.topAnchor),
            button5ImageView.widthAnchor.constraint(equalToConstant: 35),
            button5ImageView.heightAnchor.constraint(equalTo: button5ImageView.widthAnchor),
            button5ImageView.centerXAnchor.constraint(equalTo: button5View.centerXAnchor),
            button5Label.topAnchor.constraint(equalTo: button5ImageView.bottomAnchor),
            button5Label.bottomAnchor.constraint(equalTo: button5View.bottomAnchor),
            button5Label.trailingAnchor.constraint(equalTo: button5View.trailingAnchor),
            button5Label.leadingAnchor.constraint(equalTo: button5View.leadingAnchor),
            button5Label.centerXAnchor.constraint(equalTo: button5View.centerXAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhoneTrashVideoDetailView: Themed {
    func applyTheme(_ theme: AppTheme) {
        self.backgroundColor = theme.backgroundColor
        closeVisualEffectView.effect = UIBlurEffect(style: theme.blurEffectStyle)
        thumbnailView.image = theme.tertiaryColor.image()
        closeImageView.tintColor = theme.primaryColor
        label1.textColor = theme.primaryColor
        label1.font = theme.header1Font
        label2.textColor = theme.secondaryColor
        label2.font = theme.header2Font
        statusNewView.backgroundColor = theme.buttonBackgroundColor
        statusNewLabel.textColor = theme.primaryColor
        statusNewLabel.font = theme.paragraph1Font
        statusRemainingView.backgroundColor = theme.buttonBackgroundColor
        statusRemainingLabel.textColor = theme.primaryColor
        statusRemainingLabel.font = theme.paragraph1Font
        button1ImageView.tintColor = theme.primaryColor
        button1Label.textColor = theme.primaryColor
        button1Label.font = theme.paragraph1Font
        button1.backgroundColor = theme.buttonBackgroundColor
        attributeLabel1.textColor = theme.secondaryColor
        attributeLabel1.font = theme.header2Font
        attributeLabel2.textColor = theme.secondaryColor
        attributeLabel2.font = theme.header2Font
        button3ImageView.tintColor = theme.primaryColor
        button3Label.textColor = theme.primaryColor
        button3Label.font = theme.paragraph1Font
        button3.backgroundColor = theme.buttonBackgroundColor
        button4ImageView.tintColor = theme.primaryColor
        button4Label.textColor = theme.primaryColor
        button4Label.font = theme.paragraph1Font
        button4.backgroundColor = theme.buttonBackgroundColor
        button5ImageView.tintColor = theme.primaryColor
        button5Label.textColor = theme.primaryColor
        button5Label.font = theme.paragraph1Font
        button5.backgroundColor = theme.buttonBackgroundColor
    }
}
