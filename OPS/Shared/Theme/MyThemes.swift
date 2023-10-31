//
//  MyThemes.swift
//  Demo
//
//  Created by Gesen on 16/3/14.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import SwiftTheme
import UIKit
extension MyThemes {
    static func fontWithLanguage(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        enFont(size: size, weight: weight)
    }

    private static func enFont(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        var s = "Regular"
        switch weight {
        case .bold: s = "Bold"
        case .heavy, .black: s = "ExtraBold"
        case .light: s = "Light"
        case .medium: s = "Medium"
        case .semibold: s = "SemiBold"
        case .regular: fallthrough
        default: s = "Regular"
        }
        return UIFont(name: "Montserrat-\(s)", size: size)!
    }
}

extension MyThemes {
    // 0 是深蓝色配色； 1 是白色配色
    static let statusBarStyle: ThemeStatusBarStylePicker = [.lightContent, .default]

    static let basicBackgroundColor: ThemeColorPicker = ["#1A222C", "#fff"]
    static let basicBackgroundCGColor: ThemeCGColorPicker = ["#1A222C", "#fff"]

    static let activeTextColor: ThemeColorPicker = ["#3478F6", "#2c2c2c"]
    static let activeTextCGColor: ThemeCGColorPicker = ["#3478F6", "#2c2c2c"]

    static let normalTextColor: ThemeColorPicker = ["#fff", "#2c2c2c"]
    static let grayTextColor: ThemeColorPicker = ["#6D787D", "#6D787D"]
    static let hintCaptionTextColor: ThemeColorPicker = ["#496B92", "#496B92"]
    static let hintCaptionTextCGColor: ThemeCGColorPicker = ["#496B92", "#496B92"]

    static let headerGrayBlueColor: ThemeColorPicker = ["#496B92", "#496B92"]

    static let textInputBackgroundColor: ThemeColorPicker = ["#1A222C", "#1A222C"]
    static let textInputBackgroundCGColor: ThemeCGColorPicker = ["#1A222C", "#1A222C"]

    static let textInputColor: ThemeColorPicker = ["#fff","#2c2c2c"]
    static let textSecondaryColor: ThemeColorPicker = ["#242F3E", "#242F3E"]

    static let cellBackgroundCGColor: ThemeCGColorPicker = ["#1A222C","#1A222C"]
    static let cellBackgroundColor: ThemeColorPicker = ["#1A222C","#1A222C"]

    static let grayMaskBackgroundColor = ThemeColorPicker(colors: UIColor(red: 0.141, green: 0.184, blue: 0.243, alpha: 0.7),UIColor(red: 0.141, green: 0.184, blue: 0.243, alpha: 0.7))
    static let lineColor = ThemeColorPicker(colors: UIColor(red: 0.691, green: 0.764, blue: 0.821, alpha: 0.4),UIColor(red: 0.691, green: 0.764, blue: 0.821, alpha: 0.4))
    static let footerViewShadowCGColor = ThemeCGColorPicker(colors: UIColor(red: 0, green: 0, blue: 0, alpha: 0.35), UIColor(red: 0, green: 0, blue: 0, alpha: 0.35))
    static let warningTextColor: ThemeColorPicker = ["#FE6779","#FE6779"]



    static let barTextColors = ["#FFF", "#000", "#FFF", "#FFF"]
    static let barTextColor = ThemeColorPicker.pickerWithColors(barTextColors)
    static let barTintColor: ThemeColorPicker = ["#EB4F38", "#F4C600", "#56ABE4", "#01040D"]
}

enum MyThemes: Int {
    private static let kLastThemeIndexKey = "LastedThemeIndex"
    
    case darkBlue = 0 // default
    case white = 1
    
    // MARK: -
    
    static var current: MyThemes { return MyThemes(rawValue: ThemeManager.currentThemeIndex)! }
    static var before = MyThemes.white
    
    // MARK: - Switch Theme
    
    static func switchTo(theme: MyThemes) {
        before = current
        ThemeManager.setTheme(index: theme.rawValue)
        saveLastTheme()
    }
    
    static func switchToNext() {
        var next = ThemeManager.currentThemeIndex + 1
        if next > 2 { next = 0 } // cycle and without Night
        switchTo(theme: MyThemes(rawValue: next)!)
    }

    static func updateTheme(_ t: UITraitCollection) {
        guard #available(iOS 12.0, *) else { return }
        switchTo(theme: .darkBlue)
        return
        //todo: support white mode
        switch t.userInterfaceStyle {
        case .light:
            MyThemes.switchNight(isToNight: false)
        case .dark:
            MyThemes.switchNight(isToNight: true)
        case .unspecified:
            break
        @unknown default:
            break
        }
    }

    // MARK: - Switch Night
    
    static func switchNight(isToNight: Bool) {
        switchTo(theme: isToNight ? .darkBlue : .white)
    }
    
    static func isNight() -> Bool {
        return current == .darkBlue
    }
    
    // MARK: - Save & Restore
    
    static func restoreLastTheme() {
        switchTo(theme: MyThemes(rawValue: UserDefaults.standard.integer(forKey: kLastThemeIndexKey))!)
    }
    
    static func saveLastTheme() {
        UserDefaults.standard.set(ThemeManager.currentThemeIndex, forKey: kLastThemeIndexKey)
    }
}
