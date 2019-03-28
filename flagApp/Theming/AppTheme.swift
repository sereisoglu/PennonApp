//
//  AppTheme.swift
//  Night Mode
//
//  Created by Michael on 01/04/2018.
//  Copyright © 2018 Late Night Swift. All rights reserved.
//

import UIKit

struct AppTheme {
    var statusBarStyle: UIStatusBarStyle
    var blurEffectStyle: UIBlurEffect.Style
    var collectionViewCellBlurEffectStyle: UIBlurEffect.Style
    
    var primaryColor: UIColor
    var secondaryColor: UIColor
    var tertiaryColor: UIColor
    var backgroundColor: UIColor
    var buttonBackgroundColor: UIColor
    var shadowColor: UIColor
    var collectionViewCellColor: UIColor
    var activityIndicatorColor: UIColor
    
    var header1Font: UIFont
    var header2Font: UIFont
    var header2SemiFont: UIFont
    var paragraph1Font: UIFont
    var paragraph2Font: UIFont
    var custom1Font: UIFont
    var custom2Font: UIFont
    var custom3Font: UIFont
    var overflowFont: UIFont
}

extension AppTheme {
    //iPad +
    static let lightPadPlus = AppTheme(
        statusBarStyle: .default,
        blurEffectStyle: .light,
        collectionViewCellBlurEffectStyle: .light,
        
        primaryColor: UIColor.init(white: 0.2, alpha: 1),
        secondaryColor: UIColor.init(white: 0.6, alpha: 1),
        tertiaryColor: UIColor.init(white: 0.8, alpha: 1),
        backgroundColor: UIColor.init(white: 1, alpha: 1),
        buttonBackgroundColor: UIColor.init(white: 0.9, alpha: 1),
        shadowColor: UIColor.init(white: 0, alpha: 1),
        collectionViewCellColor: UIColor.init(white: 1, alpha: 1),
        activityIndicatorColor: UIColor.init(white: 0, alpha: 1),
        
        header1Font: UIFont.systemFont(ofSize: 35, weight: .bold),
        header2Font: UIFont.systemFont(ofSize: 30, weight: .bold),
        header2SemiFont: UIFont.systemFont(ofSize: 30, weight: .semibold),
        paragraph1Font: UIFont.systemFont(ofSize: 16, weight: .bold),
        paragraph2Font: UIFont.systemFont(ofSize: 14, weight: .bold),
        custom1Font: UIFont.systemFont(ofSize: 20, weight: .bold),
        custom2Font: UIFont.systemFont(ofSize: 18, weight: .semibold),
        custom3Font: UIFont.systemFont(ofSize: 10, weight: .bold),
        overflowFont: UIFont.systemFont(ofSize: 16, weight: .bold)
    )
    
    static let darkPadPlus = AppTheme(
        statusBarStyle: .lightContent,
        blurEffectStyle: .dark,
        collectionViewCellBlurEffectStyle: .light,
        
        primaryColor: UIColor.init(white: 0.8, alpha: 1),
        secondaryColor: UIColor.init(white: 0.4, alpha: 1),
        tertiaryColor: UIColor.init(white: 0.2, alpha: 1),
        backgroundColor: UIColor.init(white: 0.1, alpha: 1),
        buttonBackgroundColor: UIColor.init(white: 0.15, alpha: 1),
        shadowColor: UIColor.init(white: 1, alpha: 1),
        collectionViewCellColor: UIColor.init(white: 1, alpha: 1),
        activityIndicatorColor: UIColor.init(white: 0, alpha: 1),
        
        header1Font: UIFont.systemFont(ofSize: 35, weight: .bold),
        header2Font: UIFont.systemFont(ofSize: 30, weight: .bold),
        header2SemiFont: UIFont.systemFont(ofSize: 30, weight: .semibold),
        paragraph1Font: UIFont.systemFont(ofSize: 16, weight: .bold),
        paragraph2Font: UIFont.systemFont(ofSize: 14, weight: .bold),
        custom1Font: UIFont.systemFont(ofSize: 20, weight: .bold),
        custom2Font: UIFont.systemFont(ofSize: 18, weight: .semibold),
        custom3Font: UIFont.systemFont(ofSize: 10, weight: .bold),
        overflowFont: UIFont.systemFont(ofSize: 16, weight: .bold)
    )
    //iPad
    static let lightPad = AppTheme(
        statusBarStyle: .default,
        blurEffectStyle: .light,
        collectionViewCellBlurEffectStyle: .light,
        
        primaryColor: UIColor.init(white: 0.2, alpha: 1),
        secondaryColor: UIColor.init(white: 0.6, alpha: 1),
        tertiaryColor: UIColor.init(white: 0.8, alpha: 1),
        backgroundColor: UIColor.init(white: 1, alpha: 1),
        buttonBackgroundColor: UIColor.init(white: 0.9, alpha: 1),
        shadowColor: UIColor.init(white: 0, alpha: 1),
        collectionViewCellColor: UIColor.init(white: 1, alpha: 1),
        activityIndicatorColor: UIColor.init(white: 0, alpha: 1),
        
        header1Font: UIFont.systemFont(ofSize: 30, weight: .bold),
        header2Font: UIFont.systemFont(ofSize: 26, weight: .bold),
        header2SemiFont: UIFont.systemFont(ofSize: 26, weight: .semibold),
        paragraph1Font: UIFont.systemFont(ofSize: 16, weight: .bold),
        paragraph2Font: UIFont.systemFont(ofSize: 14, weight: .bold),
        custom1Font: UIFont.systemFont(ofSize: 20, weight: .bold),
        custom2Font: UIFont.systemFont(ofSize: 16, weight: .semibold),
        custom3Font: UIFont.systemFont(ofSize: 10, weight: .bold),
        overflowFont: UIFont.systemFont(ofSize: 11, weight: .bold)
    )
    
