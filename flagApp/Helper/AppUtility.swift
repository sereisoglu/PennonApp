//
//  AppUtility.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 1.02.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

class AppUtility {
    
    static func themeConfig() {
        switch Defaults.getTheme.theme {
        case "darkPadPlus":
            AppThemeProvider.shared.setNewTheme(.darkPadPlus)
        case "lightPadPlus":
            AppThemeProvider.shared.setNewTheme(.lightPadPlus)
        case "darkPad":
            AppThemeProvider.shared.setNewTheme(.darkPad)
        case "lightPad":
            AppThemeProvider.shared.setNewTheme(.lightPad)
        case "darkPhone":
            AppThemeProvider.shared.setNewTheme(.darkPhone)
        case "lightPhone":
            AppThemeProvider.shared.setNewTheme(.lightPhone)
        default:
            selectTheme()
        }
    }
    
    static func selectTheme() {
        let bounds = UIScreen.main.bounds
        if UIDevice.current.userInterfaceIdiom == .phone {
            AppThemeProvider.shared.setNewTheme(.lightPhone)
            Defaults.saveTheme("lightPhone")
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            if bounds.width == 1366.0 || bounds.height == 1366.0 {
                AppThemeProvider.shared.setNewTheme(.lightPadPlus)
                Defaults.saveTheme("lightPadPlus")
            } else {
                AppThemeProvider.shared.setNewTheme(.lightPad)
                Defaults.saveTheme("lightPad")
            }
        }
    }
    
    static func toggleTheme(theme: String) {
        switch theme {
        case "darkPadPlus":
            AppThemeProvider.shared.setNewTheme(.darkPadPlus)
            Defaults.saveTheme("darkPadPlus")
        case "lightPadPlus":
            AppThemeProvider.shared.setNewTheme(.lightPadPlus)
            Defaults.saveTheme("lightPadPlus")
        case "darkPad":
            AppThemeProvider.shared.setNewTheme(.darkPad)
            Defaults.saveTheme("darkPad")
        case "lightPad":
            AppThemeProvider.shared.setNewTheme(.lightPad)
            Defaults.saveTheme("lightPad")
        case "darkPhone":
            AppThemeProvider.shared.setNewTheme(.darkPhone)
            Defaults.saveTheme("darkPhone")
        case "lightPhone":
            AppThemeProvider.shared.setNewTheme(.lightPhone)
            Defaults.saveTheme("lightPhone")
        default:
            print("Error")
        }
    }
    
    static func remainingTimeFormat(position: Float, time: Float, numberOfLines: Int) -> String {
        let result = timeCalculate(time - (position * time))
        var resultText: String = ""
        if result.hours > 0 {
            if result.minutes >= 30 {
                resultText = "\(result.hours + 1)h"
            } else {
                resultText = "\(result.hours)h"
            }
        } else if result.minutes > 0 {
            if result.seconds >= 30 {
                resultText = "\(result.minutes + 1)m"
            } else {
                resultText = "\(result.minutes)m"
            }
        } else {
            resultText = "\(result.seconds)s"
        }
        if numberOfLines == 1 {
            return "\(resultText) remaining"
        } else {
            return "\(resultText)\nremaining"
        }
    }
    
    static func dataToImage(data: Data) -> UIImage {
        var thumbnailImage = UIImage()
        if let image = UIImage(data: data) {
            thumbnailImage = image
        }
        return thumbnailImage
    }
    
    static func fileName(path: String) -> String? {
        let url = URL(fileURLWithPath: path)
        return url.deletingPathExtension().lastPathComponent
    }
    
    static func fileExtension(path: String) -> String? {
        let url = URL(fileURLWithPath: path)
        return url.pathExtension
    }
    
