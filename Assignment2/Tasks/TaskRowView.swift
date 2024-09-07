//
//  TaskRowView.swift
//  Assignment2
//
//  Created by thomas on 4/9/2024.
//

import Foundation
import SwiftUI

struct TaskRowView: View {
    @EnvironmentObject var taskManager: TaskManager
    @ObservedObject var task: SimpleTask
    @State private var showEditTaskView = false
    @State private var isShowingDetails = false // To control detail view presentation

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .strikethrough(task.isCompleted, color: .gray)
                    .foregroundColor(task.isCompleted ? .gray : .primary)

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
        .contentShape(Rectangle())
        .onTapGesture {
            isShowingDetails.toggle() // Show detail view on tap
        }
        .swipeActions(edge: .trailing) {
            Button(action: {
                taskManager.toggleTaskCompletion(task) // Mark as complete on swipe
            }) {
                Label("Complete", systemImage: "checkmark.circle.fill")
            }
            .tint(.green)

            Button {
                showEditTaskView = true
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.blue)
        }
        .sheet(isPresented: $showEditTaskView) {
            AddTaskView(task: task)
                .environmentObject(taskManager)
        }
        .sheet(isPresented: $isShowingDetails) { // Detail view sheet
            WalkDetailView(task: task)
        }
    }
}

