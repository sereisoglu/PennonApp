//
//  HomeController+UICollectionViewDataSource.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 31.01.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

extension HomeController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfItemsInSection: Int = 0
        
        switch selectedFolderName {
        case .AllFiles:
            numberOfItemsInSection = (fileFetchedResultsController.fetchedObjects?.count)!
        case .Videos:
            numberOfItemsInSection = (videoFetchedResultsController.fetchedObjects?.count)!
        case .Subtitles:
            numberOfItemsInSection = (subtitleFetchedResultsController.fetchedObjects?.count)!
        case .Trash:
            numberOfItemsInSection = (trashFetchedResultsController.fetchedObjects?.count)!
        }
        
        if numberOfItemsInSection == 0 {
            setEmptyCollectionView()
        } else {
            //setNotEmptyCollectionView()
            self.collectionView.backgroundView = nil
        }
        
        return numberOfItemsInSection
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCellView
        cell.homeController = self
        switch selectedFolderName {
        case .AllFiles:
            cell.file = fileFetchedResultsController.object(at: indexPath)
        case .Videos:
            cell.file = videoFetchedResultsController.object(at: indexPath)
        case .Subtitles:
            cell.file = subtitleFetchedResultsController.object(at: indexPath)
        case .Trash:
            cell.file = trashFetchedResultsController.object(at: indexPath)
        }
        return cell
    }
}
