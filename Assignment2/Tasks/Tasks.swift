//
//  Tasks.swift
//  Assignment2
//
//  Created by thomas on 3/9/2024.
//

import Foundation
import Combine

//Protocol for Task information
protocol Task {
    var id: UUID { get }
    var title: String { get set }
    var isCompleted: Bool { get set }
    var dueDate: Date? { get set }
    var location: String { get set } // Add location property
    var description: String { get set } // Add description property
}
// Implementation of the Task protocol
class SimpleTask: Task, Identifiable, ObservableObject, Equatable {
    var id: UUID
    @Published var title: String
    @Published var isCompleted: Bool
    @Published var dueDate: Date?
    @Published var location: String
    @Published var description: String
    
    // Defines how to compare two SimpleTask objects for equality (needed for Equatable)
    static func == (lhs: SimpleTask, rhs: SimpleTask) -> Bool {
            return lhs.id == rhs.id
        }
    // Initializer to create a SimpleTask instance
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, dueDate: Date? = nil, location: String = "", description: String = "") {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.location = location
        self.description = description
    }
}
