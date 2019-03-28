//
//  AVPlayerController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 16.02.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit
import AVKit

class AVPlayerController: PlayerController {
    
    private var dummyPositionLoading: Bool = true
    private var totalTime: Float!
    private var jumpTime: Float!
    private var timeObserverToken: Any!
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    private var controlSubtitle: ControlSubtitle!
    
    override var currentTime: Double! {
        get {
            return player.currentTime().seconds
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("error")
        }
        
        self.totalTime = file.video?.time
        self.playerControlView.bottomRightLabel.text = file.video?.timeFormat
        self.jumpTime = 10 / self.totalTime
        
        getCoreData()
        
        setupTimeObserver()
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        player.addObserver(self, forKeyPath: "rate", options: [.old, .new], context: nil)
    }
    
    override func setupPlayerViewController() {
        let url = URL(fileURLWithPath: file.path!)
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspect
        self.view.layer.addSublayer(playerLayer)
        
        if let subtitle = file.video?.subtitle {
            controlSubtitle = ControlSubtitle(file: subtitle, playerController: self)
        }
        
        player.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = self.view.bounds
    }
    
    // -------------------------------------------------- CORE DATA
    
    override func getCoreData() {
        if file.isNew || (file.video?.isDone)! {
            playerControlView.bottomLeftLabel.text = "00:00"
            if (file.video?.isDone)! {
                file.video?.isDone = false
            }
        } else {
            guard let position = file.video?.position else { return }
            player.seek(to: CMTime(seconds: Double(position * totalTime), preferredTimescale: 1))
            playerControlView.slider.value = position
            playerControlView.bottomLeftLabel.text = AppUtility.timeFormat(time: totalTime * position)
        }
    }
    
    // -------------------------------------------------- PLAYER CONTROL VIEW
    
    override func bottomViewCenterSliderTouch() {
        super.bottomViewCenterSliderTouch()
        addObserverForPosition()
    }
    
    private func addObserverForPosition() {
        if playerControlView.slider.value == 1.0 {
            closePlayer()
        } else {
            dummyPositionLoading = false
            player.seek(to: CMTime(seconds: Double(playerControlView.slider.value * totalTime), preferredTimescale: 1))
            playerControlView.bottomLeftLabel.text = AppUtility.timeFormat(time: totalTime * playerControlView.slider.value)
            setupTimeObserver()
        }
    }
    
    override func bottomViewCenterSliderValueChanged() {
        super.bottomViewCenterSliderValueChanged()
        removeObserverForPosition()
    }
    
    private func removeObserverForPosition() {
        deleteTimeObserver()
        playerControlView.bottomLeftLabel.text = AppUtility.timeFormat(time: totalTime * playerControlView.slider.value)
    }
    
    override func topViewLeftButtonAction() {
        closePlayer()
    }
    
    override func centerViewCenterButtonAction() {
        if player.isPlaying {
            player.pause()
            playerControlView.centerButton.setImage(#imageLiteral(resourceName: "play_bold"), for: .normal)
        } else {
            player.play()
            playerControlView.centerButton.setImage(#imageLiteral(resourceName: "pause_bold"), for: .normal)
        }
    }
    
    override func handleCenterLeftButton() {
        super.handleCenterLeftButton()
        jumpBackward()
    }
    
    private func jumpBackward() {
        playerControlView.slider.value -= jumpTime
        removeObserverForPosition()
        addObserverForPosition()
    }
    
    override func handleCenterRightButton() {
        super.handleCenterRightButton()
        jumpForward()
    }
    
    private func jumpForward() {
        playerControlView.slider.value += jumpTime
        removeObserverForPosition()
        addObserverForPosition()
    }
    
    // -------------------------------------------------- GESTURE
    
    override func leftDoubleTapGesture() {
        super.leftDoubleTapGesture()
        jumpBackward()
    }
    
    override func rightDoubleTapGesture() {
        super.rightDoubleTapGesture()
        jumpForward()
    }
    
    // -------------------------------------------------- OBSERVER
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "rate" {
            if player.rate == 1.0 {
                isPlaying = true
                createTimerForPlayerControlView()
            } else if player.rate == 0.0 {
                isPlaying = false
                deleteTimerForPlayerControlView()
            }
        }
    }
    
    private func setupTimeObserver() {
        let interval = CMTime(seconds: 1/60, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue) { [weak self] time in
            if (self?.dummyPositionLoading)! {
                self?.playerControlView.slider.value = Float((self?.player.currentTime().seconds)!) / (self?.totalTime)!
                self?.playerControlView.bottomLeftLabel.text = AppUtility.timeFormat(time: Float((self?.player.currentTime().seconds)!))
            }
            self?.dummyPositionLoading = true
        }
    }
    
    private func deleteTimeObserver() {
        if let token = timeObserverToken {
            player.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
    
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        closePlayer()
    }
    
    override func closePlayer() {
        player.pause()
        deleteTimeObserver()
        player.replaceCurrentItem(with: nil)
        if controlSubtitle != nil {
            controlSubtitle.kill()
            controlSubtitle = nil
        }
        super.closePlayer()
    }
    
    override func handleApplicationWillResignActive() {
        if player.isPlaying {
            player.pause()
            playerControlView.centerButton.setImage(#imageLiteral(resourceName: "play_bold"), for: .normal)
        }
    }
    
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate == 0.0 ? false : true
    }
}
