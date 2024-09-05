//
//  ContentView.swift
//  Assignment2
//
//  Created by thomas on 3/9/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TaskManager())
            .environmentObject(DogManager())
    }
}
