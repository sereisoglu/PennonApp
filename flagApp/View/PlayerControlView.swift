//
//  PlayerControl.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on value5.02.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class PlayerControlView: UIView {
    
    // -------------------------------------------------- BACKGROUND
    
    public let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let blackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.2
        return view
    }()
    
    private let topGradientLayer: CAGradientLayer = {
        let gl = CAGradientLayer()
        gl.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gl.startPoint = CGPoint(x: 0.5, y: 1.0)
        gl.endPoint = CGPoint(x: 0.5, y: 0.0)
        gl.locations = [0.5, 1]
        gl.opacity = 0.75
        return gl
    }()
    
    private let bottomGradientLayer: CAGradientLayer = {
        let gl = CAGradientLayer()
        gl.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gl.locations = [0.5, 1]
        gl.opacity = 0.75
        return gl
    }()
    
    // -------------------------------------------------- TOP
    
    public let topLeftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.init(white: 0.8, alpha: 1)
        return label
    }()
    
    public let topRightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "close_bold"), for: .normal)
        button.tintColor = UIColor.init(white: 0.8, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    // -------------------------------------------------- CENTER
    
    public let centerLeftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "backward_bold"), for: .normal)
        button.tintColor = UIColor.init(white: 0.8, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    public let centerLeftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.init(white: 0.8, alpha: 1)
        label.text = "10"
        return label
    }()
    
    public let centerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "play_bold"), for: .normal)
        button.tintColor = UIColor.init(white: 0.8, alpha: 1)
        // TODO: imageEdgeInsets nedir?
        //button.imageEdgeInsets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    public let centerRightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "forward_bold"), for: .normal)
        button.tintColor = UIColor.init(white: 0.8, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    public let centerRightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.init(white: 0.8, alpha: 1)
        label.text = "10"
        return label
    }()
    
    // -------------------------------------------------- BOTTOM
    
    public let bottomLeftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.init(white: 0.8, alpha: 1)
        label.text = "00:00:00"
        return label
    }()
    
    public let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = UIColor.init(white: 0.8, alpha: 1)
        slider.maximumTrackTintColor = UIColor(white: 0.4, alpha: 1)
        slider.thumbTintColor = UIColor.init(white: 0.8, alpha: 1)
        slider.setThumbImage(#imageLiteral(resourceName: "thumb-10"), for: .normal)
        slider.setThumbImage(#imageLiteral(resourceName: "thumb-10"), for: .highlighted)
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        return slider
    }()
    
    public let bottomRightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.init(white: 0.8, alpha: 1)
        label.text = "00:00:00"
        return label
    }()
    
    // --------------------------------------------------
    
    private var value1: CGFloat!
    private var value2: CGFloat!
    private var value3: CGFloat!
    private var value4: CGFloat!
    private var value5: CGFloat!
    private var value6: CGFloat!
    private var value7: CGFloat!
    private var value8: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            value1 = 60
            value2 = value1/2
            value3 = 25
            value4 = 30
            value5 = 20
            value6 = 5
            value7 = 5
            if UIScreen.main.bounds.width == 320.0 || UIScreen.main.bounds.height == 320.0 {
                value8 = 0.6
            } else {
                value8 = 0.7
            }
        } else {
            value1 = 75 // icon size
            value2 = value1/2
            value3 = 40 // top anchor
            value4 = 35 // close icon size
            value5 = 25 // trailing and leading anchor
            value6 = 15 // bottom duration label, slider spacing
            value7 = 7.5 // jump time top anchor
            value8 = 0.8 // slider size
        }
        
        
        
        setupView()
    }
    
    override func layoutSubviews() {
        // TODO: super.layoutSubviews() bunu ekleyince neyide eklemis oluyoruz??
        //super.layoutSubviews()
        topGradientLayer.frame = self.bounds
        bottomGradientLayer.frame = self.bounds
    }
    
    private func setupView() {
        
        let bounds = UIScreen.main.bounds
        let viewWidth = bounds.width > bounds.height ? bounds.width / 4 : bounds.height / 4
        
        self.addSubview(backgroundView)
        backgroundView.addSubview(blackView)
        backgroundView.layer.addSublayer(topGradientLayer)
        backgroundView.layer.addSublayer(bottomGradientLayer)
        self.addSubview(centerLeftButton)
        self.addSubview(centerRightButton)
        self.addSubview(slider)
        backgroundView.addSubview(topLeftLabel)
        backgroundView.addSubview(topRightButton)
        self.addSubview(centerButton)
        backgroundView.addSubview(bottomLeftLabel)
        backgroundView.addSubview(bottomRightLabel)
        
        centerLeftButton.addSubview(centerLeftLabel)
        centerRightButton.addSubview(centerRightLabel)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            
            blackView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            blackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            blackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            blackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            
            centerLeftButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: -(viewWidth + value2)),
            centerLeftButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            centerLeftButton.widthAnchor.constraint(equalToConstant: value1),
            centerLeftButton.heightAnchor.constraint(equalTo: centerLeftButton.widthAnchor),
            
            centerLeftLabel.centerXAnchor.constraint(equalTo: centerLeftButton.centerXAnchor),
            centerLeftLabel.centerYAnchor.constraint(equalTo: centerLeftButton.centerYAnchor, constant: value7),
            
            centerRightButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: viewWidth + value2),
            centerRightButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            centerRightButton.widthAnchor.constraint(equalToConstant: value1),
            centerRightButton.heightAnchor.constraint(equalTo: centerRightButton.widthAnchor),
            
            centerRightLabel.centerXAnchor.constraint(equalTo: centerRightButton.centerXAnchor),
            centerRightLabel.centerYAnchor.constraint(equalTo: centerRightButton.centerYAnchor, constant: value7),
            
            slider.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -value3),
            slider.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: value8),
            
            topLeftLabel.centerYAnchor.constraint(equalTo: topRightButton.centerYAnchor),
            topLeftLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: value5),
            topLeftLabel.trailingAnchor.constraint(equalTo: topRightButton.leadingAnchor, constant: -value5),
            
            topRightButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: value3),
            topRightButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -value5),
            topRightButton.widthAnchor.constraint(equalToConstant: value4),
            topRightButton.heightAnchor.constraint(equalTo: topRightButton.widthAnchor),
            
            centerButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            centerButton.widthAnchor.constraint(equalToConstant: value1),
            centerButton.heightAnchor.constraint(equalTo: centerButton.widthAnchor),
            
            bottomLeftLabel.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            bottomLeftLabel.trailingAnchor.constraint(equalTo: slider.leadingAnchor, constant: -value6),
            bottomLeftLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: value5),
            
            bottomRightLabel.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            bottomRightLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -value5),
            bottomRightLabel.leadingAnchor.constraint(equalTo: slider.trailingAnchor, constant: value6)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
