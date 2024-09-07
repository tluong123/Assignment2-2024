//
//  WalkDetailView.swift
//  Assignment2
//
//  Created by thomas on 7/9/2024.
//

import Foundation
import SwiftUI
// New struct to display task details
struct WalkDetailView: View {
    let task: SimpleTask

    var body: some View {
        VStack(alignment: .leading) { // Main VStack for the whole view
            Text(task.title)
                .font(.largeTitle)
                .padding()

            VStack(alignment: .leading) { // VStack for details
                if let dueDate = task.dueDate {
                    VStack(alignment: .leading) {
                        Text("Scheduled Time")
                            .font(.headline)
                        Text("\(dueDate, style: .date)")
                            .padding(.bottom)
                    }
                }

                if !task.location.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Location")
                            .font(.headline)
                        Text("\(task.location)")
                            .padding(.bottom)
                    }
                }

                if !task.description.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.headline)
                        Text(task.description)
                            .padding(.bottom)
                    }
                }
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}
