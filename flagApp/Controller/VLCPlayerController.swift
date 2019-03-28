//
//  VLCPlayerController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 31.01.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

// TODO: Player pause'dayken sliderla oynayinca position degismiyor.

import UIKit

class VLCPlayerController: PlayerController {
    
    private var totalTime: Float!
    private var jumpTime: Float!
    private var dummyPositionLoading: Bool = true
    private var controlSubtitle: ControlSubtitle!
    private var returnCurrentTime: Double = 0
    private var isTouchUpEvent: Bool = false
    
    override var currentTime: Double! {
        get {
            if !isPlaying && isTouchUpEvent {
                isTouchUpEvent = false
                returnCurrentTime = Double(playerControlView.slider.value * totalTime)
            } else if isPlaying {
                returnCurrentTime = Double(player.position * totalTime)
            }
            return returnCurrentTime
        }
        set {}
    }
    
    private let player: VLCMediaPlayer = {
        let player = VLCMediaPlayer()
        return player
    }()
    
    private let playerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.totalTime = file.video?.time
        self.playerControlView.bottomRightLabel.text = file.video?.timeFormat
        self.jumpTime = 10 / self.totalTime
        
        getCoreData()
        player.addObserver(self, forKeyPath: "position", options: [.old, .new], context: nil)
    }
    
    override func setupPlayerViewController() {
        self.view.addSubview(playerView)
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            playerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            playerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        
        player.delegate = self
        player.drawable = playerView
        player.media = VLCMedia(path: file.path!)
        
        if let subtitle = file.video?.subtitle {
            controlSubtitle = ControlSubtitle(file: subtitle, playerController: self)
        }
        
        player.play()
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
            player.position = position
            playerControlView.slider.value = position
            playerControlView.bottomLeftLabel.text = AppUtility.timeFormat(time: totalTime * position)
            dummyPositionLoading = false
        }
    }
    
    // -------------------------------------------------- PLAYER CONTROL VIEW
    
    override func bottomViewCenterSliderTouch() {
        super.bottomViewCenterSliderTouch()
        addObserverForPosition()
        isTouchUpEvent = true
    }
    
    private func addObserverForPosition() {
        if playerControlView.slider.value == 1.0 {
            player.stop()
        } else {
            dummyPositionLoading = false
            player.position = playerControlView.slider.value
            playerControlView.bottomLeftLabel.text = AppUtility.timeFormat(time: totalTime * playerControlView.slider.value)
            player.addObserver(self, forKeyPath: "position", options: [.old, .new], context: nil)
        }
    }
    
    override func bottomViewCenterSliderValueChanged() {
        super.bottomViewCenterSliderValueChanged()
        removeObserverForPosition()
    }
    
    private func removeObserverForPosition() {
        if player.observationInfo != nil {
            player.removeObserver(self, forKeyPath: "position")
        }
        playerControlView.bottomLeftLabel.text = AppUtility.timeFormat(time: totalTime * playerControlView.slider.value)
    }
    
    override func topViewLeftButtonAction() {
        player.stop()
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
        if keyPath == "position" {
            if dummyPositionLoading {
                playerControlView.slider.value = player.position
                playerControlView.bottomLeftLabel.text = AppUtility.timeFormat(time: totalTime * player.position)
            }
            dummyPositionLoading = true
        }
    }
    
    override func closePlayer() {
        player.removeObserver(self, forKeyPath: "position")
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

extension VLCPlayerController: VLCMediaPlayerDelegate {
    
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
        
        if player.state == .stopped {
            closePlayer()
        } else if player.state == .buffering && player.currentVideoSubTitleIndex != -1 {
            player.currentVideoSubTitleIndex = -1
        } else if player.state == .ended {
            playerControlView.slider.value = 1.0
        } else if player.state == .playing {
            isPlaying = true
            createTimerForPlayerControlView()
        } else if player.state == .paused {
            isPlaying = false
            deleteTimerForPlayerControlView()
        }
        
//        switch mediaPlayer.state {
//        case .buffering:
//            print("\nBUFFERING\n")
//        case .stopped:
//            print("\nSTOPPED\n")
//        case .opening:
//            print("\nOPENING\n")
//        case .ended:
//            print("\nENDED\n")
//        case .error:
//            print("\nERROR\n")
//        case .playing:
//            print("\nPLAYING\n")
//        case .paused:
//            print("\nPAUSED\n")
//        case .esAdded:
//            print("\nESADDED\n")
//        }
    }
}
