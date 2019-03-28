//
//  MenuController+UITableViewDelegate.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 31.01.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

extension MenuController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainController = UIApplication.shared.keyWindow?.rootViewController as? MainController
        mainController!.closeMenu()
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                homeController.selectedFolderName = .AllFiles
            } else if indexPath.row == 1 {
                homeController.selectedFolderName = .Videos
            } else if indexPath.row == 2 {
                homeController.selectedFolderName = .Subtitles
            }
        } else {
            homeController.selectedFolderName = .Trash
        }
        
    }
}
