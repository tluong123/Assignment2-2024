//
//  Tasks.swift
//  Assignment2
//
//  Created by thomas on 3/9/2024.
//

import Foundation
import Combine

protocol Task {
    var id: UUID { get }
    var title: String { get set }
    var isCompleted: Bool { get set }
    var dueDate: Date? { get set }
}

class SimpleTask: Task, Identifiable, ObservableObject {
    var id: UUID
    @Published var title: String
    @Published var isCompleted: Bool
    @Published var dueDate: Date?
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, dueDate: Date? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
    }
}

