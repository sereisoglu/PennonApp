//
//  FormatData.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import AVKit

class VLCVideoFeatures: VLCMediaThumbnailerDelegate {
    
    private var file: File?
    private var mediaPlayer: VLCMediaPlayer?
    
    init(file: File) {
        self.file = file
        mediaPlayer = VLCMediaPlayer()
        
        let url = URL(fileURLWithPath: file.path!)
        mediaPlayer?.media = VLCMedia(url: url)
        let thumbnailer = VLCMediaThumbnailer(media: mediaPlayer?.media, andDelegate: self)
        thumbnailer?.fetchThumbnail()
    }
    
    func mediaThumbnailerDidTimeOut(_ mediaThumbnailer: VLCMediaThumbnailer!) {
        self.file?.isReady = true
    }
    
    func mediaThumbnailer(_ mediaThumbnailer: VLCMediaThumbnailer!, didFinishThumbnail thumbnail: CGImage!) {
        self.file?.thumbnail = UIImage(cgImage: thumbnail).pngData()!
        if let player = mediaPlayer {
            self.file?.video?.resolution = "\(Int(player.videoSize.width))x\(Int(player.videoSize.height))"
            self.file?.video?.time = player.media.length.value.floatValue / 1000
            self.file?.video?.timeFormat = AppUtility.timeFormat(time: (self.file?.video?.time)!)
            self.file?.isReady = true
        }
    }
    
}

class AVVideoFeatures {
    
    static func aaa(file: File) {
        let url = URL(fileURLWithPath: file.path!)
        let asset = AVURLAsset(url: url)
        let playableKey = "playable"
        
        asset.loadValuesAsynchronously(forKeys: [playableKey]) {
            var error: NSError? = nil
            let status = asset.statusOfValue(forKey: playableKey, error: &error)
            if status == AVKeyValueStatus.loaded {
                //Time
                file.video?.time = Float(asset.duration.seconds)
                file.video?.timeFormat = AppUtility.timeFormat(time: (file.video?.time)!)
                //Resolution
                if let track = asset.tracks(withMediaType: AVMediaType.video).first {
                    let size = track.naturalSize.applying(track.preferredTransform)
                    file.video?.resolution = "\(Int(size.width))x\(Int(size.height))"
                }
                //Thumbnail
                let imageGenerator = AVAssetImageGenerator(asset: asset)
                imageGenerator.appliesPreferredTrackTransform = true
                var time : CMTime = asset.duration
                time.value =  max(time.value/2, 2)
                do {
                    let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                    if let temp = UIImage(cgImage: cgImage).pngData() {
                        file.thumbnail = temp
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            file.isReady = true
        }
    }
}
