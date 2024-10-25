//
//  HomeView.swift
//  Go Tip
//
//  Created by Lawrence Lovelace on 8/4/23.
//  Copyright © 2023 Pledge Geek. All rights reserved.
//
// buttons:  https://developer.apple.com/documentation/swiftui/button

import SwiftUI

struct HomeView: View {
    
    @State var billAmount: String = ""
    var tips = ["0", "10", "15", "20"]
    @State private var selectedTip = ""
    
    var body: some View {
        GeometryReader { geometry in
            Color("BackGround2")
                .ignoresSafeArea().zIndex(0).overlay(
                    VStack {
                        HStack {
                            Image(systemName: "graduationcap.fill")
                                .padding(.trailing, 5)
//                                .font(.largeTitle)
                                .font(.system(size: 40, design: .rounded))
                            Text("Fat Tip").zIndex(2).font(.largeTitle)
                        }.padding(.top, 24).padding(.bottom, 24)
                        
                        HStack {
                            ZStack {
                                Color("BackGround2").ignoresSafeArea().zIndex(0)
                                VStack {
                                    
                                    Text("Total/person").padding(.init(top: 10, leading: 0, bottom: 0, trailing: 5))
                                        .font(.system(size: 24, design: .serif)).padding(.bottom, 10)
                                    
                                    Text("$40.00")/*.padding(.init(top: 10, leading: 0, bottom: 0, trailing: 5))*/
                                        .font(.largeTitle)
                                        .fontWeight(.black)
                                    //.font(.system(size: 44, design: .serif)
                                    
                                    Divider().frame(width: geometry.size.width * 0.75, height: 2).padding(EdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5))
                                        .overlay(.pink)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        VStack {
                                            Text("Total bill").foregroundColor(.billColor1).font(.title3)
                                                .fontWeight(.semibold).minimumScaleFactor(0.1)
                                            
                                            Spacer()
                                            
                                            Text("$0.00").foregroundColor(.billColor1).font(.title3)
                                                .fontWeight(.semibold).minimumScaleFactor(0.1)
                                        }.padding(.leading)
                                        
                                        Spacer()
                                    
                                        VStack {
                                            Text("Total tip").foregroundColor(.billColor1).font(.title3)
                                                .fontWeight(.semibold).minimumScaleFactor(0.1)
                                            
                                            Spacer()
                                            
                                            Text("$0.00").foregroundColor(.billColor1).font(.title3)
                                                .fontWeight(.semibold).minimumScaleFactor(0.1)
                                            
                                        }.padding(.trailing)
                                        
                                    }.padding(.bottom).foregroundColor(.billColor1).font(.title3).fontWeight(.semibold)
                                    /*Text("Total/person").padding(.init(top: 10, leading: 0, bottom: 0, trailing: 5))
                                        .font(.system(size: 24, design: .serif))*/
                                    Spacer()
                                }.zIndex(1)
                            }
                        }
                        .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.25)
//                            .background(.red)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .padding(.bottom, 40)
//                            .clipShape(Capsule())
                        
                        // end of 2nd stack
                        
                        /* -Enter your bill- */
                        HStack {
                            HStack {
                                Text("Enter your bill").minimumScaleFactor(0.01)
                            }.padding(.trailing)
                                .frame(width: geometry.size.width * 0.25)
                            
                            HStack {
                                ZStack {
                                    Color.white
                                    TextField("$", text: $billAmount)
                                        .frame(maxWidth: .infinity, alignment: .leading).padding(.leading).font(.largeTitle)
                                        .fontWeight(.bold)
                                }
                            }.cornerRadius(10)
                                .frame(width: geometry.size.width * 0.65, height: geometry.size.width * 0.20)
                                
                        }.frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.07).padding(.bottom, 20)
                            .padding(.trailing, 40)
                            .padding(.leading, 30)
                        
                        
                        // end of 3rd stack
                        
