//
//  MenuController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

enum StaticFolderName: String {
    case AllFiles = "All Files"
    case Videos
    case Subtitles
    case Trash
}

struct HeaderModel {
    var icon: UIImage
    var title: String
    var opened: Bool
    var sectionData: [CellModel]
}

struct CellModel {
    var icon: UIImage
    var title: String
}

class MenuController: UITableViewController {
    
    internal let reuseIdentifier = "Cell"
    internal var tableViewData = [HeaderModel]()
    internal var toggleArrow: Bool = false
    
    public var homeController: HomeController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MenuCellView.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        
        setupNavigationBarItems()
        
        tableViewData = [
            HeaderModel(icon: #imageLiteral(resourceName: "folder"), title: "All Files", opened: false, sectionData: [
                CellModel(icon: #imageLiteral(resourceName: "video"), title: "Videos"),
                CellModel(icon: #imageLiteral(resourceName: "subtitle"), title: "Subtitles")
                ]),
            HeaderModel(icon: #imageLiteral(resourceName: "trash"), title: "Trash", opened: false, sectionData: [])
        ]
        
        setUpTheming()
    }
    
    public func reloadTableSection(cell: UITableViewCell) {
        self.toggleArrow = true
        if let indexPathCell = tableView.indexPath(for: cell) {
            tableViewData[indexPathCell.section].opened = !(tableViewData[indexPathCell.section].opened)
            let sections = IndexSet.init(integer: indexPathCell.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
}

extension MenuController: Themed {
    func applyTheme(_ theme: AppTheme) {
        tableView.backgroundColor = theme.backgroundColor
        
        navigationController?.navigationBar.barTintColor = theme.backgroundColor
        navigationController?.navigationBar.tintColor = theme.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: theme.primaryColor,
            NSAttributedString.Key.font: theme.custom1Font
        ]
    }
}
