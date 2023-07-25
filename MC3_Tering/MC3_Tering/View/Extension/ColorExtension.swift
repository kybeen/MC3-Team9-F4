//
//  ColorExtension.swift
//  MC3_Tering
//
//  Created by KimTaeHyung on 2023/07/25.
//

import SwiftUI

extension Color {
    /// Assets에 추가한 색상 사용하기 편하도록 extenstion 구현
    /// ```
    /// Ex)
    /// Text("Red Color")
    ///     .foregroundColor(Color.theme.red)
    /// ```
    static let theme = ColorTheme()
}

struct ColorTheme {
    let teGreen = Color("TennisGreen")
    let teSkyBlue = Color("TennisSkyBlue")
    let teBlue = Color("TennisBlue")
    let teBlack = Color("TennisBlack")
    let teRealBlack = Color("TennisRealBlack")
    let teDarkGray = Color("TennisDarkGray")
    let teLightGray = Color("TennisLightGray")
    let teGray = Color("TennisGray")
    let teWhite = Color("TennisWhite")
}

extension UIColor {
    static let theme = ColorTheme()
}
