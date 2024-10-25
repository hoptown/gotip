//
//  GoTip_App.swift
//  Go Tip
//
//  Created by Lawrence Lovelace on 12/12/23.
//  Copyright © 2023 Pledge Geek. All rights reserved.
//

import Foundation
import SwiftUI

@main
struct GoTip_App: App {
    
    @AppStorage("maxFractions") private var maxFractions: Int = 2
    
    var body: some Scene {
        
        WindowGroup {
            MainView()
        }
    }
}
