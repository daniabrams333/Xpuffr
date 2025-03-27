//
//  DataView.swift
//  XPuffr3 Watch App
//
//  Created by Derrick Hines on 3/26/25.
//

import SwiftUI
import HealthKit

struct DataView: View {
    @State private var heartRate: Int = 0
    private let healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            Text("Current")
                .font(.headline)
                .foregroundColor(.blue)
            
            Text("\(heartRate) BPM")
                .font(.title)
                .bold()
                .padding(.bottom, 10)
            
            Text("Records")
                .font(.headline)
                .foregroundColor(.blue)
            
            CalendarView()
            
            Spacer()
        }
        .padding()
        .onAppear {
            fetchLatestHeartRate()
        }
    }
    
    /// Fetch the latest heart rate
    private func fetchLatestHeartRate() {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { _, results, _ in
            if let sample = results?.first as? HKQuantitySample {
                let bpm = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
                DispatchQueue.main.async {
                    self.heartRate = Int(bpm)
                }
            }
        }
        healthStore.execute(query)
    }
}

#Preview {
    DataView()
}

