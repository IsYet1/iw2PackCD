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
    let size: CGFloat = 28
    
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle() // toggle the state binding
        }, label: {
            if (style == .circleh) {
                /* Add Item to Event cell. */
                HStack {
                    Image(systemName: configuration.isOn ? "\(markType).\(style.sfSymbolName).fill" : style.sfSymbolName)
                        .resizable()
                        .frame(width: size, height: size)
                        .hoverEffect(.highlight)
                    configuration.label
                }
            } else {
                /* VStack is used on the Event Items list page - Item List and Action Bar. */
                VStack {
                    Image(systemName: configuration.isOn ? "\(markType).\(style.sfSymbolName).fill" : style.sfSymbolName)
                        .resizable()
                        .frame(width: size, height: size)
                        .hoverEffect(.highlight)
                    /* Label is only used for the Action Bar items. Item List does not set a lable for this toggle */
                    configuration.label
                        .font(.footnote)
//                        .fontWeight(.light)
                }
                
            }
        })
        .buttonStyle(PlainButtonStyle()) // remove any implicit styling from the button
        .disabled(!isEnabled)
    }
    
    
    enum MarkType {
        case checkmark, xmark
    }
    
    /*
     circleh: Add items to an event. From the Add/Remove page and from the Item listing page - Event section
     
     */
    enum Style {
        case square, circle, diamond, circleh
        
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
            }
        }
    }
}

