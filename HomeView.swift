//
//  HomeView.swift
//  Go Tip
//
//  Created by Lawrence Lovelace on 8/4/23.
//  Copyright © 2023 Pledge Geek. All rights reserved.
//
// sources for SwiftUI:
// buttons:  https://developer.apple.com/documentation/swiftui/button
// sliders: https://codewithchris.com/swiftui-slider-tutorial-2023/

import SwiftUI

struct HomeView: View {
    @Binding var globalString: String
    
    @State private var people = [Int](1...50)
//    [Int](0...10)
    
//    @State private var pickerTipPercentage: Int = 15
    @AppStorage("pickerTipPercentage") var pickerTipPercentage: Int = 1
    
    
    @State var billAmount: Double = 50
    var tips = ["0", "10", "15", "20"]
    @State private var selectedTip = ""
    
//    @State var currentAmountStr: String {
//    }
    @State var currentAmountStr : String = ""
    @State var currentAmountFormatted : String = ""
    @State var individualTotalAmount: Double = 0
    @State var individualTipAmount: Double = 0
    
    @State var groupTipGrandTotal: Double = 0
    @State var groupGrandTotal: Double = 0
    
    @State var selectedNumberOfPeople: Double = 4
    
    let currencySymbol = Locale.current.currencySymbol
    
    func calculateGrandTotals() {
        let current = Double(currentAmountStr)
        
        let format = NumberFormatter()
        format.numberStyle = .currency
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        format.usesGroupingSeparator = true
        
        billAmount = (current ?? 0.0) * 0.01
        currentAmountFormatted = format.string(from: NSNumber(value: billAmount))!
        
//        billAmount = current ?? 0.0 // calculation
        calculateTips()
        
        groupGrandTotal = billAmount + groupTipGrandTotal
        //        individualTotalAmount = (groupGrandTotal/selectedNumberOfPeople)
    }
    
    func calculateGroupTotalBill() -> String {
//        if currentAmountStr.isEmpty == false {
            let format = NumberFormatter()
            format.numberStyle = .currency
            
            format.maximumFractionDigits = 2
            format.minimumFractionDigits = 2
            format.usesGroupingSeparator = true
            
            let current = Double(currentAmountStr)
//            billAmount = current ?? 0.0
            //        billAmount = Double(currentAmountStr)! * 0.01
            billAmount = (current ?? 0.0) * 0.01
            groupGrandTotal = billAmount + groupTipGrandTotal
            
            return format.string(from: NSNumber(value: groupGrandTotal))!
//        }
//        else {
//            let format = NumberFormatter()
//            format.numberStyle = .currency
//            return format.string(from: NSNumber(value: 0.0))!
//        }
    }
    
    func configureIndividualTotalLabel() -> String {
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        format.usesGroupingSeparator = true
        
        individualTotalAmount = (groupGrandTotal/selectedNumberOfPeople)
        
        return format.string(from: NSNumber(value: individualTotalAmount))!
    }
    
    func configureIndividualTipLabel() -> String {
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        format.usesGroupingSeparator = true
        
        return format.string(from: NSNumber(value: individualTipAmount))!
    }
    
    /*func calculateBillFromString() -> String {
        
        let current = Double(currentAmountStr)
        billAmount = current ?? 0.0 // calculation
        calculateTips()
        calculateGrandTotals()
        
        let split = billAmount/selectedNumberOfPeople
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        format.usesGroupingSeparator = true
        
        return format.string(from: NSNumber(value: split))!
    }*/
    