                        HStack {
                            HStack {
                                Text("Choose your tip").cornerRadius(10).minimumScaleFactor(0.01)
                            }.padding(.trailing)
                                .frame(width: geometry.size.width * 0.25)
                                
                            HStack {
                                HStack {
                                    Text("10%")
                                        .font(.system(size: 30, weight: .bold, design: .rounded)).minimumScaleFactor(0.01).foregroundColor(.white)
                                }.frame(width: geometry.size.width * 0.15).padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10)).background(Color.billColor1).cornerRadius(10)
                                
                                Spacer()
                                
                                HStack {
                                    Text("15%").font(.system(size: 30, weight: .bold, design: .rounded)).minimumScaleFactor(0.01).foregroundColor(.white)
                                }.frame(width: geometry.size.width * 0.15).padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10)).background(Color.billColor1).cornerRadius(10)
                                
                                Spacer()
                                
                                HStack {
                                    Text("20%").font(.system(size: 30, weight: .bold, design: .rounded)).minimumScaleFactor(0.01).foregroundColor(.white)
                                }.frame(width: geometry.size.width * 0.15).padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10)).background(Color.billColor1).cornerRadius(10)
                                
                            }.frame(width: geometry.size.width * 0.65)
                                
                            
                        }.frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.10).padding(.trailing, 40).padding(.leading, 30).padding(.bottom, -10)

                            // end 4th stack, tip
                        
                        
                        HStack {
                            HStack {
                                
                            }.padding(.trailing)
                                .frame(width: geometry.size.width * 0.25)
                            
                            HStack {
                                HStack {
                                    Text("Custom tip").font(.system(size: 24, weight: .bold, design: .default)).minimumScaleFactor(0.01).foregroundColor(.white)
                                }
                            }.frame(width: geometry.size.width * 0.65, height: geometry.size.height * 0.1)
                                .background(Color.billColor1).cornerRadius(10).padding(.top, 20)
                            
                        }.frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.20).padding(.trailing, 40).padding(.leading, 30).padding(.top, -40)
                        
                        // end custom tip stack
                        
                        
                        /* -Split the total- */
                        HStack {
                            HStack {
                                Text("Split the total").minimumScaleFactor(0.01)
                            }.padding(.trailing)
                                .frame(width: geometry.size.width * 0.25)
                            
                            
                            HStack {
                                HStack {
                                    Button(action: signin) {
                                        Label("", systemImage: "minus")}.font(.system(size: 30, weight: .bold, design: .serif)).minimumScaleFactor(0.01).foregroundColor(.white)
                                }.frame(width: geometry.size.width * 0.18, height: geometry.size.height).background(Color.billColor1)
                                
                                
                                Spacer()
                                HStack {
                                    Button(action: signin) {
                                        Text("2")
                                    }.font(.system(size: 35, weight: .bold, design: .rounded)).minimumScaleFactor(0.01).foregroundColor(.black)
                                }.frame(width: geometry.size.width * 0.25)
                                
                                
                                Spacer()
                                HStack {
                                    Button(action: signin) {
                                        Label("", systemImage: "plus")
                                    }.font(.system(size: 30, weight: .bold, design: .serif)).minimumScaleFactor(0.01).foregroundColor(.white)
                                }.frame(width: geometry.size.width * 0.18, height: geometry.size.height).background(Color.billColor1)
                                
                            }.frame(width: geometry.size.width * 0.65, height: geometry.size.height * 0.1)
                                .background(Color.white).cornerRadius(15).fontWeight(.black)
                            // end right side split
                            
                        }.frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.07).padding(.bottom, 20)
                            .padding(.trailing, 40)
                            .padding(.leading, 30)
                        
                        
                        // end of last stack, split
                        
                        /*Picker("select a tip", selection: $selectedTip) {
                            ForEach(tips, id: \.self) {
                                Text($0)
                            }
                        }
                        Text("You selected: \(selectedTip)")*/
                        
                        
                        // keypad
                       /* KeyPad(string: $textValue).padding(.top, -30).padding(.leading, 20).padding(.trailing, 20)*/
                        Spacer()
                    }.zIndex(1)
                    // ends master v stack
                ) // ends overlay
        }
    }
}

                        func signin() {
                            
                        }
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


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


//
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
            HStack {
                Spacer()
                Text(string)
            }.padding([.leading, .trailing])
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
