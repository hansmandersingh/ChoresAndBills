//
//  ChoreEdit.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-15.
//

import SwiftUI

struct ChoreEdit: View {
    @State var chore: Chore
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
            }
            .navigationTitle("Edit Chores")
        }
    }
}
