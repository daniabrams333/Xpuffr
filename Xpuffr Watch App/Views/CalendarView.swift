//
//  CalendarView.swift
//  XPuffr3 Watch App
//
//  Created by Derrick Hines on 3/26/25.
//

import SwiftUI

struct CalendarView: View {
    let dates = (1...30).map { Calendar.current.date(byAdding: .day, value: -$0, to: Date())! }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(dates, id: \.self) { date in
                    VStack {
                        Text(date, style: .date)
                            .font(.footnote)
                            .foregroundColor(.white)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.orange.opacity(0.7))
                            .overlay(
                                Text("🔥")
                                    .font(.title2)
                            )
                    }
                    .padding(5)
                }
            }
        }
    }
}

#Preview {
    CalendarView()
}

