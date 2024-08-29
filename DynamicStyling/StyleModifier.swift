import SwiftUI

struct TextAndButtonModifier: ViewModifier {
    var config: StyleConfig
    func body(content: Content) -> some View {
        content
            .font(.system(size: config.fontSize ?? 12 , weight: config.fontWeight))
            .foregroundStyle(config.foregroundColor ?? .black )
            .background(config.backgroundColor)
            .cornerRadius(config.cornerRadius ?? 0)
            .shadow(radius: config.shadowRadius ?? 0)
    }
}

struct ViewStyleModifier: ViewModifier {
    var config: StyleConfig
    func body(content: Content) -> some View {
        content
            .foregroundStyle(config.foregroundColor ?? .black)
            .background(config.backgroundColor ?? .clear)
            .cornerRadius(config.cornerRadius ?? 0)
            .shadow(radius: config.shadowRadius ?? 0)
    }
}


extension View {
    func applyStyle(_ styleName: String) -> some View {
        let styleConfig = StyleManager.shared.style(for: styleName)
        return modifier(TextAndButtonModifier(config: styleConfig!))
    }
    
    func applyStyleToView(_ styleName: String) -> some View {
        let styleConfig = StyleManager.shared.style(for: styleName)
        return modifier(ViewStyleModifier(config: styleConfig!))
    }
    
}
