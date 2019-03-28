//
//  TrashSubtitleDetailView.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 28.02.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class TrashSubtitleDetailView: UIView {
    
    private var buttonHeight: CGFloat!
    
    private let shadowLayer: CAShapeLayer = {
        let sl = CAShapeLayer()
        sl.shadowOffset = CGSize(width: 0.0, height: 1.0)
        sl.shadowOpacity = 0.1
        sl.shadowRadius = 20
        return sl
    }()
    
    private var viewWidth: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bounds = UIScreen.main.bounds
        viewWidth = bounds.width > bounds.height ? bounds.width / 2 : bounds.height / 2
        
        if bounds.width == 1366.0 || bounds.height == 1366.0 {
            buttonHeight = 75
        } else {
            buttonHeight = 70
        }
        backgroundView.layer.insertSublayer(shadowLayer, at: 0)
        setupDetailView()
        setUpTheming()
    }
    
    // -------------------------------------------------- BACKGROUND
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowLayer.path = UIBezierPath(roundedRect: backgroundView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20.0, height: 0.0)).cgPath
    }
    
    private let backgroundView: UIView = {
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
        iv.image = UIColor.init(white: 0, alpha: 0.2).image()
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
        iv.tintColor = UIColor.init(white: 0, alpha: 0.8)
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
    
    private let statusNewView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
        v.layer.cornerRadius = 30
        v.clipsToBounds = true
        return v
    }()
    
    private let statusNewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NEW"
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
    
    private lazy var attributeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [attributeLabel1, attributeLabel2])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 15
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let attributeLabel1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Size:\nEncoding:"
        label.textAlignment = .right
        return label
    }()
    
    public let attributeLabel2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // -------------------------------------------------- BOTTOM
    
    public lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [button3, button4, button5])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 30
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
        
        backgroundView.addSubview(button1)
        button1.addSubview(button1View)
        button1View.addSubview(button1ImageView)
        button1View.addSubview(button1Label)
        
        backgroundView.addSubview(attributeStackView)
        backgroundView.addSubview(buttonStackView)
        
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

extension TrashSubtitleDetailView: Themed {
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
        button5Label.font = theme.overflowFont
        button5.backgroundColor = theme.buttonBackgroundColor
    }
}
