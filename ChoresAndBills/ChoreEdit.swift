//
//  ChoreAdd.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-25.
//

import SwiftUI

struct ChoreEdit: View {
    @State var chore: Chore
    @State private var date = Date()
    let title: String
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField(chore.title, text: $chore.title)
                }
                Section(header: Text("Details")) {
                    TextField(chore.details, text: $chore.details)
                        .textFieldStyle(.automatic)
                }
                Section(header: Text("Due Date")) {
                    DatePicker("Due Date", selection: $chore.dueDate, displayedComponents: [.date])
                }
            }
            .navigationTitle("Edit Chores")
        }
    }
}

#Preview {
    let mockDict: [String: Any] = [
        "title": "Take out the trash",
        "details": "Do it before 8 PM",
        "dueDate": Timestamp(date: Date()),
        "isCompleted": false,
        "sharedWith": ["hansmander007@gmail.com"]
    ]
    let chore = Chore(dictionary: mockDict as NSDictionary as? [AnyHashable : Any], documentId: "1")
    ChoreEdit(chore: chore!, title: chore!.title)
}
