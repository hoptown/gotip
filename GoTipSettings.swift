//
//  GoTipSettings.swift
//  Go Tip
//
//  Created by Lawrence Lovelace on 12/12/23.
//  Copyright © 2023 Pledge Geek. All rights reserved.
//

import SwiftUI

struct GoTipSettings: View {
    @AppStorage("colorTheme") var colorTheme = 1
    @Binding var maxFractions: Int   // populated by parent view
    let neonGreen = Color("neon green")
    let paleGreen = Color("pale green") // 82, 184, 181
    let darkGray2 = Color("dark gray 2")
    let bg3 = Color("bg3") // 138, 208, 244
    
   /* init() {
        // https://stackoverflow.com/questions/57735761/how-to-change-selected-segment-color-in-swiftui-segmented-picker
        UISegmentedControl.appearance().selectedSegmentTintColor = colorTheme == 1 ? .green : colorTheme == 2 ? UIColor(red: 82/255, green: 181/255, blue: 184/255, alpha: 1) : UIColor(red: 138/255, green: 208/255, blue: 244/255, alpha: 1)
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: colorTheme == 1 ? UIColor.black : UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: colorTheme == 1 ? UIColor.gray : UIColor.blue], for: .normal)
        
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 20)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
    }*/
    
    var body: some View {
        GeometryReader { sv in
            ZStack {
                colorTheme == 1 ? Color("dark gray").zIndex(0).ignoresSafeArea() : Color(.white).zIndex(0).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Text("Color Theme").bold()
                            .foregroundStyle(colorTheme == 1 ? Color.white : colorTheme == 2 ? paleGreen : Color.black)
                        
                        HStack {
                            Button {
                                changeTheme()
                            } label: {
                                ZStack {
                                    Color(colorTheme == 1 ? "neon green" : colorTheme == 2 ? "pale green" : "bg3").clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                }.padding()
                            }
                            .accessibilityLabel(colorTheme == 1 ? "current color theme is neon green" : colorTheme == 2 ? "current color theme is pale green" : "current color theme is Christmas!")
                        }
                        
                        Spacer()
                    }.padding()
                        .frame(height: sv.size.height * 0.2)
                    
                    VStack {
                        Text("Maximum Decimals for amounts:")
                            .padding()
                            .foregroundStyle(colorTheme == 1 ? Color.white : colorTheme == 2 ? paleGreen : Color.black)
                        
                      
                            Picker("Select a category.", selection: $maxFractions) {
                                Text("2").tag(2)
                                Text("3").tag(3)
                                    .foregroundStyle(.yellow)
                            }
                            .pickerStyle(.segmented)
                            .colorMultiply(colorTheme == 1 ? .green : colorTheme == 2 ? paleGreen : bg3)
                    }
                    .padding()
                    
                    
                    VStack {
                        Text("Developed in Louisville, Kentucky by someone with Love 4 Apps")
                            .lineLimit(2).font(.headline)
                            .dynamicTypeSize(.large)
                            .foregroundStyle(colorTheme == 1 ? Color.white : colorTheme == 2 ? paleGreen : Color.black)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                        
                        Text("❤️lace")
                            .lineLimit(1).font(.headline)
                            .dynamicTypeSize(.large)
                            .foregroundStyle(colorTheme == 1 ? Color.white : colorTheme == 2 ? paleGreen : Color.black)
                            .accessibilityLabel("Lovelace")
                        
                        Spacer()
                        Text("version \(getVersion()), build \(getBuildNumber())")
                            .foregroundStyle(colorTheme == 1 ? Color.white : colorTheme == 2 ? paleGreen : Color.black)
                            .font(.caption)
                    }
                    .padding(50)
                    .font(.title2)
                    
                    Spacer()
                    Spacer()
                }
                .zIndex(1)
                
            }
        }
    }
    
    func changeTheme() {
        if colorTheme == 1 {
            colorTheme = 2
        }
        else if colorTheme == 2 {
            colorTheme = 3
        }
        else {
            colorTheme = 1
        }
    }
    
    func getVersion() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "no version info"
        }
        return version
    }
    
    func getBuildNumber() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            return "n/a"
        }
        return version
    }
}

#Preview {
    @State var maxFract = 2
    return GoTipSettings(maxFractions: $maxFract)
}
