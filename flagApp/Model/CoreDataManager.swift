//
//  CoreDataManager.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 13.02.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    private init() {}
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func fetchFiles() -> [File] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<File>(entityName: "File")
        do {
            let files = try context.fetch(fetchRequest)
            return files
        } catch let fetchErr {
            print("Failed to fetch companies:", fetchErr)
            return []
        }
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            print("CORE DATA SAVE CONTEXT")
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private var timer: Timer?
    private var timerCount: Int = 5

    var save: Bool = false {
        didSet {
            if timer == nil {
                DispatchQueue.main.async {
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.saving), userInfo: nil, repeats: true)
                }
            }
        }
    }
    
    // TODO: burada save'i degistirirsek yukarisi tetiklenir mi?
    @objc private func saving() {
        if save {
            save = false
            timerCount = 5
            saveContext()
        } else {
            if timerCount <= 0 && timer != nil {
                timer!.invalidate()
                timer = nil
            }
            timerCount -= 1
        }
    }
}