    func calculateTips() {
        let selectedTip = 20.0
        let tipPercentage = selectedTip/100
        groupTipGrandTotal = billAmount * tipPercentage
        individualTipAmount = groupTipGrandTotal/selectedNumberOfPeople
    }
    func calculateGroupTotalTip() -> String {
        /*let current = Double(currentAmountStr)
        billAmount = current ?? 0.0 // calculation
        calculateTips()
        calculateGrandTotals()
        
        let split = billAmount/selectedNumberOfPeople*/
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        format.usesGroupingSeparator = true
        
        let selectedTip = 20.0
        let tipPercentage = selectedTip/100
        groupTipGrandTotal = billAmount * tipPercentage
        
        return format.string(from: NSNumber(value: groupTipGrandTotal))!
    }
    
    
 
    
    var calculation : Double {
        guard let m = Double(currentAmountStr), let n  = Double(currentAmountStr) else { return 0 }
        return m * n
    }
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { geometry in
            Color("BackGround2")
                .ignoresSafeArea().zIndex(0).overlay(
                    VStack {
                        HStack {
                            Text("\(Date().formatted(date: .abbreviated, time: .omitted))")
//                            Spacer()
                            Text("Go Tip").zIndex(2)
//                            Spacer()
                            
                            Text("Settings")
                            // end hstack
                        }
                            .fixedSize(horizontal: false, vertical: true)
                        
                       
                        ZStack {
                            Color.gray.zIndex(0)
                            HStack {
                                
                                    Image(systemName: "person").zIndex(2)
                                
                                Spacer()

                                VStack(alignment: .trailing) {
                                    Text(individualTotalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    Text(individualTipAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                }
                                    
                            }
                        }
                            .frame(height: geometry.size.height * 0.1)
                        
                        // group:
                        ZStack {
                            Color.gray.zIndex(0)
                            HStack {
                                
                                Image(systemName: "person.2.fill").zIndex(2)
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("$18.33")
                                    Text("includes $1.67 tip")
                                }
                                
                            }
                        }
                        .frame(height: geometry.size.height * 0.1)
                        
                        // pickers
                        HStack {
                            Spacer()
                            Text("tip")
                            Picker("tip", selection: $pickerTipPercentage) {
                                ForEach(0..<101) {
                                    Text("\($0) %")
                                }
                            }
                            Spacer()
//                            Spacer()
//                            Spacer()
                            Text("people")
                            Picker("tip $", selection: $people) {
                                ForEach(1..<people.count) { index in
                                    Text("\(index)")
                                }
                            }
                            Spacer()
                        }
                        
                        // bill:
                        // group:
                        ZStack {
                            Color.gray.zIndex(0)
                            HStack {
                                
                                Text("Bill: ")
                                
                                Spacer()
                                
                                Text("$50.00")
                                
                            }
                        }
                        .frame(height: geometry.size.height * 0.1)
                        
                        ContentView()
                        
                        Spacer()
                        // ends vstack
                    }
                ) // ends overlay
        }
    }
}

func didTapNumber() {
  
//    var billAmount = 0.0
//
//    let digit = 1// button.tag
//    print("digit is  \(digit)")
//
//    if currentAmountStr.count >= 14 {
//        alertMaxDigits()
//    }
//    else if digit == 0 && billAmount == 0 {
//        // no need to calculate 0 with another 0. It's still 0
//    }
//    else if txtBillAmount.text!.count < 13 {
//        currentAmountStr = "\(currentAmountStr)" + "\(digit)"
//        billAmount = Double(currentAmountStr)! * 0.01
//        calculateAmountsTaxTip()
//    }
}

func calculateAmountsTaxTip() {
    
}

func alertMaxDigits() {
    
}


func signin() {
    
}

/*struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(globalString: <#Binding<String>#>)
    }
}*/


extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let billColor1 = Color("Bill Color 1")
}


struct KeyPadButton: View {
    var key: String
    
    var body: some View {
        Button(action: { self.action(self.key) }) {
            Color.clear
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.accentColor))
                .overlay(Text(key))
        }
    }
    
    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }
    
    @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButton.ActionKey.self] }
        set { self[KeyPadButton.ActionKey.self] = newValue }
    }
}

#if DEBUG
struct KeyPadButton_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadButton(key: "8")
            .padding()
            .frame(width: 80, height: 80)
            .previewLayout(.sizeThatFits)
    }
}
#endif


// MARK: - KEYBOARD
struct KeyPadRow: View {
    var keys: [String]
    
    var body: some View {
        HStack {
            ForEach(keys, id: \.self) { key in
                KeyPadButton(key: key)
            }
        }
    }
}

//
struct KeyPad: View {
    @Binding var string: String
    
    var body: some View {
        VStack {
            KeyPadRow(keys: ["1", "2", "3"])
            KeyPadRow(keys: ["4", "5", "6"])
            KeyPadRow(keys: ["7", "8", "9"])
            KeyPadRow(keys: ["Clear", "0", "⌫"])
        }.environment(\.keyPadButtonAction, self.keyWasPressed(_:))
    }
    
    private func keyWasPressed(_ key: String) {
        let _ = print(key)
        
        
        switch key {                
            case "." where string.contains("."): break
            case "." where string == "0": string += key
            case "⌫":
                string.removeLast()
                if string.isEmpty { string = "0" }
            case _ where string == "0": string = key
            default: string += key
        }
    }
}

//
struct ContentView : View {
    var body: some View {
        VStack {
            Spacer()
         /*   HStack {
                Spacer()
                Text(string)
            }.padding([.leading, .trailing])*/
            Divider()
            KeyPad(string: $string)
        }
        .font(.largeTitle)
        .padding()
    }
    
    @State private var string = "0"
    
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
#endif
