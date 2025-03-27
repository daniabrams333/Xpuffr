//
//  SmokingView.swift
//  XPuffr3 Watch App
//
//  Created by Derrick Hines on 3/26/25.
//

import SwiftUI
import HealthKit
// import ClockKit

struct SmokingView: View {
    
    @EnvironmentObject private var xPuffrModel: xPufferViewModel
    
    @State private var smokingCount = UserDefaults.standard.integer(forKey: "smokingSessions")
    
    var body: some View {
        Text("XPuffr")
            .font(.title)
            .bold()
            .foregroundColor(.orange)
        List {
          
            
            NavigationLink(
                "Smoking 🚬",
                destination: RecordingView()
            ).padding(
                EdgeInsets(top:15, leading: 5, bottom: 15, trailing: 5)
                )
                
                
                // add log action here
                //                logSmokingSession()
            
        
            
            NavigationLink(
                "Data 📊",
                destination: DataView()
            ) .padding(
                EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            )
           
        }
        .onAppear {
            xPuffrModel.requestAuthorization()
        }
        //
        //    private func logSmokingSession() {
        //        smokingCount += 1
        //        UserDefaults.standard.set(smokingCount, forKey: "smokingSessions")
        //
        //        // 🔄 Refresh the complication
        //        let server = CLKComplicationServer.sharedInstance()
        //        for complication in server.activeComplications ?? [] {
        //            server.reloadTimeline(for: complication)
                }
            }
    
    
    #Preview {
        SmokingView()
            .environmentObject(xPufferViewModel())
    }

