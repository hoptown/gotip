//
//  MainView.swift
//  Go Tip
//
//  Created by Lawrence Lovelace on 12/12/23.
//  Copyright © 2023 Pledge Geek. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @State var btnNumber: Int = 1
    @State var billAmount: Float = 0.0
    @State var billAmountStr: String = ""
    @State var indvAmount: Float = 0.0
    @State var indvTip: Float = 0.0
    @State var groupAmount: Float = 0.0
    @State var groupTip: Float = 0.0

    @AppStorage("colorTheme") private var colorTheme = 1
    @State var mytheme = 1
    @State private var tipPercent = 15
    @State private var party = 1
    
    //    @AppStorage("tipPercent") private var tipPercent = 15
    //    @AppStorage("party") private var party = 1
    @AppStorage("maxFractions") private var maxFractions = 2
    
    let tipPercents = Array(0...50)
    let partyPeople = Array(1...20)
    let startDate = Date.now
    
    
    let localCurrencySymbol = {
        let currencyID = Locale.current.currencySymbol ?? "$"
        return currencyID
    }()
    
    let currentDate = {
        let dateFormat = DateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("EEE, MMM dd")
        let dateStr = dateFormat.string(from: .now)
        
        return dateStr
    }()
    
    func getCurrencyFormat() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = maxFractions
        formatter.maximumFractionDigits = maxFractions
        return formatter
    }
    
   /* var currencyFormatter = {
        @AppStorage("maxFractions") var maxFractions = 2
//        var maxFractions = UserDefaults.standard.integer(forKey: "maxFractions")
        /*if maxFractions <= 2 {
            maxFractions = 2
        } else {
            maxFractions = 3
        }*/
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = maxFractions
        formatter.maximumFractionDigits = maxFractions