    static func fileSize(path: String) -> Int64 {
        var size = Int64()
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: path)
            if let val = attributes[.size] as? NSNumber {
                size = val.int64Value
            }
        } catch {
            print(error)
        }
        return size
    }
    
    static func fileSizeFormat(size: Int64) -> String {
        return ByteCountFormatter.string(fromByteCount: size, countStyle: .file)
    }
    
    static private func timeCalculate(_ time: Float) -> (hours: Int, minutes: Int, seconds: Int) {
        var totalSecond = time
        let decimalPlace = Int(totalSecond * 10) % 10
        if decimalPlace >= 5 {
            totalSecond += 1
        }
        let hours = Int(totalSecond / 3600)
        let minutes = Int(totalSecond / 60) % 60
        let seconds = Int(totalSecond.truncatingRemainder(dividingBy: 60))
        return (hours, minutes, seconds)
    }
    
    static func timeFormat(time: Float) -> String {
        let result = timeCalculate(time)
        if result.hours > 0 {
            return String(format: "%02i:%02i:%02i", arguments: [result.hours, result.minutes, result.seconds])
        } else {
            return String(format: "%02i:%02i", arguments: [result.minutes, result.seconds])
        }
    }
    
//    static func pathToURL(_ path: String) -> URL? {
//        guard var sPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil}
//        sPath = "file://\(sPath)"
//        return URL(string: sPath)
//    }
    
    // -------------------------------------------------- FILE FORMAT
    
    enum FileFormat {
        case AppleSupportVideoFormat
        case VLCSupportVideoFormat
        case SubRipSubtitleFormat
        case none
    }
    
    static let appleSupportVideoExtensions: [String] = ["m4v", "mov", "mp4"]
    static let vlcSupportVideoExtensions: [String] = ["3gp", "avi", "flv", "mkv", "wmv"]
    static let subtitleExtensions: [String] = ["srt"]
    
    static func whichFileFormat(fileExtension: String) -> FileFormat {
        if subtitleExtensions.contains(fileExtension.lowercased()) {
            return .SubRipSubtitleFormat
        } else if appleSupportVideoExtensions.contains(fileExtension.lowercased()) {
            return .AppleSupportVideoFormat
        } else if vlcSupportVideoExtensions.contains(fileExtension.lowercased()) {
            return .VLCSupportVideoFormat
        } else {
            return .none
        }
    }
    
    // --------------------------------------------------
    
    static var orientation: UIDeviceOrientation?
    static var deviceOrientation: UIDeviceOrientation?
    static var deviceOrientation2: UIDeviceOrientation?
    
    static func beginGeneratingDeviceOrientationNotifications() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(handleChangeOrientation), name:UIDevice.orientationDidChangeNotification, object:nil)
    }
    
    static func stopGeneratingDeviceOrientationNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc static func handleChangeOrientation() {
        orientation = UIDevice.current.orientation
        
        if orientation != .faceUp && orientation != .faceDown {
            deviceOrientation = orientation
        }
        
        if deviceOrientation == .landscapeRight {
            deviceOrientation2 = .landscapeRight
        } else {
            deviceOrientation2 = .landscapeLeft
        }
    }
    
    /// themeConfig, lockOriantation and startDocumentsFolderObserver oparation
    static func openApplication() {
        themeConfig()
        ControlData.shared.startDocumentsFolderObserver()
        if UIDevice.current.userInterfaceIdiom == .phone {
            AppUtility.lockOrientation(.portrait)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            AppUtility.lockOrientation(.all)
        }
        AppUtility.beginGeneratingDeviceOrientationNotifications()
    }
    
    static func closeApplication() {
        AppUtility.stopGeneratingDeviceOrientationNotifications()
    }
    
    static func openPlayer() {
        let a = AppUtility.deviceOrientation2!
        let b = AppUtility.deviceOrientation!
        AppUtility.lockOrientation(.landscape, andRotateTo: a)
        UIDevice.current.setValue(b.rawValue, forKey: "orientation")
    }
    
    static func closePlayer() {
        let b = AppUtility.deviceOrientation!
        if UIDevice.current.userInterfaceIdiom == .phone {
            AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
            UIDevice.current.setValue(b.rawValue, forKey: "orientation")
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            AppUtility.lockOrientation(.all, andRotateTo: b)
        }
    }
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    //UIInterfaceOrientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIDeviceOrientation) {
        self.lockOrientation(orientation)
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}
