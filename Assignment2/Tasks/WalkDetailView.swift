//
//  WalkDetailView.swift
//  Assignment2
//
//  Created by thomas on 7/9/2024.
//

import Foundation
import SwiftUI
// New struct to display task details
struct WalkDetailView: View {
    let task: SimpleTask
    @EnvironmentObject var taskManager: TaskManager
    @Environment(\.presentationMode) var presentationMode
    @State private var showEditTaskView = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.largeTitle)
                    .padding()
                
                VStack(alignment: .leading) {
                    if let dueDate = task.dueDate {
                        VStack(alignment: .leading) {
                            Text("Scheduled Time")
                                .font(.headline)
                            Text("\(dueDate, format: .dateTime)")
                                .padding(.bottom)
                        }
                    }
                    
                    if !task.location.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Location")
                                .font(.headline)
                            Text("\(task.location)")
                                .padding(.bottom)
                        }
                    }
                    
                    if !task.description.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Description")
                                .font(.headline)
                            Text(task.description)
                                .padding(.bottom)
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    taskManager.toggleTaskCompletion(task)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Mark Complete")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            showEditTaskView = true
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.blue)
                        
                        Button(role: .destructive) {
                            if let index = taskManager.tasks.firstIndex(of: task) {
                                taskManager.removeTask(at: IndexSet(integer: index))
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showEditTaskView) {
            AddTaskView(task: task)
                .environmentObject(taskManager)
        }
    }
}

