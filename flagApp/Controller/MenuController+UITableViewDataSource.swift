//
//  MenuController+UITableViewDataSource.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 31.01.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

extension MenuController {
    
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
        cell.selectionStyle = .none
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
}
