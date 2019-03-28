//
//  MenuController+UINavigationController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 31.01.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

extension MenuController {
    
    func setupNavigationBarItems() {
        setupSettings()
        setupLeftNavItem()
    }
    
    private func setupSettings() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "FLAG"
    }
    
    private func setupLeftNavItem() {
        let leftBarButton = UIButton()
        leftBarButton.setImage(#imageLiteral(resourceName: "settings"), for: .normal)
        leftBarButton.imageView?.contentMode = .scaleAspectFit
        leftBarButton.addTarget(self, action: #selector(handleLeftNavItems), for: .touchDown)
        
        let leftbarItem = UIBarButtonItem(customView: leftBarButton)
        leftbarItem.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        leftbarItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.navigationItem.leftBarButtonItem = leftbarItem
    }
    
    @objc func handleLeftNavItems() {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let phoneSettingsController = PhoneSettingsController()
            self.present(phoneSettingsController, animated: true, completion: nil)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let settingsController = SettingsController()
            settingsController.modalPresentationStyle = .overFullScreen
            self.present(settingsController, animated: true, completion: nil)
        }
    }
    
}
