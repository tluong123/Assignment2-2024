//
//  FSCalendarView.swift
//  Assignment2
//
//  Created by thomas on 9/9/2024.
//

import Foundation
import SwiftUI
import FSCalendar

struct FSCalendarView: UIViewRepresentable {
    @Binding var selectedDate: Date

    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.select(selectedDate)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        let parent: FSCalendarView

        init(_ parent: FSCalendarView) {
            self.parent = parent
        }

        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
    }
}
