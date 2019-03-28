//
//  HomeController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit
import AVKit

private let reuseIdentifier = "Cell"

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var estimateWidth = 160.0
    private let iconSize: CGFloat = 30.0
    private var cellMarginSize = 16.0
    private var popupController: PopupController!
    var numberOfItemsInSection: Int = ControlData.shared.getVideoArray.count + ControlData.shared.getSubtitleArray.count
    private var selectedFolder: String = "All Files"
    
    private var changeDocumentFolderCount: Int = 0
    private var observer: DirectoryObserver!
    private var timer: Timer!
    
    @objc func updateCounting(){
        if changeDocumentFolderCount != 0 {
            self.changeDocumentFolderCount -= 1
            DispatchQueue.main.async {
                ControlData.shared.controlData()
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .always
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
        
        observer = DirectoryObserver(URL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!) {
            self.changeDocumentFolderCount += 1
        }
        
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        
        self.collectionView!.register(HomeCellView.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupGridView()
        setupNavigationBarItems()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.setupGridView()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setupGridView() {
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        flow.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func setupPopupController(fileUrl: URL,
                              fileName: String,
                              folderName: String,
                              fileExtension: String,
                              fileSize: String,
                              thumbnail: UIImage = UIColor.init(white: 0, alpha: 0.2).image(),
                              videoDuration: String = "",
                              videoResolution: String = ""
        ) {
        
        popupController = PopupController(homeController: self,
                                          fileUrl: fileUrl,
                                          fileName: fileName,
                                          folderName: folderName,
                                          fileExtension: fileExtension,
                                          fileSize: fileSize,
                                          thumbnail: thumbnail,
                                          videoDuration: videoDuration,
                                          videoResolution: videoResolution)
        
        let cellPopupControllerView: UIView = popupController.view
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(cellPopupControllerView)
        self.addChild(popupController)
        
        NSLayoutConstraint.activate([
            cellPopupControllerView.topAnchor.constraint(equalTo: mainWindow!.topAnchor),
            cellPopupControllerView.bottomAnchor.constraint(equalTo: mainWindow!.bottomAnchor),
            cellPopupControllerView.trailingAnchor.constraint(equalTo: mainWindow!.trailingAnchor),
            cellPopupControllerView.leadingAnchor.constraint(equalTo: mainWindow!.leadingAnchor)
            ])
        
        cellPopupControllerView.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            self.popupController.view.alpha = 1
        })
    }
    
    func closePopupController() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            self.popupController.view.alpha = 0
        }) { (completion) in
            if self.popupController != nil {
                self.popupController.dismiss(animated: true)
                self.popupController.view.removeFromSuperview()
                self.popupController.removeFromParent()
            }
        }
    }
    
    func didSelectMenuItem(index: Int) {
        switch index {
        case 0:
            selectedFolder = "All Files"
            numberOfItemsInSection = ControlData.shared.getVideoArray.count + ControlData.shared.getSubtitleArray.count
        case 1:
            selectedFolder = "Videos"
            numberOfItemsInSection = ControlData.shared.getVideoArray.count
        case 2:
            selectedFolder = "Subtitles"
            numberOfItemsInSection = ControlData.shared.getSubtitleArray.count
        case 3:
            selectedFolder = "Trash"
            numberOfItemsInSection = ControlData.shared.getTrashVideoArray.count + ControlData.shared.getTrashSubtitleArray.count
        default:
            print("error")
            selectedFolder = "All Files"
            numberOfItemsInSection = ControlData.shared.getVideoArray.count + ControlData.shared.getSubtitleArray.count
        }
        navigationItem.title = selectedFolder
        self.collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if ControlData.shared.getVideoArray.count > indexPath.item && (selectedFolder == "All Files" || selectedFolder == "Videos") {
            if ControlData.shared.videoDuration(url: ControlData.shared.getVideoArray[indexPath.item].path!) != 0.0 {
                var viewController: PlayerController!
                let video: Video = ControlData.shared.getVideoArray[indexPath.item]
                
                //UPDATE
                video.thumbnail = ControlData.shared.videoThumbnail(url: video.path!)
                video.duration = ControlData.shared.videoDuration(url: video.path!)
                video.durationFormat = ControlData.shared.videoDurationFormat(url: video.path!)
                video.size = ControlData.shared.fileSize(url: video.path!)
                video.sizeFormat = ControlData.shared.fileSizeFormat(url: video.path!)
                video.resolution = ControlData.shared.videoResolution(url: video.path!)
                
                for item in ControlData.shared.getSubtitleArray {
                    if video.fileName == item.fileName {
                        viewController = PlayerController(video: video, subtitle: item)
                        break;
                    }
                }
                if viewController == nil {
                    viewController = PlayerController(video: video)
                }
                viewController.homeController = self
                
                let mainWindow = UIApplication.shared.keyWindow
                mainWindow?.rootViewController = viewController
                //present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    var mainController: MainController!
    
    func closePlayer(viewController: PlayerController) {
        
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.rootViewController = mainController
        
        viewController.dismiss(animated: true)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            AppUtility.lockOrientation(.all)
        }

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}


// UICollectionViewDataSource
extension HomeController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        ControlData.shared.controlData()
        switch selectedFolder {
        case "All Files":
            numberOfItemsInSection = ControlData.shared.getVideoArray.count + ControlData.shared.getSubtitleArray.count
        case "Videos":
            numberOfItemsInSection = ControlData.shared.getVideoArray.count
        case "Subtitles":
            numberOfItemsInSection = ControlData.shared.getSubtitleArray.count
        case "Trash":
            numberOfItemsInSection = ControlData.shared.getTrashVideoArray.count + ControlData.shared.getTrashSubtitleArray.count
        default:
            print("error")
            numberOfItemsInSection = ControlData.shared.getVideoArray.count + ControlData.shared.getSubtitleArray.count
        }
        
        if numberOfItemsInSection == 0 {
            let button = UIButton()
            button.addTarget(self, action: #selector(handleRightNavItem), for: .touchUpInside)
            switch selectedFolder {
            case "All Files":
                self.collectionView.setEmptyCollectionView(labelText: "Your All Files\nfolder is empty.", buttonIsHide: false, buttonText: "Add File", button: button)
            case "Videos":
                self.collectionView.setEmptyCollectionView(labelText: "Your Videos\nfolder is empty.", buttonIsHide: false, buttonText: "Add Video", button: button)
            case "Subtitles":
                self.collectionView.setEmptyCollectionView(labelText: "Your Subtitles\nfolder is empty.", buttonIsHide: false, buttonText: "Add Subtitle", button: button)
            case "Trash":
                self.collectionView.setEmptyCollectionView(labelText: "Your Trash\nfolder is empty.", buttonIsHide: true)
            default:
                print("error")
                self.collectionView.setEmptyCollectionView(labelText: "Your All Files\nfolder is empty.", buttonIsHide: false, buttonText: "Add File", button: button)
            }
        } else {
            //self.collectionView.setNotEmptyCollectionView()
            self.collectionView.backgroundView = nil
        }
        
        
        return numberOfItemsInSection
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCellView
        cell.homeController = self
        
        //ALL FILES
        if selectedFolder == "All Files" {
            let videoArray: [Video] = ControlData.shared.getVideoArray
            let subtitleArray: [Subtitle] = ControlData.shared.getSubtitleArray
            
            if videoArray.count > indexPath.item {
                var thumbnailImage = UIImage()
                if let data = videoArray[indexPath.item].thumbnail {
                    if let image = UIImage(data: data) {
                        thumbnailImage = image
                    }
                }
                cell.setCell(fileUrl: videoArray[indexPath.item].path!,
                             fileName: videoArray[indexPath.item].fileName!,
                             folderName: videoArray[indexPath.item].folderName!,
                             fileExtension: videoArray[indexPath.item].fileExtension!,
                             fileSize: videoArray[indexPath.item].sizeFormat!,
                             isNew: videoArray[indexPath.item].isNew,
                             thumbnail: thumbnailImage,
                             videoDuration: videoArray[indexPath.item].durationFormat!,
                             videoResolution: videoArray[indexPath.item].resolution!,
                             videoRemainingDuration: videoArray[indexPath.item].remainingDurationFormat!)
            } else {
                let index = indexPath.item - videoArray.count
                cell.setCell(fileUrl: subtitleArray[index].path!,
                             fileName: subtitleArray[index].fileName!,
                             folderName: subtitleArray[index].folderName!,
                             fileExtension: subtitleArray[index].fileExtension!,
                             fileSize: subtitleArray[index].sizeFormat!)
            }
            //VIDEOS
        } else if selectedFolder == "Videos" {
            let videoArray = ControlData.shared.getVideoArray
            var thumbnailImage = UIImage()
            if let image = UIImage(data: videoArray[indexPath.item].thumbnail!) {
                thumbnailImage = image
            }
            cell.setCell(fileUrl: videoArray[indexPath.item].path!,
                         fileName: videoArray[indexPath.item].fileName!,
                         folderName: videoArray[indexPath.item].folderName!,
                         fileExtension: videoArray[indexPath.item].fileExtension!,
                         fileSize: videoArray[indexPath.item].sizeFormat!,
                         isNew: videoArray[indexPath.item].isNew,
                         thumbnail: thumbnailImage,
                         videoDuration: videoArray[indexPath.item].durationFormat!,
                         videoResolution: videoArray[indexPath.item].resolution!,
                         videoRemainingDuration: videoArray[indexPath.item].remainingDurationFormat!)
            //SUBTITLES
        } else if selectedFolder == "Subtitles" {
            let subtitleArray = ControlData.shared.getSubtitleArray
            cell.setCell(fileUrl: subtitleArray[indexPath.item].path!,
                         fileName: subtitleArray[indexPath.item].fileName!,
                         folderName: subtitleArray[indexPath.item].folderName!,
                         fileExtension: subtitleArray[indexPath.item].fileExtension!,
                         fileSize: subtitleArray[indexPath.item].sizeFormat!)
            //TRASH
        } else if selectedFolder == "Trash" {
            let videoTrashArray = ControlData.shared.getTrashVideoArray
            let subtitleTrashArray = ControlData.shared.getTrashSubtitleArray
            
            if videoTrashArray.count > indexPath.item {
                var thumbnailImage = UIImage()
                if let image = UIImage(data: videoTrashArray[indexPath.item].thumbnail!) {
                    thumbnailImage = image
                }
                cell.setCell(fileUrl: videoTrashArray[indexPath.item].path!,
                             fileName: videoTrashArray[indexPath.item].fileName!,
                             folderName: videoTrashArray[indexPath.item].folderName!,
                             fileExtension: videoTrashArray[indexPath.item].fileExtension!,
                             fileSize: videoTrashArray[indexPath.item].sizeFormat!,
                             isNew: videoTrashArray[indexPath.item].isNew,
                             thumbnail: thumbnailImage,
                             videoDuration: videoTrashArray[indexPath.item].durationFormat!,
                             videoResolution: videoTrashArray[indexPath.item].resolution!,
                             videoRemainingDuration: videoTrashArray[indexPath.item].remainingDurationFormat!)
            } else {
                let index = indexPath.item - videoTrashArray.count
                cell.setCell(fileUrl: subtitleTrashArray[index].path!,
                             fileName: subtitleTrashArray[index].fileName!,
                             folderName: subtitleTrashArray[index].folderName!,
                             fileExtension: subtitleTrashArray[index].fileExtension!,
                             fileSize: subtitleTrashArray[index].sizeFormat!)
            }
        }
        
        return cell
    }
    
}

// UICollectionViewDelegateFlowLayout
extension HomeController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        let height = (width * 9) / 16 + 40
        return CGSize(width: width, height: height)
    }
    
    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        return width
    }
}

