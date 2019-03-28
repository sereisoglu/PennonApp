//
//  PlayerController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit
import AVKit

class PlayerController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let bounds = UIScreen.main.bounds
        if (UIDevice.current.userInterfaceIdiom == .pad){
            controlLayerView.topGradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
            controlLayerView.bottomGradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        }
        else{
            controlLayerView.topGradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.height, height: bounds.width)
            controlLayerView.bottomGradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.height, height: bounds.width)
        }
    }
    
    var homeController: HomeController!
    
    var video: Video!
    var subtitle: Subtitle!
    
    var avPlayerViewController: AVPlayerViewController!
    var avPlayerViewControllerView: UIView!
    var avPlayer: AVPlayer!
    
    convenience init(video: Video,
                     subtitle: Subtitle? = nil) {
        self.init(nibName:nil, bundle:nil)
        
        self.video = video
        if subtitle != nil {
            self.subtitle = subtitle
        }
    }
    
    func goCoreDataDuration() {
        if video.isNew != true {
            let currentDuration = video.duration - video.remainingDuration
            let time: CMTime = CMTimeMake(value: Int64(currentDuration * 1000), timescale: 1000)
            self.avPlayer.seek(to: time, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        }
    }
    
    let controlLayerView: PlayerControlView = {
        var clv = PlayerControlView()
        clv.translatesAutoresizingMaskIntoConstraints = false
        clv.centerViewCenterButton.setImage(#imageLiteral(resourceName: "pause-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        return clv
    }()
    
    let leftDoubleTapLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-5"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.alpha = 0.0
        return label
    }()
    
    let rightDoubleTapLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+5"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.alpha = 0.0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAVPlayerViewController()
        goCoreDataDuration()
        setupAVPlayerControlView()
        setupGesture()
        setupLeftRightDoubleTapLabel()
    }
    
    func setupAVPlayerViewController() {
        self.avPlayerViewController = AVPlayerViewController()
        self.avPlayerViewControllerView = avPlayerViewController.contentOverlayView
        self.avPlayerViewController.showsPlaybackControls = false
        self.avPlayer = AVPlayer(url: video.path!)
        self.avPlayerViewController.player = avPlayer
        
        self.addChild(avPlayerViewController)
        self.view.addSubview(avPlayerViewController.view)
        
        if subtitle != nil {
            self.avPlayerViewController.addSubtitles().open(fileFromLocal: subtitle.path!)
            self.avPlayerViewController.subtitleLabel?.textColor = UIColor.white
        }
        
        self.avPlayer.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        addTimeObserver()
        self.avPlayer.play()
        self.avPlayer.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(closePlayer), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayer.currentItem)
    }
    
    func setupAVPlayerControlView() {
        self.avPlayerViewControllerView.addSubview(controlLayerView)
        
        timerForControlLayerView()
        self.controlLayerView.bottomViewCenterSlider.addTarget(self, action: #selector(bottomViewCenterSliderAction), for: .valueChanged)
        self.controlLayerView.topViewLeftButton.addTarget(self, action: #selector(topViewLeftButtonAction), for: .touchUpInside)
        self.controlLayerView.centerViewCenterButton.addTarget(self, action: #selector(centerViewCenterButtonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            controlLayerView.topAnchor.constraint(equalTo: avPlayerViewControllerView.topAnchor),
            controlLayerView.bottomAnchor.constraint(equalTo: avPlayerViewControllerView.bottomAnchor),
            controlLayerView.trailingAnchor.constraint(equalTo: avPlayerViewControllerView.trailingAnchor),
            controlLayerView.leadingAnchor.constraint(equalTo: avPlayerViewControllerView.leadingAnchor)
            ])
        
        controlLayerView.topViewCenterLabel.text = video.fileName
    }
    
    func setupGesture() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(sender:)))
        singleTap.numberOfTapsRequired = 1
        self.avPlayerViewControllerView.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        doubleTap.numberOfTapsRequired = 2
        self.avPlayerViewControllerView.addGestureRecognizer(doubleTap)
        
        singleTap.require(toFail: doubleTap)
    }
    
    func setupLeftRightDoubleTapLabel() {
        self.view.addSubview(leftDoubleTapLabel)
        self.view.addSubview(rightDoubleTapLabel)
        
        NSLayoutConstraint.activate([
            leftDoubleTapLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            leftDoubleTapLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100),
            
            rightDoubleTapLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            rightDoubleTapLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100)
            ])
    }
    
    @objc func handleSingleTap(sender: UITapGestureRecognizer) {
        if controlLayerView.alpha == 0.0 {
            controlLayerView.alpha = 1.0
            timerForControlLayerView()
        } else {
            controlLayerView.alpha = 0.0
        }
    }
    
    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        sender.isEnabled = false
        let locationInView = sender.location(in: self.avPlayerViewController.contentOverlayView)
        let width = UIScreen.main.bounds.width
        
        if width / 2 < locationInView.x {
            self.rightDoubleTapGesture()
        } else {
            self.leftDoubleTapGesture()
        }
        sender.isEnabled = true
    }
    
    @objc func bottomViewCenterSliderAction() {
        avPlayer.seek(to: CMTimeMake(value: Int64(controlLayerView.bottomViewCenterSlider.value * 1000), timescale: 1000))
    }
    
    @objc func topViewLeftButtonAction() {
        closePlayer()
    }
    
    @objc func closePlayer() {
        avPlayer.pause()
        ControlData.shared.updateRemainingDuration(video: video, duration: CMTimeGetSeconds(self.avPlayer.currentTime()))
        if let token = timeObserverToken {
            self.avPlayer.removeTimeObserver(token)
            timeObserverToken = nil
        }
        //avPlayerViewController.dismiss(animated: true)
        self.avPlayer.replaceCurrentItem(with: nil)
        self.homeController.closePlayer(viewController: self)
    }
    
    @objc func centerViewCenterButtonAction() {
        if #imageLiteral(resourceName: "pause-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate) == controlLayerView.centerViewCenterButton.image(for: .normal) {
            avPlayer.pause()
            controlLayerView.centerViewCenterButton.setImage(#imageLiteral(resourceName: "play-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        } else {
            avPlayer.play()
            controlLayerView.centerViewCenterButton.setImage(#imageLiteral(resourceName: "pause-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        }
    }
    
    func leftDoubleTapGesture() {
        self.leftDoubleTapLabel.alpha = 1.0
        UIView.animate(withDuration: 0.5, animations: {
            self.leftDoubleTapLabel.alpha = 0.0
        })
        
        let currentTime = CMTimeGetSeconds(avPlayer.currentTime())
        var newTime = currentTime - 5.0
        
        if newTime < 0 {
            newTime = 0
        }
        
        let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
        self.avPlayer.seek(to: time, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
    }
    
    func rightDoubleTapGesture() {
        self.rightDoubleTapLabel.alpha = 1.0
        UIView.animate(withDuration: 0.5, animations: {
            self.rightDoubleTapLabel.alpha = 0.0
        })
        
        guard let duration = avPlayer.currentItem?.duration else {return}
        let currentTime = CMTimeGetSeconds(avPlayer.currentTime())
        var newTime = currentTime + 5.0
        
        if newTime > CMTimeGetSeconds(duration) {
            newTime = CMTimeGetSeconds(duration)
        }
        
        let time: CMTime = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
        self.avPlayer.seek(to: time, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
    }
    
    func timerForControlLayerView() {
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when){
            self.controlLayerView.alpha = 0.0
        }
    }
    
    func getTimeString(from time: CMTime) -> String {
        var totalSeconds = CMTimeGetSeconds(time)
        let decimalPlace = Int(totalSeconds * 10) % 10
        if decimalPlace >= 5 { totalSeconds += 1 }
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%02i:%02i:%02i", arguments: [hours,minutes,seconds])
        } else {
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
    }
    
    var timeObserverToken: Any!
    
    func addTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        timeObserverToken = avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            
            var duration = CMTime()
            if let currentItem = self?.avPlayer.currentItem {
                duration = currentItem.asset.duration
            }
            let currentTime = self?.avPlayer.currentTime()
            
            self?.controlLayerView.bottomViewCenterSlider.maximumValue = Float(duration.seconds)
            self?.controlLayerView.bottomViewCenterSlider.minimumValue = 0
            self?.controlLayerView.bottomViewCenterSlider.value = Float(currentTime!.seconds)
            self?.controlLayerView.bottomViewLeftLabel.text = self?.getTimeString(from: currentTime!)
        })
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            //activityIndicatorView.stopAnimating()
            controlLayerView.isHidden = false
        } else if keyPath == "duration", let duration = avPlayer.currentItem?.duration.seconds, duration > 0.0 {
            controlLayerView.bottomViewRightLabel.text = getTimeString(from: avPlayer.currentItem!.duration)
        }
    }
    
}
