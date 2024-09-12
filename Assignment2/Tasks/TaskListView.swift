//
//  TaskListView.swift
//  Assignment2
//
//  Created by thomas on 3/9/2024.
//

import Foundation
import SwiftUI
import FSCalendar

struct TaskListView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var showAddTaskView = false
    @State private var selectedDate = Date()
    @State private var selectedTasks: Set<SimpleTask.ID> = []

    var body: some View {
        NavigationStack {
            VStack {
                FSCalendarView(selectedDate: $selectedDate)
                    .padding()
                    .frame(height: 400)
                Spacer()

                if taskManager.tasks.isEmpty {
                    Text("No upcoming walks")
                        .foregroundColor(.gray)
                } else {
                    List(selection: $selectedTasks) {
                        ForEach(taskManager.tasks.filter { task in
                            if let dueDate = task.dueDate {
                                return Calendar.current.isDate(dueDate, inSameDayAs: selectedDate)
                            } else {
                                return false
                            }
                        }) { task in
                            TaskRowView(task: task)
                        }
                    }
                }


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

                Spacer()

                if !taskManager.tasks.isEmpty && !selectedTasks.isEmpty {
                    Button(action: {
                        deleteSelectedTasks()
                    }) {
                        Text("Delete Selected Tasks")
                            .foregroundColor(.red)
                    }
                    .padding()
                }
            }
            .navigationTitle("Walk Schedule")
        }
    }

    func deleteSelectedTasks() {
        taskManager.tasks.removeAll(where: { selectedTasks.contains($0.id) })
        selectedTasks.removeAll()
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environmentObject(TaskManager())
            .environmentObject(DogManager())
    }
}
