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
    @State private var shouldRefresh = false

    var body: some View {
        NavigationStack {
                VStack {
                    // If no dog information is available, show a button
                    if dogManager.dog.name.isEmpty {
                        NavigationLink(destination: DogInfoView()
                            .onDisappear {
                                shouldRefresh.toggle()
                            }) {
                                Text("Add your dog now!")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding()
                    } else {
                        // If dog information is available, display it
                        HStack {
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
                    
                    //Task Schedule Section
                    VStack(alignment: .leading) {
                        Text("Upcoming Schedule")
                            .font(.headline)
                            .padding(.leading)
                        // If there are no tasks, display a message
                        if taskManager.tasks.isEmpty {
                            Text("No activites scheduled")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            // Otherwise, display the list of tasks
                            List {
                                ForEach(taskManager.tasks) { task in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(task.title)
                                                .font(.headline)
                                            
                                            if !task.location.isEmpty {
                                                Text("At \(task.location)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        
                                        Spacer()
                                        // Display "Complete" or date scheduled
                                        if task.isCompleted {
                                            Text("Complete")
                                                .font(.subheadline)
                                                .foregroundColor(.green)
                                        } else if let dueDate = task.dueDate {
                                            Text("\(dueDate, format: .dateTime)")
                                                .font(.subheadline)
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    
                    
                    Spacer()
                    
                    // Taskbar buttons
                    HStack {
                        // Link to Calendar
                        NavigationLink(destination: TaskListView()
                            .environmentObject(taskManager)
                            .onDisappear {
                                shouldRefresh.toggle()
                            }
                        ) {
                            VStack {
                                Image(systemName: "calendar")
                                    .font(.system(size: 24))
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Calendar")
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        Spacer()
                        // Link to viewing Dog information
                        NavigationLink(destination: DogView()
                            .onDisappear {
                                shouldRefresh.toggle()
                            }) {
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
