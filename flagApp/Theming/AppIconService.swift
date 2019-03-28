//
//  AppIconService.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 4.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit

class AppIconService {
    
    enum AppIcon: String {
        case iconDefault
        case iconDarkPhone
        case iconDarkPad
    }
    
    static func changeAppIcon(to appIcon: AppIcon) {
        let appIconValue: String? = appIcon == .iconDefault ? nil : appIcon.rawValue
        UIApplication.shared.setAlternateIconName(appIconValue)
    }
}
