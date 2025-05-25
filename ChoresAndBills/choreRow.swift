//
//  choreRow.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-15.
//

import SwiftUI

struct choreRow: View {
    @State var isExpanded = false
    var onEdit: (() -> Void)? = nil
    var chore: Chore
    var body: some View {
        
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading) {
                if let dueDate = chore.dueDate as? NSDate {
                    Text("Due: \(formattedDate((dueDate as NSDate) as Date))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                if let shared = chore.sharedWith, !shared.isEmpty {
                    Text("Shared With: \(shared.joined(separator: ", "))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Text("Status: \(chore.isCompleted ? "Completed" : "Pending")")
                    .font(.caption)
                    .foregroundColor(chore.isCompleted ? .green : .orange)
            }
        } label: {
            VStack(alignment: .leading) {
                Text(chore.title)
                
                Text(chore.details)
                    .font(.footnote)
            }
            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    isExpanded.toggle()
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                        // delete action
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    //showingEdit = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
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
    return choreRow(chore: chore!)
}
