//
//  HomeController+UICollectionViewDelegateFlowLayout.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 31.01.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        let height = (width * 9) / 16 + 40
        return CGSize(width: width, height: height)
    }
}
