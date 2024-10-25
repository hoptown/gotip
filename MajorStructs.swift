//
//  MajorStructs.swift
//  Go Tip
//
//  Created by Lawrence Lovelace on 12/12/23.
//  Copyright © 2023 Pledge Geek. All rights reserved.
//

import Foundation
import SwiftUI

// Xmas calculator: https://www.modip.ac.uk/artefact/aibdc-02315
// https://www.bergdorfgoodman.com/p/old-world-christmas-calculator-holiday-ornament-prod174110131

let neonGreen = Color("neon green")
let paleGreen = Color("pale green")
let darkGray2 = Color("dark gray 2")
let sectionBG2 = Color("section bg 2")
let bg3 = Color("bg3")
let bgWhite = Color.white
let bgClear = Color.clear


struct GrowingButton: ButtonStyle {
    //    var backgroundColor: Binding<Color>
    
    let width: CGFloat
    @AppStorage("colorTheme") var colorTheme = 1
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width * 0.2)
            .frame(maxHeight: .infinity)
            .padding()
            .background(colorTheme == 1 ? neonGreen : colorTheme == 2 ? sectionBG2 : bgClear)
            .foregroundStyle(colorTheme == 3 ? .white : .black)
            .shadow(radius: 10)
            .bold()
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct GrowingButton2: ButtonStyle {
    let width: CGFloat
    @AppStorage("colorTheme") var colorTheme = 1
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width * 0.2)
            .frame(maxHeight: .infinity)
            .padding()
            .background((colorTheme == 1 || colorTheme == 2) ? .red : .clear)
            .foregroundStyle((colorTheme == 1 || colorTheme == 2) ? .black : .yellow)
            .bold()
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


struct RoundedSections: ViewModifier {    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}

struct TitleModifier: ViewModifier {
    @AppStorage("colorTheme") var colorTheme = 1
    func body(content: Content) -> some View {
        content
//            .font(.custom("Open Sans", size: 18))
            .foregroundColor(colorTheme == 1 ? neonGreen : colorTheme == 2 ? paleGreen : Color.black)
            .font(.title)
            .dynamicTypeSize(.large)
            .bold()
    }
}

struct TipFont: ViewModifier {
    @AppStorage("colorTheme") var colorTheme = 1
    func body(content: Content) -> some View {
        content
            .foregroundColor(colorTheme == 1 ? .white : Color("light gray"))
            .font(.title3)
            .dynamicTypeSize(.xSmall)
            .italic()
    }
}

struct BillFont: ViewModifier {
    @AppStorage("colorTheme") var colorTheme = 1
    func body(content: Content) -> some View {
        content
            .foregroundColor(colorTheme == 1 ? .white : colorTheme == 2 ? Color("dark gray 2") : .black)
            .font(.headline)
            .fontWeight(.heavy)
            .dynamicTypeSize(.xxLarge)
    }
}