//        formatter.zeroSymbol = "0"
        return formatter
    }()*/
    
    let neonGreen = Color("neon green")
    let paleGreen = Color("pale green")
    let darkGray2 = Color("dark gray 2")
    let sectionBG2 = Color("section bg 2")
    let lighterGray = Color("light gray")
    let bg3 = Color("bg3")
    let bgWhite = Color.white

    @State var presentSettings = false
    
    var numberSpacing = CGFloat(10)
    
    var body: some View {
        GeometryReader { superview in
            
            ZStack {
                if colorTheme == 1 {
                    Color("dark gray").zIndex(0).ignoresSafeArea()
                }
                else if colorTheme == 2 {
                    Color.white.zIndex(0).ignoresSafeArea()
                }
                else {
                    bg3.zIndex(0).ignoresSafeArea()
                }
                
                
                VStack {
                    VStack {
                        VStack {
                            HStack(alignment: .center) {
//                                Text(startDate, style: .date)
                                Text(currentDate)
                                    .font(.caption2)
                                    .frame(width: superview.size.width * 0.2)
                                    .foregroundStyle(colorTheme == 1 ? .yellow : .black)
                                    
                                
                                Spacer()
                                Text("Go Tip!")
                                    .frame(width: superview.size.width * 0.5)
                                    .bold()
                                    .font(.title3)
                                    .foregroundStyle(colorTheme == 1 ? neonGreen : .black)
                                    .accessibilityHint("title")
                                Spacer()
                                Button("Theme", action: changeTheme)
                                    .frame(width: superview.size.width * 0.2)
                                    .foregroundStyle(colorTheme == 1 ? .white : .black)
                                    .sheet(isPresented: $presentSettings) {
                                        GoTipSettings(maxFractions: $maxFractions)
                                    }
                                    .accessibilityLabel("change color theme and other options")
                                                
                            }
                        }
                        .padding(.top, 25)
                        .padding(.bottom, 5)
                        
                        HStack {
                            ZStack {
                                Color(colorTheme == 1 ? "light gray" : colorTheme == 2 ? "section bg 2" : "bgWhite").zIndex(0)
                                    .modifier(RoundedSections())
                                HStack {
                                    if colorTheme == 1 || colorTheme == 2 {
                                        Image(systemName: "person")
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                            .foregroundStyle(colorTheme == 1 ? neonGreen : paleGreen)
                                    } else {
                                        Image("santa")
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                    }
                                    Spacer()
                                    VStack {
                                        Text(getCurrencyFormat().string(from: indvAmount as NSNumber) ?? "0")
                                            .modifier(TitleModifier())
                                            .dynamicTypeSize(.xLarge)
                                        Spacer()
                                        Text("includes \( getCurrencyFormat().string(from: indvTip as NSNumber) ?? "0") tip")
                                            .modifier(TipFont())
                                    }.padding()
                                }.zIndex(1)
                            }
                        }//.padding(.top, 5)
                        HStack {
                            ZStack {
                                Color(colorTheme == 1 ? "light gray" : colorTheme == 2 ? "section bg 2" : "bgWhite").zIndex(0)
                                    .modifier(RoundedSections())
                                HStack {
                                    if colorTheme == 1 || colorTheme == 2 {
                                        Image(systemName: "person.2")
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                            .foregroundStyle(colorTheme == 1 ? neonGreen : paleGreen, colorTheme == 1 ? .white : .gray)
                                        
                                    } else {
                                        HStack(spacing: -15) {
                                            Image("reindeer")
                                                .resizable()
                                                .scaledToFit()
                                            Image("reindeer")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                    }
                                    Spacer()
                                    VStack {
                                        Text(getCurrencyFormat().string(from: groupAmount as NSNumber) ?? "0")
                                            .modifier(TitleModifier())
                                            .dynamicTypeSize(.xLarge)
                                        Spacer()
                                        Text("includes \( getCurrencyFormat().string(from: groupTip as NSNumber) ?? "0") tip")
                                            .modifier(TipFont())
                                    }.padding()
                                }.zIndex(1)
                            }
                        }
                        
                        // pickers
                        HStack {
                            ZStack(alignment: .leading) {
                                Color.clear.zIndex(0)
                                
                                HStack {
                                    Text("tip")
                                        .font(.caption)
                                        .dynamicTypeSize(.small)
                                        .foregroundStyle(colorTheme == 1 ? Color.white : Color("light gray"))
                                        .accessibilityHidden(true)
                                   
                                    Picker("", selection: $tipPercent) {
                                        ForEach(tipPercents, id: \.self) { percent in
                                            Text("\(percent) %")
                                                .tag(percent)
                                                .font(.title)
                                                .accessibilityLabel("tip selector. \(percent)%")
                                                
                                        }
                                            
                                    }.tint(colorTheme == 1 ? neonGreen : colorTheme == 2 ? paleGreen : Color.black)
                                        .font(.subheadline)
                                        .dynamicTypeSize(.xxLarge)
                                        .fontWeight((colorTheme == 1 || colorTheme == 2) ? .regular : .heavy)
                                        .accessibilityRemoveTraits(.isButton)
                                        
                                        
                                    //.pickerStyle(.wheel)
                                    
                                    Spacer()
                                    Spacer()
                                    
                                    Picker("", selection: $party) {
                                        ForEach(partyPeople, id: \.self) { num in
                                            Text("\(num)")
                                                .tag(num)
                                                .accessibilityLabel("number of people in party. \(num)")
                                        }
                                    }.tint(colorTheme == 1 ? neonGreen : colorTheme == 2 ? paleGreen : Color.black)
                                        .font(.subheadline)
                                        .dynamicTypeSize(.xxLarge)
                                        .fontWeight((colorTheme == 1 || colorTheme == 2) ? .regular : .heavy)
                                    
                                    Text("people")
                                        .font(.caption)
                                        .dynamicTypeSize(.small)
                                        .foregroundStyle(colorTheme == 1 ? Color.white : Color("light gray"))
                                        .accessibilityHidden(true)
                                }
                                .zIndex(1)
                                .padding([.leading, .trailing], 50)
                            }
                        }
                        HStack {
                            ZStack {
                                Color(colorTheme == 1 ? "light gray" : colorTheme == 2 ? "pale green" : "bgWhite").zIndex(0)
                                    .modifier(RoundedSections())
                                HStack {
                                    Text("amount to tip on:")
                                        .italic()
                                        .modifier(BillFont())
                                        .dynamicTypeSize(.large)
                                    Spacer()
                                    
                                    Text("\(getCurrencyFormat().string(from: billAmount as NSNumber) ?? "0")")
                                        .modifier(BillFont())
                                    
                                }.padding()
                            }
                        }
                    }
                    .frame(height: superview.size.height * 0.5)
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .trailing])
                    .onAppear() {
//                        print("max and min decimals: \(maxFractions)")
                        billAmountStr = "0"
                    }
                    .onChange(of: billAmountStr) {
                        calculateAll()
                    }
                    .onChange(of: tipPercent) {
                        calculateAll()
                    }
                    .onChange(of: party) {
                        calculateAll()
                    }
                    .onChange(of: colorTheme) {
                        //print("new color theme from home screen: \(colorTheme)")
//                        calculateAll()
                    }
//                    .onChange(of: maxFractions) { newVal in
//                    .onChange(of: maxFractions) { newValue in
//                    .onChange(of: maxFractions) { oldVal, newValue in
//                        calculateAll()
//                    }
                    
                    
                    
                    Spacer()
                    
                    
                    VStack(alignment: .center, spacing: 15) {
                        Spacer()
                        Group {
                            HStack(spacing: numberSpacing) {
                                Button {
                                    btnNumber = 7
                                    btnTapped()
                                } label: {
                                    Text("7")
                                }
                                
                                Button {
                                    btnNumber = 8
                                    btnTapped()
                                } label: {
                                    Text("8")
                                }
                                
                                Button {
                                    btnNumber = 9
                                    btnTapped()
                                } label: {
                                    Text("9")
                                }
                            }
                            HStack(spacing: numberSpacing) {
                                Button {
                                    btnNumber = 4
                                    btnTapped()
                                } label: {
                                    Text("4")
                                }
                                
                                Button {
                                    btnNumber = 5
                                    btnTapped()
                                } label: {
                                    Text("5")
                                }
                                
                                Button {
                                    btnNumber = 6
                                    btnTapped()
                                } label: {
                                    Text("6")
                                }
                            }
                            HStack(spacing: numberSpacing) {
                                Button {
                                    btnNumber = 1
                                    btnTapped()
                                } label: {
                                    Text("1")
                                }
                                
                                Button {
                                    btnNumber = 2
                                    btnTapped()
                                } label: {
                                    Text("2")
                                }
                                
                                Button {
                                    btnNumber = 3
                                    btnTapped()
                                } label: {
                                    Text("3")
                                }
                            }
                            HStack(spacing: numberSpacing) {
                                Button {
                                    backspace()
                                } label: {
                                    Text("del")
                                        .dynamicTypeSize(.small)
                                }
                                .buttonStyle(GrowingButton2(width: superview.size.width))
                                .accessibilityLabel("delete")
                                
                                
                                Button {
                                    btnNumber = 0
                                    btnTapped()
                                } label: {
                                    Text("0")
                                }
                                
                                
                                Button {
                                    clearAmount()
                                } label: {
                                    Text("clear").zIndex(1)
                                        .dynamicTypeSize(.small)
                                }
                                .buttonStyle(GrowingButton2(width: superview.size.width))
                                .accessibilityLabel("clear")
                                
                            }
                        } // button group
                        .font(.title)
                        .buttonStyle(GrowingButton(width: superview.size.width))
                        
                        Spacer()
                    }
//                    .frame(height: superview.size.height * 0.47)
                    .frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .trailing])
                    
                }.zIndex(1)
                
                
            } // end zstack
        } // end goe
        
    } // end body
    
    
    func btnTapped() {
//        print(btnNumber)
        billAmountStr += "\(btnNumber)"
//        print(billAmountStr)
       calculateAll()
    }
    
    func backspace() {
        if billAmountStr.count > 0 {
            billAmountStr.removeLast()
        }
        
        calculateAll()
    }
    
    func clearAmount() {
        billAmountStr = "0"
        calculateAll()
    }
    
    
    func changeTheme() {
        presentSettings.toggle()
    }
    
    func calculateAll() {
        billAmount = billAmountStr.floatValue * 0.01
//        print(billAmount)
        if billAmount > 0
        {
            if tipPercent > 0
            {
                // first, convert tip to percentage
                let percentage = Float(tipPercent)/Float(100)
//                print("tip: \(percentage)%")
                //
                groupTip = billAmount * percentage
                indvTip = groupTip/Float(party)
            }
            else
            {
                indvTip = 0
                groupTip = 0
            }
            
            groupAmount = billAmount + groupTip
            indvAmount = groupAmount/Float(party)
        }
        else {
            indvAmount = 0
            indvTip = 0
            groupAmount = 0
            groupTip = 0
        }
    }
}

#Preview {
    MainView()
}


extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    // Empty Strings in Swift:  https://useyourloaf.com/blog/empty-strings-in-swift/
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
    
    func numberOfOccurrencesOf(string: String) -> Int {
        return self.components(separatedBy: string).count - 1
    }
}
