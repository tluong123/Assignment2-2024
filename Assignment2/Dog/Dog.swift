//
//  Dog.swift
//  Assignment2
//
//  Created by thomas on 3/9/2024.
//

import Foundation
import Combine

// Protocol for Dog's information 
protocol Dog {
    var id: UUID { get } 
    var name: String { get set }
    var age: Int { get set }
    var breed: String { get set }
    var size: String { get set }
    var weight: Int { get set }
}

//Implementation of Dog Protocol
class SimpleDog: Dog, Identifiable, ObservableObject {
    var id: UUID
    @Published var name: String
    @Published var age: Int
    @Published var breed: String
    @Published var size: String
    @Published var weight: Int
    
    // Initializer to create a SimpleDog instance
    init(id: UUID = UUID(), name: String = "", age: Int = 0, breed: String = "", size: String = "", weight: Int = 0) {
        self.id = id
        self.name = name
        self.age = age
        self.breed = breed
        self.size = size
        self.weight = weight
    }
}
