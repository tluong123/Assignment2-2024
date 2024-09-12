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
                                        
                                        if task.isCompleted {
                                            Text("Complete")
                                                .font(.subheadline)
                                                .foregroundColor(.green)
                                        } else if let dueDate = task.dueDate {
                                            Text("\(dueDate, style: .date)")
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
                        NavigationLink(destination: TaskListView()
                            .environmentObject(taskManager)
                            .onDisappear {
                                shouldRefresh.toggle()
                            }
                        ) {
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
                        
                        Spacer()
                        
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
