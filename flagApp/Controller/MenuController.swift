//
//  MenuController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

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

private let reuseIdentifier = "Cell"

class MenuController: UITableViewController {
    
    var homeController: HomeController!
    var tableViewData = [HeaderModel]()
    private var toggleArrow: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MenuCellView.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
        
        setupNavigationBarItems()
        
        tableViewData = [HeaderModel(icon: #imageLiteral(resourceName: "folder-29"), title: "All Files", opened: false, sectionData: [CellModel(icon: #imageLiteral(resourceName: "video-29"), title: "Videos"), CellModel(icon: #imageLiteral(resourceName: "subtitle-29"), title: "Subtitles")]),
                         HeaderModel(icon: #imageLiteral(resourceName: "trash-29"), title: "Trash", opened: false, sectionData: [])]
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MenuCellView
        cell.menuController = self
        if indexPath.row == 0 {
            cell.iconViewLeadingAnchor.constant = 20
            cell.nameLabel.text = tableViewData[indexPath.section].title
            cell.iconView.image = tableViewData[indexPath.section].icon
            if toggleArrow == true {
                self.toggleArrow = false
                cell.animateButton(tableViewData[indexPath.section].opened)
            }
            
            if tableViewData[indexPath.section].sectionData.isEmpty {
                cell.arrowButton.isHidden = true
            } else {
                cell.arrowButton.isHidden = false
            }
        } else {
            cell.nameLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1].title
            cell.iconView.image = tableViewData[indexPath.section].sectionData[indexPath.row - 1].icon
            cell.iconViewLeadingAnchor.constant = 49
            cell.arrowButton.isHidden = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainController = UIApplication.shared.keyWindow?.rootViewController as? MainController
        mainController!.closeMenu()
        var index = 0
        if indexPath.row == 0 {
            if indexPath.section == 0 { index = indexPath.row } else { index = 3 }
        } else {
            index = indexPath.row
        }
        homeController.didSelectMenuItem(index: index)
    }
    
    func reloadTableSection(cell: UITableViewCell) {
        self.toggleArrow = true
        if let indexPathCell = tableView.indexPath(for: cell) {
            tableViewData[indexPathCell.section].opened = !(tableViewData[indexPathCell.section].opened)
            let sections = IndexSet.init(integer: indexPathCell.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
}

extension MenuController {
    func setupNavigationBarItems() {
        setupSettings()
        setupLeftNavItem()
    }
    
    private func setupSettings() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.title = "FLAG"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.init(white: 0, alpha: 0.8) ,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)]
    }
    
    private func setupLeftNavItem() {
        let leftBarButton = UIButton()
        leftBarButton.setImage(#imageLiteral(resourceName: "info-29"), for: .normal)
        leftBarButton.alpha = 0.8
        leftBarButton.addTarget(self, action: #selector(handleLeftNavItems), for: .touchUpInside)
        let leftbarItem = UIBarButtonItem(customView: leftBarButton)
        self.navigationItem.leftBarButtonItem = leftbarItem
    }
    
    @objc func handleLeftNavItems() {
        let infoView = InfoView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(infoView)
        
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: (mainWindow?.topAnchor)!),
            infoView.bottomAnchor.constraint(equalTo: (mainWindow?.bottomAnchor)!),
            infoView.trailingAnchor.constraint(equalTo: (mainWindow?.trailingAnchor)!),
            infoView.leadingAnchor.constraint(equalTo: (mainWindow?.leadingAnchor)!),
            ])
        
        infoView.menuController = self
        infoView.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            infoView.alpha = 1
        })
    }
    
    func closeInfoController(infoView: InfoView) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
            infoView.alpha = 0
        }) { (completion) in
            infoView.removeFromSuperview()
        }
    }
}
