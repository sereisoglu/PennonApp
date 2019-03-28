//
//  PlayerControlView.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

let centerViewCenterButtonSize: CGFloat = 90

class PlayerControlView: UIView {
    
    let controlItemViewMargin: CGFloat = 10
    let topBottomViewHeight: CGFloat = 40
    let centerViewHeight: CGFloat = 90
    let topViewLeftButtonSize: CGFloat = 40
    let bottomViewCenterSliderMargin: CGFloat = 10
    
    let gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topGradientLayer: CAGradientLayer = {
        let gl = CAGradientLayer()
        gl.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gl.startPoint = CGPoint(x: 0.5, y: 1.0)
        gl.endPoint = CGPoint(x: 0.5, y: 0.0)
        gl.locations = [0.2, 1.0]
        gl.opacity = 0.75
        return gl
    }()
    
    let bottomGradientLayer: CAGradientLayer = {
        let gl = CAGradientLayer()
        gl.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gl.locations = [0.2, 1.0]
        gl.opacity = 0.75
        return gl
    }()
    
    let controlItemView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topViewLeftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "close-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    let topViewCenterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "File Name"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let centerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let centerViewCenterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.adjustsImageWhenHighlighted = false
        button.imageEdgeInsets = UIEdgeInsets(top: centerViewCenterButtonSize,
                                              left: centerViewCenterButtonSize,
                                              bottom: centerViewCenterButtonSize,
                                              right: centerViewCenterButtonSize)
        return button
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomViewLeftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    let bottomViewCenterSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = UIColor(white: 1, alpha: 0.5)
        slider.thumbTintColor = .white
        slider.setThumbImage(#imageLiteral(resourceName: "thumb-10"), for: .normal)
        slider.setThumbImage(#imageLiteral(resourceName: "thumb-10"), for: .highlighted)
        return slider
    }()
    
    let bottomViewRightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGradientView()
        setupControlItems()
    }
    
    func setupGradientView() {
        self.addSubview(gradientView)
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: self.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            ])
        
        let bounds = UIScreen.main.bounds
        topGradientLayer.frame = bounds
        bottomGradientLayer.frame = bounds
        gradientView.layer.addSublayer(topGradientLayer)
        gradientView.layer.addSublayer(bottomGradientLayer)
    }
    
    func setupControlItems() {
        self.addSubview(controlItemView)
        controlItemView.addSubview(topView)
        topView.addSubview(topViewLeftButton)
        topView.addSubview(topViewCenterLabel)
        controlItemView.addSubview(centerView)
        centerView.addSubview(centerViewCenterButton)
        controlItemView.addSubview(bottomView)
        bottomView.addSubview(bottomViewLeftLabel)
        bottomView.addSubview(bottomViewCenterSlider)
        bottomView.addSubview(bottomViewRightLabel)
        
        NSLayoutConstraint.activate([
            controlItemView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: controlItemViewMargin),
            controlItemView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -controlItemViewMargin),
            controlItemView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -controlItemViewMargin),
            controlItemView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: controlItemViewMargin),
            
            topView.topAnchor.constraint(equalTo: controlItemView.topAnchor),
            topView.trailingAnchor.constraint(equalTo: controlItemView.trailingAnchor),
            topView.leadingAnchor.constraint(equalTo: controlItemView.leadingAnchor),
            topView.heightAnchor.constraint(equalToConstant: topBottomViewHeight),
            
            topViewLeftButton.topAnchor.constraint(equalTo: topView.topAnchor),
            topViewLeftButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            topViewLeftButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            topViewLeftButton.heightAnchor.constraint(equalToConstant: topViewLeftButtonSize),
            topViewLeftButton.widthAnchor.constraint(equalToConstant: topViewLeftButtonSize),
            
            topViewCenterLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            topViewCenterLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topViewCenterLabel.widthAnchor.constraint(equalToConstant: 200),
            
            centerView.centerXAnchor.constraint(equalTo: controlItemView.centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: controlItemView.centerYAnchor),
            centerView.widthAnchor.constraint(equalTo: controlItemView.widthAnchor),
            centerView.heightAnchor.constraint(equalToConstant: centerViewHeight),
            
            centerViewCenterButton.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            centerViewCenterButton.centerYAnchor.constraint(equalTo: centerView.centerYAnchor),
            centerViewCenterButton.widthAnchor.constraint(equalToConstant: centerViewCenterButtonSize),
            centerViewCenterButton.heightAnchor.constraint(equalToConstant: centerViewCenterButtonSize),
            
            bottomView.bottomAnchor.constraint(equalTo: controlItemView.bottomAnchor),
            bottomView.trailingAnchor.constraint(equalTo: controlItemView.trailingAnchor),
            bottomView.leadingAnchor.constraint(equalTo: controlItemView.leadingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: topBottomViewHeight),
            
            bottomViewLeftLabel.topAnchor.constraint(equalTo: bottomView.topAnchor),
            bottomViewLeftLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            bottomViewLeftLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            bottomViewLeftLabel.widthAnchor.constraint(equalToConstant: 65),
            
            bottomViewCenterSlider.topAnchor.constraint(equalTo: bottomView.topAnchor),
            bottomViewCenterSlider.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            bottomViewCenterSlider.leadingAnchor.constraint(equalTo: bottomViewLeftLabel.trailingAnchor, constant: bottomViewCenterSliderMargin),
            bottomViewCenterSlider.trailingAnchor.constraint(equalTo: bottomViewRightLabel.leadingAnchor, constant: -bottomViewCenterSliderMargin),
            
            bottomViewRightLabel.topAnchor.constraint(equalTo: bottomView.topAnchor),
            bottomViewRightLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            bottomViewRightLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            bottomViewRightLabel.widthAnchor.constraint(equalToConstant: 65)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
