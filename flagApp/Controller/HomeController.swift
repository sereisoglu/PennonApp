//
//  HomeController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UICollectionViewController {
    
    var selectedFolderName: StaticFolderName = .AllFiles {
        didSet{
            navigationItem.title = selectedFolderName.rawValue
            self.collectionView.reloadData()
        }
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<File> = {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<File> = File.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "path", ascending: true, selector: #selector(NSString.caseInsensitiveCompare))
        ]
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        
        return frc
    }()
    
    lazy var fileFetchedResultsController: NSFetchedResultsController<File> = {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<File> = File.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "path", ascending: true, selector: #selector(NSString.caseInsensitiveCompare))
        ]
        
        var predicate = NSPredicate(format: "typeName != %@", "trash")
        
        request.predicate = predicate
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        
        return frc
    }()
    
    lazy var videoFetchedResultsController: NSFetchedResultsController<File> = {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<File> = File.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "path", ascending: true, selector: #selector(NSString.caseInsensitiveCompare))
        ]
        
        var predicate = NSPredicate(format: "typeName == %@", "video")
        
        request.predicate = predicate
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        
        return frc
    }()
    
    lazy var subtitleFetchedResultsController: NSFetchedResultsController<File> = {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<File> = File.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "path", ascending: true, selector: #selector(NSString.caseInsensitiveCompare))
        ]
        
        var predicate = NSPredicate(format: "typeName == %@", "subtitle")
        
        request.predicate = predicate
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        
        return frc
    }()
    
    lazy var trashFetchedResultsController: NSFetchedResultsController<File> = {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<File> = File.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "path", ascending: true, selector: #selector(NSString.caseInsensitiveCompare))
        ]
        
        var predicate = NSPredicate(format: "typeName == %@", "trash")
        
        request.predicate = predicate
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        
        return frc
    }()
    
    private var estimateWidth = UI_USER_INTERFACE_IDIOM() == .pad ? 250.0 : 180.0
    //private var estimateWidth = 160.0
    private var cellMarginSize = 16.0
    internal let reuseIdentifier = "Cell"
    public var mainController: MainController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make it responds to highlight state faster
        collectionView.delaysContentTouches = false
        
        collectionView?.contentInsetAdjustmentBehavior = .always
        
        collectionView.alwaysBounceVertical = true
        
        self.collectionView!.register(HomeCellView.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupGridView()
        setupNavigationBarItems()
        setUpTheming()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.setupGridView()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    public func setupGridView() {
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        flow.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    internal func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        return width
    }
    
}

extension HomeController: Themed {
    func applyTheme(_ theme: AppTheme) {
        collectionView.backgroundColor = theme.backgroundColor
        navigationController?.navigationBar.barTintColor = theme.backgroundColor
        navigationController?.navigationBar.tintColor = theme.secondaryColor
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: theme.primaryColor,
            NSAttributedString.Key.font: theme.header1Font
        ]
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: theme.primaryColor,
            NSAttributedString.Key.font: theme.custom1Font
        ]
    }
}
