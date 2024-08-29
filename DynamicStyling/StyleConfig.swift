//
//  ButtonStyleModifier.swift
//  DynamicStyling
//
//  Created by Ajit Nevhal on 19/08/24.
//

import SwiftUI

extension Color {
    static func fromString(_ string: String) -> Color {
        switch string {
        case "white": return .white
        case "green": return .green
        case "blue": return .blue
        case "red": return .red
        case "systemGray5": return Color(.systemGray5)
        case "yellow": return .yellow
        case "black": return .black
        default: return .clear
        }
    }

}

extension Font {
    static func fromString(_ fontString: String) -> Font {
        switch fontString.lowercased() {
        case "largeTitle":
            return .largeTitle
        case "title2":
            return .title2
        case "title3":
            return .title3
        case "headline":
            return .headline
        case "subheadline":
            return .subheadline
        default:
            return .title
        }
    }
}

struct StyleConfig {
    private var properties: [String: Any] = [:]

    init(from dictionary: [String: Any]) {
        self.properties = dictionary
    }
    
    func color(forKey key: String) -> Color? {
        if let hex = properties[key] as? String {
            return Color.fromString(hex)
        }
        return nil
    }

    func font(forKey key: String) -> Font? {
        if let string = properties[key] as? String {
            return Font.fromString(string)
        }
        return nil
    }

    func cgFloat(forKey key: String) -> CGFloat? {
        return properties[key] as? CGFloat
    }

    func string(forKey key: String) -> String? {
        return properties[key] as? String
    }
    
    func weight(forKey key: String) -> Font.Weight? {
        if let string = properties[key] as? String {
            switch string {
            case "black":       return .black
            case "bold":        return .bold
            case "heavy":       return .heavy
            case "light":       return .light
            case "medium":      return .medium
            case "regular":     return .regular
            case "semi-bold":   return .semibold
            case "thin":        return .thin
            case "ultra-light": return .ultraLight
            default:            return nil
            }
        }
        return nil
    }

    // Example accessors for your specific properties
    var backgroundColor: Color? {
        return color(forKey: "backgroundColor")
    }

    var foregroundColor: Color? {
        return color(forKey: "foregroundColor")
    }

    var fontSize: CGFloat? {
        return cgFloat(forKey: "fontSize")
    }

    var cornerRadius: CGFloat? {
        return cgFloat(forKey: "cornerRadius")
    }

    var font: Font? {
        return font(forKey: "font")
    }
    
    var fontWeight: Font.Weight? {
        return weight(forKey: "fontWeight")
    }
    
    var shadowRadius: CGFloat? {
        return cgFloat(forKey: "shadowRadius")
    }
}
