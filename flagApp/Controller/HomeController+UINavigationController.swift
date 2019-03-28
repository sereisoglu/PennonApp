//
//  HomeController+UINavigationController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 31.01.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

extension HomeController {
    
    internal func setupNavigationBarItems() {
        setupSettings()
        setupLeftNavItem()
        //setupRightNavItems()
    }
    
    private func setupSettings() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "All Files"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupLeftNavItem() {
        
        let leftBarButton = UIButton()
        leftBarButton.setImage(#imageLiteral(resourceName: "menu_2"), for: .normal)
        leftBarButton.addTarget(self, action: #selector(handleLeftNavItem), for: .touchDown)
        
        let leftbarItem = UIBarButtonItem(customView: leftBarButton)
        leftbarItem.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        leftbarItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.navigationItem.leftBarButtonItem = leftbarItem
    }
    
    @objc private func handleLeftNavItem() {
        (UIApplication.shared.keyWindow?.rootViewController as? MainController)?.openMenu()
    }
    
//    private func setupRightNavItems() {
//
//        let rightBarButton = UIButton()
//        rightBarButton.setImage(#imageLiteral(resourceName: "info"), for: .normal)
//        rightBarButton.addTarget(self, action: #selector(handleRightNavItem), for: .touchDown)
//        let rightbarItem = UIBarButtonItem(customView: rightBarButton)
//
//        let width = rightbarItem.customView?.widthAnchor.constraint(equalToConstant: iconSize)
//        width?.isActive = true
//        let height = rightbarItem.customView?.heightAnchor.constraint(equalToConstant: iconSize)
//        height?.isActive = true
//
//        self.navigationItem.rightBarButtonItem = rightbarItem
//    }
//
//    @objc internal func handleRightNavItem() {
//    }
    
}
