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
                //Calendar which allows user to select date
                FSCalendarView(selectedDate: $selectedDate)
                    .padding()
                    .frame(height: 400)
                Spacer()
                //If no tasks on that date, then show message
                if taskManager.tasks.isEmpty {
                    Text("No upcoming tasks")
                        .foregroundColor(.gray)
                // If there are tasks, then displays lists of tasks for the date
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
                    // Checks to see if Dog info is available to enforce users to add their dog first
                    if dogManager.dog.name.isEmpty {
                        showAddDogAlert = true
                    } else {
                        showAddTaskView.toggle()
                    }
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
                //Error to enforce user to add dog information first
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
