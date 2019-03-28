//
//  PhoneTutorialController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 7.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class PhoneTutorialController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    private var themedStatusBarStyle: UIStatusBarStyle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themedStatusBarStyle ?? super.preferredStatusBarStyle
    }
    
    private let backgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tutorial"
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let closeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "close_bold")
        return iv
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let generalView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // TUTORIAL 1
    
    private let tutorialView1: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 15
        return v
    }()
    
    private let tutorial1Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "How to add files to Flag Player?"
        label.numberOfLines = 0
        return label
    }()
    
    private let tutorial1HeaderLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "iTunes File Sharing"
        return label
    }()
    
    private let tutorial1Header1DescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Instead of File Sharing, consider using AirDrop to sharing your files.\n1. Open ‘iTunes’ on your Mac or PC.\n2. Connect your iPhone or iPad to your computer using the USB cable that came with your device.\n3. Click your device.\n4. In the left sidebar, click ‘File Sharing’.\n5. Select the ‘Flag Player’ from the list in the ‘Apps’ section.\n6. Drag and drop files from a folder or window onto the Documents list to copy them to your device.You can also click Add in the Documents list in iTunes,find the file or files you want to copy from your computer, and then click Add. iTunes copies these files to the app on your device. Choose only files that will work with the app. (Currently only ‘.mp4, .mov, .m4v, .mkv, .flv, .3gp, .avi, .wmv, .srt’ files can be work in the Flag Player.)"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let tutorial1HeaderLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "'Share' in other applications"
        return label
    }()
    
    private let tutorial1Header2DescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1. Click the share button of the file you want to share. (Remember currently only ‘.mp4, .mov, .m4v, .mkv, .flv, .3gp, .avi, .wmv, .srt’ files can be work in the Flag Player.)\n2. In the window that opens, click ’Save to Files’.\n3. Select the ‘Flag Player’ folder from the list in the ‘On My iPhone’ or ‘On My iPad' section.\n4. Click ‘Add’ button."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    // TUTORIAL 2
    
    private let tutorialView2: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 15
        return v
    }()
    
    private let tutorial2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "How to add subtitles to video?"
        label.numberOfLines = 2
        return label
    }()
    
    private let tutorial2DescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1. Click the info button of the file you want to add subtitles.\n2. In the window that opens, click ’Select Subtitle’.\n3. Select the subtitle you want from the list in the ‘Select Subtitle’ section."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchDown)
        
        setUpTheming()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view != self.view {
            return false
        }
        return true
    }
    
    private func setupView() {
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(label1)
        backgroundView.addSubview(closeButton)
        closeButton.addSubview(closeImageView)
        
        backgroundView.addSubview(scrollView)
        scrollView.addSubview(generalView)
        
        generalView.addSubview(tutorialView1)
        tutorialView1.addSubview(tutorial1Label)
        tutorialView1.addSubview(tutorial1HeaderLabel1)
        tutorialView1.addSubview(tutorial1Header1DescriptionLabel)
        tutorialView1.addSubview(tutorial1HeaderLabel2)
        tutorialView1.addSubview(tutorial1Header2DescriptionLabel)
        
        generalView.addSubview(tutorialView2)
        tutorialView2.addSubview(tutorial2Label)
        tutorialView2.addSubview(tutorial2DescriptionLabel)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            label1.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 40),
            label1.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -20),
            label1.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,constant: 20),
            
            closeButton.centerYAnchor.constraint(equalTo: label1.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            
            closeImageView.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor),
            closeImageView.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            closeImageView.widthAnchor.constraint(equalToConstant: 15),
            closeImageView.heightAnchor.constraint(equalTo: closeImageView.widthAnchor),
            
            scrollView.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            
            generalView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            generalView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            generalView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            generalView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            generalView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            tutorialView1.topAnchor.constraint(equalTo: generalView.topAnchor),
            tutorialView1.trailingAnchor.constraint(equalTo: generalView.trailingAnchor),
            tutorialView1.leadingAnchor.constraint(equalTo: generalView.leadingAnchor),
            
            tutorial1Label.topAnchor.constraint(equalTo: tutorialView1.topAnchor, constant: 10),
            tutorial1Label.trailingAnchor.constraint(equalTo: tutorialView1.trailingAnchor, constant: -20),
            tutorial1Label.leadingAnchor.constraint(equalTo: tutorialView1.leadingAnchor, constant: 20),
            
            tutorial1HeaderLabel1.topAnchor.constraint(equalTo: tutorial1Label.bottomAnchor, constant: 5),
            tutorial1HeaderLabel1.trailingAnchor.constraint(equalTo: tutorialView1.trailingAnchor, constant: -20),
            tutorial1HeaderLabel1.leadingAnchor.constraint(equalTo: tutorialView1.leadingAnchor, constant: 20),
            
            tutorial1Header1DescriptionLabel.topAnchor.constraint(equalTo: tutorial1HeaderLabel1.bottomAnchor, constant: 5),
            tutorial1Header1DescriptionLabel.trailingAnchor.constraint(equalTo: tutorialView1.trailingAnchor, constant: -20),
            tutorial1Header1DescriptionLabel.leadingAnchor.constraint(equalTo: tutorialView1.leadingAnchor, constant: 20),
            
            tutorial1HeaderLabel2.topAnchor.constraint(equalTo: tutorial1Header1DescriptionLabel.bottomAnchor, constant: 5),
            tutorial1HeaderLabel2.trailingAnchor.constraint(equalTo: tutorialView1.trailingAnchor, constant: -20),
            tutorial1HeaderLabel2.leadingAnchor.constraint(equalTo: tutorialView1.leadingAnchor, constant: 20),
            
            tutorial1Header2DescriptionLabel.topAnchor.constraint(equalTo: tutorial1HeaderLabel2.bottomAnchor, constant: 5),
            tutorial1Header2DescriptionLabel.trailingAnchor.constraint(equalTo: tutorialView1.trailingAnchor, constant: -20),
            tutorial1Header2DescriptionLabel.leadingAnchor.constraint(equalTo: tutorialView1.leadingAnchor, constant: 20),
            tutorial1Header2DescriptionLabel.bottomAnchor.constraint(equalTo: tutorialView1.bottomAnchor, constant: -20),
            
            tutorialView2.topAnchor.constraint(equalTo: tutorialView1.bottomAnchor, constant: 20),
            tutorialView2.trailingAnchor.constraint(equalTo: generalView.trailingAnchor),
            tutorialView2.leadingAnchor.constraint(equalTo: generalView.leadingAnchor),
            tutorialView2.bottomAnchor.constraint(equalTo: generalView.bottomAnchor),
            
            tutorial2Label.topAnchor.constraint(equalTo: tutorialView2.topAnchor, constant: 10),
            tutorial2Label.trailingAnchor.constraint(equalTo: tutorialView2.trailingAnchor, constant: -20),
            tutorial2Label.leadingAnchor.constraint(equalTo: tutorialView2.leadingAnchor, constant: 20),
            
            tutorial2DescriptionLabel.topAnchor.constraint(equalTo: tutorial2Label.bottomAnchor, constant: 10),
            tutorial2DescriptionLabel.trailingAnchor.constraint(equalTo: tutorialView2.trailingAnchor, constant: -20),
            tutorial2DescriptionLabel.leadingAnchor.constraint(equalTo: tutorialView2.leadingAnchor, constant: 20),
            tutorial2DescriptionLabel.bottomAnchor.constraint(equalTo: tutorialView2.bottomAnchor, constant: -20),
            ])
    }
    
    @objc private func handleCloseButton() {
        closePhoneTutorialController()
    }
    
    private func closePhoneTutorialController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PhoneTutorialController: Themed {
    func applyTheme(_ theme: AppTheme) {
        themedStatusBarStyle = theme.statusBarStyle
        setNeedsStatusBarAppearanceUpdate()
        
        backgroundView.backgroundColor = theme.backgroundColor
        label1.textColor = theme.primaryColor
        label1.font = theme.header1Font
        closeButton.backgroundColor = theme.primaryColor
        closeImageView.tintColor = theme.tertiaryColor
        tutorialView1.backgroundColor = theme.tertiaryColor
        tutorial1Label.textColor = theme.primaryColor
        tutorial1Label.font = theme.header2Font
        tutorial1HeaderLabel1.textColor = theme.primaryColor
        tutorial1HeaderLabel1.font = theme.paragraph1Font
        tutorial1Header1DescriptionLabel.textColor = theme.secondaryColor
        tutorial1Header1DescriptionLabel.font = theme.paragraph1Font
        tutorial1HeaderLabel2.textColor = theme.primaryColor
        tutorial1HeaderLabel2.font = theme.paragraph1Font
        tutorial1Header2DescriptionLabel.textColor = theme.secondaryColor
        tutorial1Header2DescriptionLabel.font = theme.paragraph1Font
        tutorialView2.backgroundColor = theme.tertiaryColor
        tutorial2Label.textColor = theme.primaryColor
        tutorial2Label.font = theme.header2Font
        tutorial2DescriptionLabel.textColor = theme.secondaryColor
        tutorial2DescriptionLabel.font = theme.paragraph1Font
    }
}
