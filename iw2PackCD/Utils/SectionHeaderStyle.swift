//
//  SectionHeaderStyle.swift
//  iw2PackCD
//
//  Created by Don McKenzie on 01-09-2024.
//


import SwiftUI

struct SectionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Color(red: 0.4627, green: 0.8392, blue: 1.0))
            .cornerRadius(8)
            .shadow(radius: 2)
    }
}

struct SectionHeaderStyle0: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(.bold)
    }
}

//                    Section(header: Text(sections.key).font(.title2).fontWeight(.bold)) {

extension View {
    func sectionHeaderStyle() -> some View {
        self.modifier(SectionHeaderStyle())
    }
}
