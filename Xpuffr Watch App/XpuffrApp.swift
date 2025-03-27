//
//  XpuffrApp.swift
//  Xpuffr Watch App
//
//  Created by Danielle Abrams on 3/27/25.
//

import SwiftUI
import HealthKit

@main
struct Xpuffr_Watch_AppApp: App {
    
    @StateObject var xPuffrModel = xPufferViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SmokingView()
                    .environmentObject(xPuffrModel)
            }
           
        }
    }
}