    static let darkPad = AppTheme(
        statusBarStyle: .lightContent,
        blurEffectStyle: .dark,
        collectionViewCellBlurEffectStyle: .light,
        
        primaryColor: UIColor.init(white: 0.8, alpha: 1),
        secondaryColor: UIColor.init(white: 0.4, alpha: 1),
        tertiaryColor: UIColor.init(white: 0.2, alpha: 1),
        backgroundColor: UIColor.init(white: 0.1, alpha: 1),
        buttonBackgroundColor: UIColor.init(white: 0.15, alpha: 1),
        shadowColor: UIColor.init(white: 1, alpha: 1),
        collectionViewCellColor: UIColor.init(white: 1, alpha: 1),
        activityIndicatorColor: UIColor.init(white: 0, alpha: 1),
        
        header1Font: UIFont.systemFont(ofSize: 30, weight: .bold),
        header2Font: UIFont.systemFont(ofSize: 26, weight: .bold),
        header2SemiFont: UIFont.systemFont(ofSize: 26, weight: .semibold),
        paragraph1Font: UIFont.systemFont(ofSize: 16, weight: .bold),
        paragraph2Font: UIFont.systemFont(ofSize: 14, weight: .bold),
        custom1Font: UIFont.systemFont(ofSize: 20, weight: .bold),
        custom2Font: UIFont.systemFont(ofSize: 16, weight: .semibold),
        custom3Font: UIFont.systemFont(ofSize: 10, weight: .bold),
        overflowFont: UIFont.systemFont(ofSize: 11, weight: .bold)
    )
    //Phone
    static let lightPhone = AppTheme(
        statusBarStyle: .default,
        blurEffectStyle: .light,
        collectionViewCellBlurEffectStyle: .light,
        
        primaryColor: UIColor.init(white: 0.2, alpha: 1),
        secondaryColor: UIColor.init(white: 0.6, alpha: 1),
        tertiaryColor: UIColor.init(white: 0.8, alpha: 1),
        backgroundColor: UIColor.init(white: 1, alpha: 1),
        buttonBackgroundColor: UIColor.init(white: 0.9, alpha: 1),
        shadowColor: UIColor.init(white: 0, alpha: 1),
        collectionViewCellColor: UIColor.init(white: 1, alpha: 1),
        activityIndicatorColor: UIColor.init(white: 0, alpha: 1),
        
        header1Font: UIFont.systemFont(ofSize: 28, weight: .bold),
        header2Font: UIFont.systemFont(ofSize: 24, weight: .bold),
        header2SemiFont: UIFont.systemFont(ofSize: 24, weight: .semibold),
        paragraph1Font: UIFont.systemFont(ofSize: 15, weight: .bold),
        paragraph2Font: UIFont.systemFont(ofSize: 13, weight: .bold),
        custom1Font: UIFont.systemFont(ofSize: 17, weight: .bold),
        custom2Font: UIFont.systemFont(ofSize: 15, weight: .semibold),
        custom3Font: UIFont.systemFont(ofSize: 8, weight: .bold),
        overflowFont: UIFont.systemFont(ofSize: 10, weight: .bold)
    )
    
    static let darkPhone = AppTheme(
        statusBarStyle: .lightContent,
        blurEffectStyle: .dark,
        collectionViewCellBlurEffectStyle: .light,
        
        primaryColor: UIColor.init(white: 0.8, alpha: 1),
        secondaryColor: UIColor.init(white: 0.4, alpha: 1),
        tertiaryColor: UIColor.init(white: 0.2, alpha: 1),
        backgroundColor: UIColor.init(white: 0.1, alpha: 1),
        buttonBackgroundColor: UIColor.init(white: 0.15, alpha: 1),
        shadowColor: UIColor.init(white: 1, alpha: 1),
        collectionViewCellColor: UIColor.init(white: 1, alpha: 1),
        activityIndicatorColor: UIColor.init(white: 0, alpha: 1),
        
        header1Font: UIFont.systemFont(ofSize: 28, weight: .bold),
        header2Font: UIFont.systemFont(ofSize: 24, weight: .bold),
        header2SemiFont: UIFont.systemFont(ofSize: 24, weight: .semibold),
        paragraph1Font: UIFont.systemFont(ofSize: 15, weight: .bold),
        paragraph2Font: UIFont.systemFont(ofSize: 13, weight: .bold),
        custom1Font: UIFont.systemFont(ofSize: 17, weight: .bold),
        custom2Font: UIFont.systemFont(ofSize: 15, weight: .semibold),
        custom3Font: UIFont.systemFont(ofSize: 8, weight: .bold),
        overflowFont: UIFont.systemFont(ofSize: 10, weight: .bold)
    )
    
}
