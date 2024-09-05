//
//  DogView.swift
//  Assignment2
//
//  Created by thomas on 3/9/2024.
//

import Foundation
import SwiftUI

struct DogView: View {
    @EnvironmentObject var dogManager: DogManager
    @State private var navigateToDogInfoView = false
    @State private var shouldRefresh = false 
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Dog Information")) {
                    HStack {
                        Text("Name:")
                        Spacer()
                        Text(dogManager.dog.name)
                    }
                    HStack {
                        Text("Age:")
                        Spacer()
                        if dogManager.dog.age > 0 {
                            Text("\(dogManager.dog.age)")
                        }
                    }
                    HStack {
                        Text("Breed:")
                        Spacer()
                        Text(dogManager.dog.breed)
                    }
                    HStack {
                        Text("Size:")
                        Spacer()
                        Text(dogManager.dog.size)
                    }
                    HStack {
                        Text("Weight:")
                        Spacer()
                        if dogManager.dog.weight > 0 {
                        Text("\(dogManager.dog.weight)")
                        }
                    }
                    HStack {
                        Text("Medication:")
                        Spacer()
                        Text(dogManager.dog.medication)
                    }
                }
                
                Button(action: {
                    navigateToDogInfoView = true
                }) {
                    Text("Edit Dog Info")
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $navigateToDogInfoView) {
                    DogInfoView()
                        .onDisappear {
                            shouldRefresh.toggle() // Toggle to force a refresh
                        }
                }
            }
            .navigationTitle("Dog Info Display")
            .id(shouldRefresh) // Force re-render when shouldRefresh changes
        }
    }
}
struct DogView_Previews: PreviewProvider {
    static var previews: some View {
        DogView()
            .environmentObject(DogManager()) // Make it available in the environment
    }
}
