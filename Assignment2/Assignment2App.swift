//
//  Assignment2App.swift
//  Assignment2
//
//  Created by thomas on 3/9/2024.
//

import SwiftUI

@main
struct Assignment2App: App {
    @StateObject private var taskManager = TaskManager()
    @StateObject private var dogManager = DogManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskManager)
                .environmentObject(dogManager)
        }
    }
}
