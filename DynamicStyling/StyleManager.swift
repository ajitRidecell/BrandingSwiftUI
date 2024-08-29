//
//  StyleManager.swift
//  DynamicStyling
//
//  Created by Ajit Nevhal on 27/08/24.
//

import Foundation

class StyleManager {
    static let shared = StyleManager()
    
    var buttonStyles: [String: StyleConfig] = [:]
    
    private init() {
        buttonStyles = loadButtonStyles()
    }
    
    func style(for name: String) -> StyleConfig? {
        return buttonStyles[name]
    }
    
    private func loadButtonStyles() -> [String: StyleConfig] {
        guard let url = Bundle.main.url(forResource: "Styleguide", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil),
              let dictionary = plist as? [String: [String: Any]] else {
            return [:]
        }
        
        var styles: [String: StyleConfig] = [:]
        for (key, value) in dictionary {
            let styleConfig = StyleConfig(from: value)
            styles[key] = styleConfig
            
        }
        return styles
        
    }
}
