//
//  HomeController+NSFetchedResultsControllerDelegate.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 14.02.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import CoreData

extension HomeController: NSFetchedResultsControllerDelegate {
    
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        print("controllerWillChangeContent")
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            print("insert")
//            indexPathArray.append(newIndexPath!)
//            //collectionView.insertItems(at: [newIndexPath!])
//        case .delete:
//            print("delete")
//            indexPathArray.append(indexPath!)
//            //collectionView.deleteItems(at: [indexPath!])
//        case .update:
//            print("update")
//            indexPathArray.append(indexPath!)
//            //collectionView.reloadItems(at: [indexPath!])
//        case .move:
//            print("move")
//            collectionView.moveItem(at: indexPath!, to: newIndexPath!)
//        }
//    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //print("controllerDidChangeContent")
        self.collectionView.reloadData()
    }
    
    
}
