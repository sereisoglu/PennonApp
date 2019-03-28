//
//  FormatData.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit
import AVFoundation

extension ControlData {
    
    func fileName(url: URL) -> String {
        return url.deletingPathExtension().lastPathComponent
    }
    
    func fileExtension(url: URL) -> String {
        return url.pathExtension
    }
    
    func fileSize(url: URL) -> Int64 {
        var tempSize = Int64()
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
            if let val = attributes[.size] as? NSNumber {
                tempSize = val.int64Value
            }
        } catch {
            print(error)
        }
        return tempSize
    }
    
    func fileSizeFormat(url: URL) -> String {
        var tempSize = String()
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
            if let val = attributes[.size] as? NSNumber {
                tempSize = ByteCountFormatter.string(fromByteCount: val.int64Value, countStyle: .file)
            }
        } catch {
            print(error)
        }
        return tempSize
    }
    
    func videoDuration(url: URL) -> Double {
        var asset: AVURLAsset!
        var duration: CMTime!
        var seconds: Double = 0.0
        asset = AVURLAsset(url: url)
        duration = asset.duration
        seconds = duration.seconds
        return seconds
    }
    
    func videoDurationFormat(url: URL) -> String {
        let time = videoDuration(url: url)
        return durationFormat(time: time)
    }
    
    func durationFormat(time: Double) -> String {
        var totalSecond = time
        let decimalPlace = Int(totalSecond * 10) % 10
        if decimalPlace >= 5 { totalSecond += 1 }
        let hours = Int(time/3600)
        let minutes = Int(time/60) % 60
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%02i:%02i:%02i", arguments: [hours,minutes,seconds])
        }else {
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
    }
    
    func videoResolution(url: URL) -> String {
        var resolution = String()
        if let track = AVAsset(url: url as URL).tracks(withMediaType: AVMediaType.video).first {
            let size = track.naturalSize.applying(track.preferredTransform)
            resolution = "\(Int(size.width))x\(Int(size.height))"
        }
        return resolution
    }
    
    func videoThumbnail(url: URL) -> Data {
        let defaultImage: UIImage = UIColor.init(white: 0, alpha: 0.2).image()
        var data: Data = defaultImage.pngData()!
        let asset: AVURLAsset = AVURLAsset(url: url) as AVURLAsset
        let imageGenerator: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset) as AVAssetImageGenerator
        imageGenerator.appliesPreferredTrackTransform = true
        
        var time : CMTime = asset.duration
        time.value =  max(time.value/2, 2)
        do {
            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            if let temp = UIImage(cgImage: cgImage).pngData() {
                data = temp
            }
        } catch {
            print(error.localizedDescription)
        }
        return data
    }
    
}
