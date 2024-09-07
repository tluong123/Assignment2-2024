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
    var location: String { get set } // Add location property
    var description: String { get set } // Add description property
}

class SimpleTask: Task, Identifiable, ObservableObject {
    var id: UUID
    @Published var title: String
    @Published var isCompleted: Bool
    @Published var dueDate: Date?
    @Published var location: String
    @Published var description: String

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, dueDate: Date? = nil, location: String = "", description: String = "") {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.location = location
        self.description = description
    }
}
