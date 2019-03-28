//
//  ControlData.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit
import CoreData

class ControlData {
    
    //Singleton
    static let shared = ControlData()
    private init() {
    }
    
    //Core data context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var pathArray = [Path]()
    private var videoArray = [Video]()
    private var subtitleArray = [Subtitle]()
    
    private var nVideoArray = [Video]()
    private var nSubtitleArray = [Subtitle]()
    private var tVideoArray = [Video]()
    private var tSubtitleArray = [Subtitle]()
    
    var getVideoArray: [Video] {
        return nVideoArray
    }
    var getSubtitleArray: [Subtitle] {
        return nSubtitleArray
    }
    var getTrashVideoArray: [Video] {
        return tVideoArray
    }
    var getTrashSubtitleArray: [Subtitle] {
        return tSubtitleArray
    }
    
    //MARK: - Control Data
    
    func controlData() {
        let currentPathUrlArray = fetchCoreData()
        let newPathUrlArray = fetchDocumentFolder()
        
        if currentPathUrlArray.count == 0 && newPathUrlArray.count == 0 {
            return
        } else if currentPathUrlArray.count == 0 {
            for item in newPathUrlArray {
                addPath(url: item)
            }
            return
        } else if newPathUrlArray.count == 0 {
            clearData()
            return
        }
        
        for item in newPathUrlArray {
            if let index = currentPathUrlArray.index(of: item) {
                if fileSize(url: item) != fileSize(url: currentPathUrlArray[index]) {
                    deletePath(url: currentPathUrlArray[index])
                    addPath(url: item)
                }
            } else {
                addPath(url: item)
            }
            
        }
        
        for item in currentPathUrlArray {
            if !(newPathUrlArray.contains(item)) {
                deletePath(url: item)
            }
        }
    }
    
    func fetchCoreData() -> [URL] {
        loadData()
        parseVideo()
        parseSubtitle()
        var tempPaths = [URL]()
        for item in pathArray {
            tempPaths.append(item.path!)
        }
        return tempPaths
    }
    
    func fetchDocumentFolder() -> [URL] {
        let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var tempPaths = [URL]()
        do {
            tempPaths = try FileManager.default.contentsOfDirectory(at: documentDirectoryUrl, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
        } catch {
            print(error.localizedDescription)
        }
        return tempPaths
    }
    
    //MARK: - CoreData
    
    private func loadData() {
        let request: NSFetchRequest<Path> = Path.fetchRequest()
        do {
            pathArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        let request2: NSFetchRequest<Video> = Video.fetchRequest()
        do {
            videoArray = try context.fetch(request2)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        let request3: NSFetchRequest<Subtitle> = Subtitle.fetchRequest()
        do {
            subtitleArray = try context.fetch(request3)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    private func clearData() {
        for item in pathArray {
            context.delete(item)
        }
        pathArray.removeAll()
        saveData()
        
        for item in videoArray {
            context.delete(item)
        }
        videoArray.removeAll()
        saveData()
        
        for item in subtitleArray {
            context.delete(item)
        }
        subtitleArray.removeAll()
        saveData()
    }
    
    func updateFile(url: URL, newValue: String, forKey: String) {
        if fileExtension(url: url) != "srt" {
            var i: Int = 0
            for item in videoArray {
                if item.path == url { break }
                i += 1
            }
            videoArray[i].setValue(newValue, forKey: forKey)
        } else {
            var i: Int = 0
            for item in subtitleArray {
                if item.path == url { break }
                i += 1
            }
            subtitleArray[i].setValue(newValue, forKey: forKey)
        }
        saveData()
    }
    
    func updateRemainingDuration(video: Video, duration: Double) {
        if video.isNew == true {
            video.setValue(false, forKey: "isNew")
        }
        var remainingDuration = video.duration - duration
        var remainingDurationFormat = "\(durationFormat(time: remainingDuration)) LEFT"
        
        if remainingDuration == 0.0 {
            remainingDurationFormat = "DONE"
            remainingDuration = video.duration
        }
        
        video.setValue(remainingDuration, forKey: "remainingDuration")
        video.setValue(remainingDurationFormat, forKey: "remainingDurationFormat")
        saveData()
    }
    
    private func addPath(url: URL) {
        let newPath = Path(context: context)
        newPath.path = url
        self.pathArray.append(newPath)
        
        saveData()
        
        let ext = fileExtension(url: url)
        if ext == "m4v" || ext == "mp4" || ext == "mov" {
            addVideo(url: url)
        } else if ext == "srt" {
            addSubtitle(url: url)
        }
    }
    
    private func deletePath(url: URL) {
        for item in pathArray {
            if item.path == url {
                
                context.delete(item)
                if let index = pathArray.index(of: item) {
                    pathArray.remove(at: index)
                }
            }
        }
        saveData()
        
        let ext = fileExtension(url: url)
        if ext == "m4v" || ext == "mp4" || ext == "mov" {
            deleteVideo(url: url)
        } else if ext == "srt" {
            deleteSubtitle(url: url)
        }
    }
    
    private func addVideo(url: URL) {
        let newVideo = Video(context: context)
        newVideo.path = url
        newVideo.folderName = "Videos"
        newVideo.fileName = fileName(url: url)
        newVideo.fileExtension = fileExtension(url: url)
        newVideo.size = fileSize(url: url)
        newVideo.sizeFormat = fileSizeFormat(url: url)
        newVideo.duration = videoDuration(url: url)
        newVideo.durationFormat = videoDurationFormat(url: url)
        newVideo.resolution = videoResolution(url: url)
        newVideo.thumbnail = videoThumbnail(url: url)
        newVideo.isNew = true
        newVideo.remainingDuration = -1.0
        newVideo.remainingDurationFormat = "-"
        self.videoArray.append(newVideo)
        self.saveData()
    }
    
    private func deleteVideo(url: URL) {
        for item in videoArray {
            if item.path == url {
                context.delete(item)
                if let index = videoArray.index(of: item) {
                    videoArray.remove(at: index)
                }
            }
        }
        saveData()
    }
    
    func parseVideo() {
        nVideoArray.removeAll()
        tVideoArray.removeAll()
        for item in videoArray {
            if item.folderName == "Videos" {
                nVideoArray.append(item)
            } else if item.folderName == "Trash" {
                tVideoArray.append(item)
            }
        }
    }
    
    private func addSubtitle(url: URL) {
        let newSubtitle = Subtitle(context: context)
        newSubtitle.path = url
        newSubtitle.folderName = "Subtitles"
        newSubtitle.fileName = fileName(url: url)
        newSubtitle.fileExtension = fileExtension(url: url)
        newSubtitle.size = fileSize(url: url)
        newSubtitle.sizeFormat = fileSizeFormat(url: url)
        self.subtitleArray.append(newSubtitle)
        saveData()
    }
    
    private func deleteSubtitle(url: URL) {
        for item in subtitleArray {
            if item.path == url {
                
                context.delete(item)
                if let index = subtitleArray.index(of: item) {
                    subtitleArray.remove(at: index)
                }
            }
        }
        saveData()
    }
    
    func parseSubtitle() {
        nSubtitleArray.removeAll()
        tSubtitleArray.removeAll()
        for item in subtitleArray {
            if item.folderName == "Subtitles" {
                nSubtitleArray.append(item)
            } else if item.folderName == "Trash" {
                tSubtitleArray.append(item)
            }
        }
    }
    
    private func saveData() {
        do {
            try self.context.save()
        } catch {
            print("Error saving context \(error)")
        }
        loadData()
        parseVideo()
        parseSubtitle()
    }
    
}
