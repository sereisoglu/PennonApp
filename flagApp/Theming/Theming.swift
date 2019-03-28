//
//  NightMode.swift
//  Night Mode
//
//  Created by Michael on 01/04/2018.
//  Copyright © 2018 Late Night Swift. All rights reserved.
//

import Foundation

protocol ThemeProvider {
	associatedtype Theme
	var currentTheme: Theme { get }
	func subscribeToChanges(_ object: AnyObject, handler: @escaping (Theme) -> Void)
}

protocol Themed {
	associatedtype _ThemeProvider: ThemeProvider
	var themeProvider: _ThemeProvider { get }
	func applyTheme(_ theme: _ThemeProvider.Theme)
}

extension Themed where Self: AnyObject {
	func setUpTheming() {
		applyTheme(themeProvider.currentTheme)
		themeProvider.subscribeToChanges(self) { [weak self] newTheme in
			self?.applyTheme(newTheme)
		}
	}
}
