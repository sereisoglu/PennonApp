//
//  Defaults.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 4.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

struct Defaults {
    
    static let themeKey = "theme"
    static let userSessionKey = "com.save.usersession"
    
    struct Model {
        var theme: String?
        
        init(_ theme: String) {
            self.theme = theme
        }
    }
    
    static var saveTheme = { (theme: String) in
        UserDefaults.standard.set(theme, forKey: userSessionKey)
    }
    
    static var getTheme = { _ -> Model in
        return Model(UserDefaults.standard.value(forKey: userSessionKey) as? String ?? "")
    }(())
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userSessionKey)
    }
}
