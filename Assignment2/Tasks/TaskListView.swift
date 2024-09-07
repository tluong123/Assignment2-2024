//
//  TaskListView.swift
//  Assignment2
//
//  Created by thomas on 3/9/2024.
//

import Foundation
import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var showAddTaskView = false

    var body: some View {
        NavigationStack {
            VStack {
                if taskManager.tasks.isEmpty {
                    Text("No upcoming walks")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(taskManager.tasks) { task in
                            TaskRowView(task: task)
                        }
                        .onDelete(perform: taskManager.removeTask)
                    }
                }
                
                // Add Task Button
                Button(action: {
                    showAddTaskView.toggle()
                }) {
                    Text("Add New Walk")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .padding()
                .sheet(isPresented: $showAddTaskView) {
                    AddTaskView()
                        .environmentObject(taskManager)
                }
            }
            .navigationTitle("Walk Schedule")
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environmentObject(TaskManager())
            .environmentObject(DogManager())
    }
}
