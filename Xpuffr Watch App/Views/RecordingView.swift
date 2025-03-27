//
//  RecordingView.swift
//  XPuffr3 Watch App
//
//  Created by Derrick Hines on 3/26/25.
//

import SwiftUI

struct RecordingView: View {
    var body: some View {
        VStack {
            Text("Recording")
                .font(.title)
                .bold()
                .foregroundColor(.red)
            
            Image(systemName: "circle.hexagongrid.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            
            NavigationLink(
                "Current Stats",
                destination: CurrentView()
            ) .padding(
                EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            
            )
               
            
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    RecordingView()
}

