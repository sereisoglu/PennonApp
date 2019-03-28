//
//  ControlData.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 13.02.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit
import CoreData

class ControlData {
    
    private init() {}
    static let shared = ControlData()
    
    private var coreDataFileArray = [File]()
    private let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private var documentDirectoryObserver: DirectoryObserver!
    
    public func startDocumentsFolderObserver() {
        control()
        documentDirectoryObserver = DirectoryObserver(URL: documentDirectoryUrl, block: {
            self.control()
        })
    }
    
    private func control() {
        let coreDataFilePathArray = loadCoreDataFilePathArray()
        let documentFolderFilePathArray = loadDocumentFolderFilePathArray()
        
//        if coreDataFilePathArray.count == 0 && documentFolderFilePathArray.count == 0 {
//            return
//        } else if coreDataFilePathArray.count == 0 {
//            createFiles(paths: documentFolderFilePathArray)
//            CoreDataManager.shared.saveContext()
//            return
//        } else if documentFolderFilePathArray.count == 0 {
//            deleteFiles()
//            return
//        }
        
        for item in documentFolderFilePathArray {
            if let index = coreDataFilePathArray.firstIndex(of: item) {
                if AppUtility.fileSize(path: item) != AppUtility.fileSize(path: coreDataFilePathArray[index]) {
                    deleteFile(file: self.coreDataFileArray[index])
                    createFile(path: item)
                }
            } else {
                createFile(path: item)
            }
        }
        
        for (index,item) in coreDataFilePathArray.enumerated() {
            if !(documentFolderFilePathArray.contains(item)) {
                deleteFile(file: self.coreDataFileArray[index])
            }
        }
        
        CoreDataManager.shared.save = true
    }
    
    //TODO: Bu surekli siser.
    var videoFeaturesArray: [VLCVideoFeatures] = []
    
    func createVideo(file: File) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let video = Video(context: context)
        file.video = video
        if AppUtility.whichFileFormat(fileExtension: file.fileExtension!) == .AppleSupportVideoFormat {
            AVVideoFeatures.aaa(file: file)
        } else {
            videoFeaturesArray.append(VLCVideoFeatures(file: file))
        }
        video.isDone = false
        video.position = 0.0
    }

    func createSubtitle() -> Subtitle {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let subtitle = Subtitle(context: context)
        subtitle.encoding = Int64(String.Encoding.windowsCP1254.rawValue)
        return subtitle
    }
    
//    func createFiles(paths: [String]) {
//        paths.forEach { (path) in
//            createFile(path: path)
//        }
//    }
    
    func deleteFile(file: File) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(file)
    }
    
//    func deleteFiles() {
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: File.fetchRequest())
//        do {
//            try context.execute(batchDeleteRequest)
//        } catch let delErr {
//            print("Failed to delete objects from Core Data:", delErr)
//        }
//    }
    
    private func loadCoreDataFilePathArray() -> [String] {
        coreDataFileArray = CoreDataManager.shared.fetchFiles()
        var coreDataFilePathArray = [String]()
        coreDataFileArray.forEach { (file) in
            coreDataFilePathArray.append(file.path!)
        }
        return coreDataFilePathArray
    }
    
    func fetchDocumentFolder() -> [URL] {
        do {
            let tempPaths = try FileManager.default.contentsOfDirectory(at: documentDirectoryUrl, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            return tempPaths
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    private func loadDocumentFolderFilePathArray() -> [String] {
        let files = fetchDocumentFolder()
        var filesPath = [String]()
        files.forEach { (file) in
            if AppUtility.whichFileFormat(fileExtension: file.pathExtension) != .none {
                filesPath.append(file.path)
            }
        }
        return filesPath
    }
    
    private var observers: [DirectoryObserver2] = []
    
    public func createFile(path: String) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let file = File(context: context)
        file.fileExtension = AppUtility.fileExtension(path: path)
        file.typeName = (AppUtility.whichFileFormat(fileExtension: file.fileExtension!) != .SubRipSubtitleFormat) ? "video" : "subtitle"
        file.isNew = true
        file.name = AppUtility.fileName(path: path)
        file.path = path
        file.size = AppUtility.fileSize(path: path)
        file.thumbnail = UIColor.init(white: 0, alpha: 0.2).image().pngData()
        file.isReady = false
        if file.size == 0 {
            let observer = DirectoryObserver2(URL: URL(fileURLWithPath: path), block: {
                file.size = AppUtility.fileSize(path: path)
                if file.size != 0 {
                    self.ttt(file: file)
                    CoreDataManager.shared.save = true
                }
            })
            observers.append(observer)
        } else {
            ttt(file: file)
        }
    }
    
    func ttt(file: File) {
        if AppUtility.whichFileFormat(fileExtension: file.fileExtension!) != .SubRipSubtitleFormat {
            createVideo(file: file)
        } else {
            file.isReady = true
            file.subtitle = createSubtitle()
        }
    }
    
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
