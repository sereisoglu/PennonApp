//
//  HomeController+UICollectionViewDelegate.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 31.01.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

extension HomeController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let file: File
        switch selectedFolderName {
        case .AllFiles:
            file = fileFetchedResultsController.object(at: indexPath)
        case .Videos:
            file = videoFetchedResultsController.object(at: indexPath)
        case .Subtitles:
            file = subtitleFetchedResultsController.object(at: indexPath)
        case .Trash:
            file = trashFetchedResultsController.object(at: indexPath)
        }
        
        if file.isReady {
            if AppUtility.whichFileFormat(fileExtension: file.fileExtension!) != .SubRipSubtitleFormat && file.typeName != "trash" && !file.isNew {
                openVideoPlayer(file: file)
            } else {
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    let phoneDetailViewController = PhoneDetailController(homeController: self, file: file)
                    self.present(phoneDetailViewController, animated: true, completion: nil)
                } else if UIDevice.current.userInterfaceIdiom == .pad {
                    let detailViewController = DetailController(homeController: self, file: file)
                    detailViewController.modalPresentationStyle = .overFullScreen
                    self.present(detailViewController, animated: false, completion: nil)
                }
                
            }
        }
        
    }
    
    public func openVideoPlayer(file: File) {
        var playerController: PlayerController
        if AppUtility.whichFileFormat(fileExtension: file.fileExtension!) == .AppleSupportVideoFormat {
            playerController = AVPlayerController(video: file)
        } else {
            playerController = VLCPlayerController(video: file)
        }
        playerController.homeController = self
        present(playerController, animated: false, completion: nil)
    }
    
}
