//
//  SwiftUISystemColors.swift
//  
//
//  Created by Julian Pomper on 17.01.20.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS)
fileprivate typealias SwiftUIColor = UIColor
#elseif os(macOS)
fileprivate typealias SwiftUIColor = NSColor
#endif

public extension Color {
    
    // MARK:- Label
    
    var label: Color {
        #if os(tvOS) || os(iOS)
        return Color(UIColor.label)
        
        #elseif os(macOS)
        return Color(NSColor.labelColor)
        
        #else
        
        return Color.white
        
        #endif
    }
    
    var secondaryLabel: Color {
        #if os(tvOS) || os(iOS)
        return Color(UIColor.secondaryLabel)
        
        #elseif os(macOS)
        return Color(NSColor.secondaryLabelColor)
        
        #else
        return Color(red: 235, green: 235, blue: 245, opacity: 0.6)
        
        #endif
    }
    
    var tertiaryLabel: Color {
        #if os(tvOS) || os(iOS)
        return Color(UIColor.tertiaryLabel)
        
        #elseif os(macOS)
        return Color(NSColor.tertiaryLabelColor)
        
        #else
        return Color(red: 235, green: 235, blue: 245, opacity: 0.3)
        
        #endif
    }
    
    var quaternaryLabel: Color? {
        #if os(tvOS) || os(iOS)
        return Color(UIColor.quaternaryLabel)
        
        #elseif os(macOS)
        return Color(NSColor.quaternaryLabelColor)
        
        #else
        return Color(red: 235, green: 235, blue: 245, opacity: 0.18)
        
        #endif
    }
    
    // MARK:- Background
    
    var backgroundColor: Color {
        let color = Color(
            SwiftUIColor.dynamic(light: .white,
                                 dark: .black)
        )
        
        #if os(iOS)
        return Color(UIColor.systemBackground)
        
        #else
        return color
        
        #endif
    }
    
    var secondaryBackground: Color {
        let color = Color(
            SwiftUIColor.dynamic(light:SwiftUIColor(red: 242, green: 242, blue: 247, alpha: 1),
                                 dark: SwiftUIColor(red: 28, green: 28, blue: 30, alpha: 1))
        )
        
        #if os(iOS)
        return Color(UIColor.secondarySystemBackground)
        
        #else
        return color
        
        #endif
    }
    
    var tertiaryBackground: Color {
        let color = Color(
            SwiftUIColor.dynamic(light:SwiftUIColor(red: 255, green: 255, blue: 255, alpha: 1),
                                 dark: SwiftUIColor(red: 44, green: 44, blue: 46, alpha: 1))
        )
        
        #if os(iOS)
        return Color(UIColor.tertiarySystemBackground)
        
        #else
        return color
        
        #endif
    }
}

fileprivate extension SwiftUIColor {
    static func dynamic(light: SwiftUIColor, dark: SwiftUIColor?) -> SwiftUIColor {
        
        #if os(iOS) || os(tvOS)
        return SwiftUIColor(dynamicProvider: { traitCollection -> UIColor in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return dark ?? light
            case .light, .unspecified:
                return light
            @unknown default:
                return light
            }
        })
        
        #elseif os(macOS)
        return NSAppearance.current.isDarkMode ? (dark ??  light) : light
        
        #else
        return dark ?? light
        #endif
    }
}



#if os(macOS)
public extension Color {
    init(color: NSColor) {
        self.init(red: Double(color.redComponent), green: Double(color.greenComponent), blue: Double(color.blueComponent))
    }
}

// Adapted from https://indiestack.com/2018/10/supporting-dark-mode-checking-appearances/
fileprivate extension NSAppearance {
    var isDarkMode: Bool {
        if #available(macOS 10.14, *) {
            if self.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
#endif
