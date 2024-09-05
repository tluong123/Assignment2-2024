//
//  TaskList.swift
//  Assignment2
//
//  Created by thomas on 3/9/2024.
//

import Foundation
import SwiftUI

class TaskManager: ObservableObject {
    @Published var tasks: [SimpleTask] = []
    
    func addTask(_ task: SimpleTask) {
        tasks.append(task)
    }
    
    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func toggleTaskCompletion(_ task: SimpleTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}
