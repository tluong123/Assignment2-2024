//
//  MainView.swift
//  Assignment2
//
//  Created by thomas on 3/9/2024.
//

import Foundation
import SwiftUI

struct MainView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @EnvironmentObject private var dogManager: DogManager
    @State private var navigateToDogInfoView = false
    @State private var showTaskList = false
    @State private var showDogInfo = false
    @State private var shouldRefresh = false

    var body: some View {
        NavigationStack {
            VStack {
                // Dog Information Section (conditional
                if dogManager.dog.name.isEmpty {
                    NavigationLink(destination: DogInfoView()
                        .onDisappear {
                            shouldRefresh.toggle() // Toggle to force a refresh
                        }) {
                            Text("Add your dog now!")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                } else {                    HStack {
                        VStack(alignment: .leading) {
                            Text(dogManager.dog.name)
                                .font(.title2)
                            Text("\(dogManager.dog.age) years old, \(dogManager.dog.breed)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()

                        Spacer()
                    }
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding()
                }

                Spacer()

                // Upcoming tasks section
                VStack(alignment: .leading) {
                    Text("Upcoming Walks")
                        .font(.headline)
                        .padding(.leading)
                    
                    if taskManager.tasks.isEmpty {
                        Text("No walks scheduled.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        List {
                            ForEach(taskManager.tasks) { task in
                                HStack {
                                    Text(task.title)
                                        .font(.headline)
                                    Spacer()
                                    if !task.isCompleted {
                                        Text("Due Soon")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                    }
                }
                
                
                
                Spacer()
                
               
                HStack {
                    
                    Button(action: {
                        showTaskList.toggle()
                    }) {
                        VStack {
                            Image(systemName: "figure.walk")
                                .font(.system(size: 24))
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                            
                            Text("Your Walks")
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                    }
                    .sheet(isPresented: $showTaskList) {
                        TaskListView()
                            .environmentObject(taskManager)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: DogView()) {
                        VStack {
                            Image(systemName: "pawprint")
                                .font(.system(size: 24))
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Circle())

                            Text("Your Dog")
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
            }
            .navigationTitle("FitPaws")
            .edgesIgnoringSafeArea(.bottom)
            .id(shouldRefresh)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(TaskManager())
            .environmentObject(DogManager())
    }
}
