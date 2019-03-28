//
//  VideoDetailView.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 24.02.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class VideoDetailView: UIView {
    
    // -------------------------------------------------- BACKGROUND
    
    private let shadowLayer: CAShapeLayer = {
        let sl = CAShapeLayer()
        sl.shadowOffset = CGSize(width: 0.0, height: 1.0)
        sl.shadowOpacity = 0.1
        sl.shadowRadius = 20
        return sl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowLayer.path = UIBezierPath(roundedRect: backgroundView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20.0, height: 0.0)).cgPath
    }
    
    public let backgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // -------------------------------------------------- THUMBNAIL
    
    public let thumbnailView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 20
        iv.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        iv.clipsToBounds = true
        return iv
    }()
    
    public let closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.5
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
        iv.image = #imageLiteral(resourceName: "play_bold")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    public let button1Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PLAY"
        return label
    }()
    
    // -------------------------------------------------- CENTER - ATTRIBUTES
    
    public lazy var attributeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [attributeLabel1, attributeLabel2])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 15
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
        let sv = UIStackView(arrangedSubviews: [button2, button3, button4, button5])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 15
        sv.distribution = .fillEqually
        return sv
    }()
    
    public let button2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    public let button2View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = false
        return view
    }()
    
    public let button2ImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "subtitle")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    public let button2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SELECT SUBTITLE"
        return label
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
        label.text = "MOVE TO TRASH"
        return label
    }()
    
    // --------------------------------------------------
    
    private var buttonHeight: CGFloat!
    private var viewWidth: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bounds = UIScreen.main.bounds
        viewWidth = bounds.width > bounds.height ? bounds.width / 2 : bounds.height / 2
        
        if bounds.width == 1366.0 || bounds.height == 1366.0 {
            buttonHeight = 75
        } else {
            buttonHeight = 60
        }
        
        backgroundView.layer.insertSublayer(shadowLayer, at: 0)
        setupDetailView()
        setUpTheming()
    }
    
    private func setupDetailView() {
        self.addSubview(backgroundView)
        
        backgroundView.addSubview(thumbnailView)
        self.addSubview(closeButton)
        
        closeButton.addSubview(closeVisualEffectView)
        closeButton.addSubview(closeImageView)
        
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
        
        button2.addSubview(button2View)
        button2View.addSubview(button2ImageView)
        button2View.addSubview(button2Label)
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
            backgroundView.topAnchor.constraint(equalTo: thumbnailView.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: viewWidth),
            
            thumbnailView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            thumbnailView.heightAnchor.constraint(equalToConstant: (viewWidth * 9) / 16),
            
            closeButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            
            closeImageView.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor),
            closeImageView.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            closeImageView.widthAnchor.constraint(equalToConstant: 15),
            closeImageView.heightAnchor.constraint(equalTo: closeImageView.widthAnchor),
            
            label1.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 15),
            label1.trailingAnchor.constraint(equalTo: statusView.leadingAnchor, constant: -20),
            label1.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 20),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor),
            label2.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 20),
            label2.bottomAnchor.constraint(equalTo: statusView.bottomAnchor),
            
            statusView.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 20),
            statusView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            statusView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.15),
            
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
            
            button1.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            button1.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            button1.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.25),
            button1.heightAnchor.constraint(equalToConstant: buttonHeight),
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
            
            attributeStackView.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20),
            attributeStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            attributeStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 20),
            
            button2View.centerXAnchor.constraint(equalTo: button2.centerXAnchor),
            button2View.centerYAnchor.constraint(equalTo: button2.centerYAnchor),
            button2ImageView.topAnchor.constraint(equalTo: button2View.topAnchor),
            button2ImageView.widthAnchor.constraint(equalToConstant: 35),
            button2ImageView.heightAnchor.constraint(equalTo: button2ImageView.widthAnchor),
            button2ImageView.centerXAnchor.constraint(equalTo: button2View.centerXAnchor),
            button2Label.topAnchor.constraint(equalTo: button2ImageView.bottomAnchor),
            button2Label.bottomAnchor.constraint(equalTo: button2View.bottomAnchor),
            button2Label.trailingAnchor.constraint(equalTo: button2View.trailingAnchor),
            button2Label.leadingAnchor.constraint(equalTo: button2View.leadingAnchor),
            button2Label.centerXAnchor.constraint(equalTo: button2View.centerXAnchor),
            
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
            button5Label.centerXAnchor.constraint(equalTo: button5View.centerXAnchor),
            
            buttonStackView.topAnchor.constraint(equalTo: attributeStackView.bottomAnchor, constant: 20),
            buttonStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20),
            buttonStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            buttonStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 20),
            buttonStackView.heightAnchor.constraint(equalToConstant: buttonHeight)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension VideoDetailView: Themed {
    func applyTheme(_ theme: AppTheme) {
        closeVisualEffectView.effect = UIBlurEffect(style: theme.blurEffectStyle)
        shadowLayer.fillColor = theme.backgroundColor.cgColor
        shadowLayer.shadowColor = theme.shadowColor.cgColor
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
        button2ImageView.tintColor = theme.primaryColor
        button2Label.textColor = theme.primaryColor
        button2Label.font = theme.overflowFont
        button2.backgroundColor = theme.buttonBackgroundColor
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
        button5Label.font = theme.overflowFont
        button5.backgroundColor = theme.buttonBackgroundColor
    }
}
