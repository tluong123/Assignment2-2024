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
                //To display dogs information
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
                }
                //Edit Dog button 
                Button(action: {
                    navigateToDogInfoView = true
                }) {
                    Text("Edit Dog Info")
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $navigateToDogInfoView) {
                    DogInfoView()
                        .onDisappear {
                            shouldRefresh.toggle()
                        }
                }
            }
            .navigationTitle("Dog Info Display")
            .id(shouldRefresh)
        }
    }
}
struct DogView_Previews: PreviewProvider {
    static var previews: some View {
        DogView()
            .environmentObject(DogManager())
    }
}
