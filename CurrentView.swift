//
//  CurrentView.swift
//  Xpuffr Watch App
//
//  Created by Danielle Abrams on 3/27/25.
//

import SwiftUI

struct CurrentView: View {
    @State private var value = 0
    var body: some View {
        VStack {
            HStack {
                Text("❤️")
                    .font(.system(size: 50))
                Spacer()
            }
            
            HStack {
                Text("\(value)")
                    .fontWeight(.regular)
                    .font(.system(size: 70))
                
                Text("BPM")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding(.bottom, 28.0)
                
                Spacer()
            }
        }
        .padding()
        //.onAppear(perform: start)
    }
}

#Preview {
    CurrentView()
}