extension HomeController {
    func setupNavigationBarItems() {
        setupSettings()
        setupLeftNavItem()
        setupRightNavItems()
    }
    
    private func setupSettings() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "All Files"
        
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.init(white: 0, alpha: 0.8) ,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.init(white: 0, alpha: 0.8) ,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)]
    }
    
    private func setupLeftNavItem() {
        
        let leftBarButton = UIButton()
        leftBarButton.setImage(#imageLiteral(resourceName: "menu-48").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        leftBarButton.tintColor = UIColor.init(white: 0, alpha: 0.4)
        leftBarButton.addTarget(self, action: #selector(handleLeftNavItem), for: .touchUpInside)
        let leftbarItem = UIBarButtonItem(customView: leftBarButton)
        
        let width = leftbarItem.customView?.widthAnchor.constraint(equalToConstant: iconSize)
        width?.isActive = true
        let height = leftbarItem.customView?.heightAnchor.constraint(equalToConstant: iconSize)
        height?.isActive = true
        
        self.navigationItem.leftBarButtonItem = leftbarItem
    }
    
    @objc func handleLeftNavItem() {
        (UIApplication.shared.keyWindow?.rootViewController as? MainController)?.openMenu()
    }
    
    private func setupRightNavItems() {
        
        let rightBarButton = UIButton()
        rightBarButton.setImage(#imageLiteral(resourceName: "info-29"), for: .normal)
        rightBarButton.alpha = 0.4
        rightBarButton.addTarget(self, action: #selector(handleRightNavItem), for: .touchUpInside)
        let rightbarItem = UIBarButtonItem(customView: rightBarButton)
        
        let width = rightbarItem.customView?.widthAnchor.constraint(equalToConstant: iconSize)
        width?.isActive = true
        let height = rightbarItem.customView?.heightAnchor.constraint(equalToConstant: iconSize)
        height?.isActive = true
        
        self.navigationItem.rightBarButtonItem = rightbarItem
    }
    
    @objc func handleRightNavItem() {
        let appInfoView = AppInfoView()
        appInfoView.translatesAutoresizingMaskIntoConstraints = false
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(appInfoView)
        
        NSLayoutConstraint.activate([
            appInfoView.topAnchor.constraint(equalTo: (mainWindow?.topAnchor)!),
            appInfoView.bottomAnchor.constraint(equalTo: (mainWindow?.bottomAnchor)!),
            appInfoView.trailingAnchor.constraint(equalTo: (mainWindow?.trailingAnchor)!),
            appInfoView.leadingAnchor.constraint(equalTo: (mainWindow?.leadingAnchor)!),
            ])
        
        appInfoView.homeController = self
        appInfoView.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            appInfoView.alpha = 1
        })
    }
    
    func closeAppInfoController(appInfoView: AppInfoView) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            appInfoView.alpha = 0
        }) { (completion) in
            appInfoView.removeFromSuperview()
        }
    }
}
