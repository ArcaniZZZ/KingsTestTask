//
//  Color + Hex.swift
//  KingsTestApp
//
//  Created by Arcani on 26.05.2023.
//

import SwiftUI

extension Color {
    
    /// Creates Color from hex
    public init?(hex: String) {
        let red, green, blue: CGFloat
        
        var opacity: CGFloat = 1
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if hexColor.count == 6 {
                
                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    blue = CGFloat(hexNumber & 0x0000ff) / 255
                    
                    self.init(red: red, green: green, blue: blue, opacity: opacity)
                    return
                }
            }
            
            if hexColor.count == 8 {
                
                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255.0
                    blue = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255.0
                    opacity = CGFloat(hexNumber & 0x000000FF) / 255.0
                    
                    self.init(red: red, green: green, blue: blue, opacity: opacity)
                    return
                }
            }
            
        }
        return nil
    }
}
