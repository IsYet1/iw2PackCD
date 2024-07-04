//
//  CheckboxToggleStyle.swift
//  iw2Pack
//
//  Created by Don McKenzie on 09-Feb-22.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    @Environment(\.isEnabled) var isEnabled
    let style: Style // custom param
    let markType: MarkType
    
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle() // toggle the state binding
        }, label: {
            if (style == .circleh) {
                HStack {
                    Image(systemName: configuration.isOn ? "\(markType).\(style.sfSymbolName).fill" : style.sfSymbolName)
                        .imageScale(.large)
                        .hoverEffect(.highlight)
                    configuration.label
                        .font(.footnote)
                        .fontWeight(.light)
                }
            } else {
                VStack {
                    Image(systemName: configuration.isOn ? "\(markType).\(style.sfSymbolName).fill" : style.sfSymbolName)
                        .imageScale(.large)
                        .hoverEffect(.highlight)
                    configuration.label
                        .font(.footnote)
                        .fontWeight(.light)
                }
                
            }
        })
        .buttonStyle(PlainButtonStyle()) // remove any implicit styling from the button
        .disabled(!isEnabled)
    }
    
    
    enum MarkType {
        case checkmark, xmark
    }
    
    enum Style {
        case square, circle, diamond, circleh, circlex
        
        var sfSymbolName: String {
            switch self {
            case .square:
                return "square"
            case .circle:
                return "circle"
            case .circleh:
                return "circle"
            case .diamond:
                return "diamond"
            case .circlex:
                return "circle"
            }
        }
    }
}

