//
//  AddTaskView.swift
//  Assignment2
//
//  Created by thomas on 3/9/2024.
//

import Foundation
import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    @EnvironmentObject var dogManager: DogManager
    @Environment(\.presentationMode) var presentationMode

    var task: SimpleTask?
    @State private var taskTitle: String
    @State private var taskDueDate: Date
    @State private var taskLocation: String
    @State private var taskDescription: String

    init(task: SimpleTask? = nil) { // Make the task parameter optional
        self.task = task
        _taskTitle = State(initialValue: task?.title ?? "New Walk with ")
        _taskDueDate = State(initialValue: task?.dueDate ?? Date())
        _taskLocation = State(initialValue: task?.location ?? "")
        _taskDescription = State(initialValue: task?.description ?? "")
    }

    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("Walk Name")
                        .font(.headline)
                    TextField("New Walk", text: $taskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear {
                            if task == nil, !dogManager.dog.name.isEmpty { // Only append for new tasks
                                taskTitle += dogManager.dog.name
                            }
                        }
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Location")
                        .font(.headline)
                    TextField("Enter location", text: $taskLocation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Description (optional)")
                        .font(.headline)
                    TextField("Enter description", text: $taskDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()

                DatePicker("Due Date", selection: $taskDueDate, displayedComponents: .date)
                    .padding()

                Button(action: {
                    if let task = task {
                        editTask(task) // Edit existing task
                    } else {
                        addTask() // Add new task
                    }
                }) {
                    Text(task == nil ? "Add Walk" : "Save Changes") // Change button label based on context
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                Spacer()
            }
            .padding()
            .navigationTitle(task == nil ? "Add New Walk" : "Edit Walk") // Change title based on context
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    private func addTask() {
        let newTask = SimpleTask(
            title: taskTitle,
            dueDate: taskDueDate,
            location: taskLocation,
            description: taskDescription
        )
        taskManager.addTask(newTask)
        presentationMode.wrappedValue.dismiss()
    }

    private func editTask(_ task: SimpleTask) {
        if let index = taskManager.tasks.firstIndex(where: { $0.id == task.id }) {
            taskManager.tasks[index].title = taskTitle
            taskManager.tasks[index].dueDate = taskDueDate
            taskManager.tasks[index].location = taskLocation
            taskManager.tasks[index].description = taskDescription
        }
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(TaskManager())
            .environmentObject(DogManager())
    }
}
