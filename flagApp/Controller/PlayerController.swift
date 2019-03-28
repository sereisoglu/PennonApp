//
//  PlayerController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 8.02.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class PlayerController: UIViewController {
    
    private var timer: Timer?
    internal var isPlaying: Bool = true
    
    func createTimerForPlayerControlView() {
        if timer == nil && isPlaying && !isHidePlayerControlView() {
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.abcdabcd), userInfo: nil, repeats: false)
            }
        }
    }
    
    @objc func abcdabcd() {
        deleteTimerForPlayerControlView()
        hidePlayerControlView()
    }
    
    func createNewTimerForPlayerControlView() {
        deleteTimerForPlayerControlView()
        createTimerForPlayerControlView()
    }
    
    func deleteTimerForPlayerControlView() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    public var homeController: HomeController!
    internal var currentTime: Double!
    internal var file: File!
    
    internal var playerControlView: PlayerControlView = {
        var pcv = PlayerControlView()
        pcv.translatesAutoresizingMaskIntoConstraints = false
        return pcv
    }()

    convenience init(video: File) {
        self.init(nibName:nil, bundle:nil)
        
        AppUtility.openPlayer()
        self.file = video
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayerViewController()
        createTimerForPlayerControlView()
        setupPlayerControlView()
        setupGesture()
        setUpTheming()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleApplicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleApplicationWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        if isHidePlayerControlView() {
            return true
        }
        return false
    }

    
    func isHidePlayerControlView() -> Bool{
        if playerControlView.backgroundView.alpha == 0.0 {
            return true
        }
        return false
    }
    
    internal func setupPlayerViewController() { }
    
    // -------------------------------------------------- CORE DATA

    internal func getCoreData() { }
    
    private func setCoreData() {
        file.video?.position = playerControlView.slider.value
        if file.isNew {
            file.isNew = false
        }
        if playerControlView.slider.value == 1.0 {
            file.video?.isDone = true
        }
        CoreDataManager.shared.save = true
    }
    
    // -------------------------------------------------- PLAYER CONTROL VIEW
    
    private func setupPlayerControlView() {
        playerControlView = PlayerControlView()
        playerControlView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(playerControlView)
        
        NSLayoutConstraint.activate([
            playerControlView.topAnchor.constraint(equalTo: self.view.topAnchor),
            playerControlView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            playerControlView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            playerControlView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
            ])
        
        //TODO: video.file?.name olur mu?
        playerControlView.topLeftLabel.text = file.name
        playerControlView.centerButton.setImage(#imageLiteral(resourceName: "pause_bold"), for: .normal)
        
        playerControlView.slider.addTarget(self, action: #selector(bottomViewCenterSliderValueChanged), for: .valueChanged)
        playerControlView.slider.addTarget(self, action: #selector(bottomViewCenterSliderTouch), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
        playerControlView.topRightButton.addTarget(self, action: #selector(topViewLeftButtonAction), for: .touchDown)
        playerControlView.centerButton.addTarget(self, action: #selector(centerViewCenterButtonAction), for: .touchDown)
        playerControlView.centerLeftButton.addTarget(self, action: #selector(handleCenterLeftButton), for: .touchDown)
        playerControlView.centerRightButton.addTarget(self, action: #selector(handleCenterRightButton), for: .touchDown)
    }
    
    @objc internal func bottomViewCenterSliderTouch() {
        createTimerForPlayerControlView()
    }
    
    @objc internal func bottomViewCenterSliderValueChanged() {
        deleteTimerForPlayerControlView()
    }
    
    @objc internal func topViewLeftButtonAction() { }
    
    @objc internal func centerViewCenterButtonAction() { }
    
    @objc internal func handleCenterLeftButton() {
        createNewTimerForPlayerControlView()
    }
    
    @objc internal func handleCenterRightButton() {
        createNewTimerForPlayerControlView()
    }
    
    // -------------------------------------------------- GESTURE
    
    internal func setupGesture() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTap.numberOfTapsRequired = 1
        self.playerControlView.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        doubleTap.numberOfTapsRequired = 2
        self.playerControlView.addGestureRecognizer(doubleTap)
        
        singleTap.require(toFail: doubleTap)
        
        let twoFingerTap = UITapGestureRecognizer(target: self, action: #selector(handleTwoFingerTap(sender:)))
        twoFingerTap.numberOfTouchesRequired = 2
        self.playerControlView.addGestureRecognizer(twoFingerTap)
    }
    
    @objc internal func handleSingleTap() {
        if isHidePlayerControlView() {
            showPlayerControlView()
            createTimerForPlayerControlView()
        } else {
            hidePlayerControlView()
            deleteTimerForPlayerControlView()
        }
    }
    
    @objc private func hidePlayerControlView() {
        playerControlView.backgroundView.alpha = 0.0
        playerControlView.centerButton.alpha = 0.0
        playerControlView.centerLeftButton.alpha = 0.0
        playerControlView.centerRightButton.alpha = 0.0
        playerControlView.slider.alpha = 0.0
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func showPlayerControlView() {
        playerControlView.backgroundView.alpha = 1.0
        playerControlView.centerButton.alpha = 1.0
        playerControlView.centerLeftButton.alpha = 1.0
        playerControlView.centerRightButton.alpha = 1.0
        playerControlView.slider.alpha = 1.0
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @objc private func handleDoubleTap(sender: UITapGestureRecognizer) {
        sender.isEnabled = false
        let locationInView = sender.location(in: self.view)
        let width = UIScreen.main.bounds.width
        
        if width / 2 < locationInView.x {
            self.rightDoubleTapGesture()
        } else {
            self.leftDoubleTapGesture()
        }
        sender.isEnabled = true
    }
    
    internal func leftDoubleTapGesture() {
        if isHidePlayerControlView() {
            playerControlView.centerLeftButton.alpha = 1.0
            playerControlView.slider.alpha = 1.0
            UIView.animate(withDuration: 0.5, animations: {
                self.playerControlView.centerLeftButton.alpha = 0.0
                self.playerControlView.slider.alpha = 0.0
            })
        }
    }
    
    internal func rightDoubleTapGesture() {
        if isHidePlayerControlView() {
            playerControlView.centerRightButton.alpha = 1.0
            playerControlView.slider.alpha = 1.0
            UIView.animate(withDuration: 0.5, animations: {
                self.playerControlView.centerRightButton.alpha = 0.0
                self.playerControlView.slider.alpha = 0.0
            })
        }
    }
    
    @objc private func handleTwoFingerTap(sender: UITapGestureRecognizer) {
        sender.isEnabled = false
        centerViewCenterButtonAction()
        sender.isEnabled = true
    }
    
    // --------------------------------------------------
    
    internal func closePlayer() {
        AppUtility.closePlayer()
        setCoreData()
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.homeController.setupGridView()
        DispatchQueue.main.async {
            self.homeController.collectionView.reloadData()
        }
    }
    
    @objc internal func handleApplicationWillResignActive() { }
    
    @objc private func handleApplicationWillTerminate() {
        closePlayer()
    }
    
}

extension PlayerController: Themed {
    func applyTheme(_ theme: AppTheme) {
        playerControlView.topLeftLabel.font = theme.header2SemiFont
        playerControlView.centerLeftLabel.font = theme.paragraph1Font
        playerControlView.centerRightLabel.font = theme.paragraph1Font
        playerControlView.bottomLeftLabel.font = theme.custom2Font
        playerControlView.bottomRightLabel.font = theme.custom2Font
    }
}
