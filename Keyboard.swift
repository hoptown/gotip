//
//  Keyboard.swift
//  Go Tip
//
//  Created by Lawrence Lovelace on 10/10/23.
//  Copyright © 2023 Pledge Geek. All rights reserved.
//

import Foundation
import SwiftUI

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
