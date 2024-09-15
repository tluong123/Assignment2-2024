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
    @State private var showMissingFieldsAlert = false

    var task: SimpleTask?
    @State private var taskTitle: String
    @State private var taskDueDate: Date
    @State private var taskLocation: String
    @State private var taskDescription: String

    init(task: SimpleTask? = nil) { // Make the task parameter optional
        self.task = task
        _taskTitle = State(initialValue: task?.title ?? "")
        _taskDueDate = State(initialValue: task?.dueDate ?? Date())
        _taskLocation = State(initialValue: task?.location ?? "")
        _taskDescription = State(initialValue: task?.description ?? "")
    }

    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Activity Name")
                            .font(.headline)
                        Text("*")
                            .foregroundColor(.red)
                    }
                    //Suggested activity names
                    TextField("Walk, Haircut, Medication, Vet Visit", text: $taskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()

                VStack(alignment: .leading) {
                    HStack {
                        Text("Location")
                            .font(.headline)
                        Text("*")
                            .foregroundColor(.red)
                    }
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

                DatePicker("Scheduled Date", selection: $taskDueDate, displayedComponents: [.date, .hourAndMinute])
                    .padding()
                
                Button(action: {
                    // If required information is no input, then display error
                    if taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                       taskLocation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        showMissingFieldsAlert = true
                    } else {
                        if let task = task {
                            editTask(task)
                        } else {
                            addTask()
                        }
                    }
                }) {
                    // Change text depending on if the user if adding or editing
                    Text(task == nil ? "Add to Calendar" : "Save Changes")
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
            // Change text depending on if the user if adding or editing
            .navigationTitle(task == nil ? "Add New Activity" : "Edit Activity")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .alert("Please fill in all required fields.", isPresented: $showMissingFieldsAlert) {
                Button("OK", role: .cancel) { }
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
