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
    @EnvironmentObject var dogManager: DogManager
    @State private var showAddTaskView = false
    @State private var selectedDate = Date()
    @State private var selectedTasks: Set<SimpleTask.ID> = []
    @State private var showAddDogAlert = false

    var body: some View {
        NavigationStack {
            VStack {
                FSCalendarView(selectedDate: $selectedDate)
                    .padding()
                    .frame(height: 400)
                Spacer()

                if taskManager.tasks.isEmpty {
                    Text("No upcoming tasks")
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
//                    if dogManager.dog.name.isEmpty {
//                        showAddDogAlert = true
//                    } else {
                        showAddTaskView.toggle()
//                    }
                }) {
                    Text("Add New Activity")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .padding()
                .sheet(isPresented: $showAddTaskView) {
                    AddTaskView()
                        .environmentObject(taskManager)
                }
                .alert("Please add your dog's information first.", isPresented: $showAddDogAlert) {
                    Button("OK", role: .cancel) { }
                }

                Spacer()
            }
            .navigationTitle("Activity Calendar")
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
