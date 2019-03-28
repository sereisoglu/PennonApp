//
//  HomeController+Empty.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 5.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

extension HomeController {
    
    func setEmptyCollectionView() {
        if selectedFolderName != .Trash {
            let emptyHomeControllerView = EmptyHomeControllerView()
            emptyHomeControllerView.translatesAutoresizingMaskIntoConstraints = false
            emptyHomeControllerView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
            emptyHomeControllerView.heightAnchor.constraint(equalToConstant: self.view.bounds.height).isActive = true
            if selectedFolderName == .AllFiles {
                emptyHomeControllerView.descriptionLabel.text = "Your All Files folder is empty."
                emptyHomeControllerView.addButton.setTitle("ADD FILE", for: .normal)
            } else if selectedFolderName == .Videos {
                emptyHomeControllerView.descriptionLabel.text = "Your Videos folder is empty."
                emptyHomeControllerView.addButton.setTitle("ADD VIDEO", for: .normal)
            } else if selectedFolderName == .Subtitles {
                emptyHomeControllerView.descriptionLabel.text = "Your Subtitles folder is empty."
                emptyHomeControllerView.addButton.setTitle("ADD SUBTITLE", for: .normal)
            }
            emptyHomeControllerView.addButton.addTarget(self, action: #selector(handleEmptyButton), for: .touchDown)
            self.collectionView.backgroundView = emptyHomeControllerView
        } else {
            let trashEmptyHomeControllerView = TrashEmptyHomeControllerView()
            trashEmptyHomeControllerView.translatesAutoresizingMaskIntoConstraints = false
            trashEmptyHomeControllerView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
            trashEmptyHomeControllerView.heightAnchor.constraint(equalToConstant: self.view.bounds.height).isActive = true
            trashEmptyHomeControllerView.descriptionLabel.text = "Your Trash folder is empty."
            self.collectionView.backgroundView = trashEmptyHomeControllerView
        }
    }
    
    @objc private func handleEmptyButton() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let phoneSettingsController = PhoneSettingsController()
            present(phoneSettingsController, animated: true) {
                phoneSettingsController.openPhoneTutorialController()
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let settingsController = SettingsController()
            settingsController.modalPresentationStyle = .overFullScreen
            present(settingsController, animated: true) {
                settingsController.openTutorialController()
            }
        }
    }
    
//    func setNotEmptyCollectionView() {
//        collectionView.backgroundView = nil
//    }
}
