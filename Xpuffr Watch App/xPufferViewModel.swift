//
//  xPufferViewModel.swift
//  xPufferbeta Watch App
//
//  Created by Danielle Abrams on 3/26/25.
//

import SwiftUI
import Foundation
import HealthKit

class xPufferViewModel: NSObject, ObservableObject {
    
    
    
    let healthStore = HKHealthStore()
    var smkSession: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    
    func startSession() {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .cooldown
        configuration.locationType = .outdoor
        
        do {
            smkSession = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = smkSession?.associatedWorkoutBuilder()
        } catch {
            // Handle any exceptions.
            return
        }
        
        
        builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
        smkSession?.delegate = self
        builder?.delegate = self
        
        let startDate = Date()
        smkSession?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate, completion: { success, error in
            
            // The workout has started
        })
        
    }
    
    // Request authorization to access HealthKit.
    func requestAuthorization() {
        // The quantity type to write to the health store.
        
        let typesToShare: Set = [HKQuantityType.workoutType()]
        
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .restingHeartRate)!,
            HKQuantityType.quantityType(forIdentifier: .oxygenSaturation)!
            
        ]
        
        // Request authorization for those quantity types
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) {
            success, errror in
            // Handle error.
        }
    }
    
    
    @Published var running = false
    @Published var averageHeartRate: Double = 0
    @Published var heartRate: Double = 0
    @Published var workout: HKWorkout?
    
    
}
extension xPufferViewModel: HKWorkoutSessionDelegate {

    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        DispatchQueue.main.async {
            self.running = toState == .running
        }
        // Wait for the session to transiton state bebfore ending the builder.
        if toState == .ended {
            builder?.endCollection(withEnd: date, completion: { success, error in
                self.builder?.finishWorkout(completion: { workout, error in
                    DispatchQueue.main.async {
                        self.workout = workout
                    }
                })
            })
        }
    }

func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: any Error) {
    
}
        }

extension xPufferViewModel: HKLiveWorkoutBuilderDelegate {
    /* ------------------------------------------------------------------------------------ */
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        // Nothing to see here.
    }
   /*--------------------------------------------------------------------------------------*/
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else { return }
            let statistics = workoutBuilder.statistics(for: quantityType)
            
            // Update the published value.
            updateForStatistics(statistics)
        }
    }

    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics else {
            return
        }
        
        DispatchQueue.main.async {
            switch statistics.quantityType {
                
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                 let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                self.averageHeartRate = statistics.averageQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                
            default: return
                
            
                
            }
        }
    }
   
}
