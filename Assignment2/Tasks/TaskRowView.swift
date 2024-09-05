//
//  TaskRowView.swift
//  Assignment2
//
//  Created by thomas on 4/9/2024.
//

import Foundation
import SwiftUI

struct TaskRowView: View {
    @ObservedObject var task: SimpleTask
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .strikethrough(task.isCompleted, color: .gray)
                    .foregroundColor(task.isCompleted ? .gray : .primary)
            }
            Spacer()
            if task.isCompleted {
                Text("Complete")
                    .font(.subheadline)
                    .foregroundColor(.green)
            } else if let dueDate = task.dueDate {
                Text("Due: \(dueDate, style: .date)")
                    .font(.subheadline)
                    .foregroundColor(.red)
            }
        }
        .contentShape(Rectangle()) // Makes the entire row tappable
        .onTapGesture {
            task.isCompleted.toggle() // Toggling directly updates the UI
        }
    }
}

