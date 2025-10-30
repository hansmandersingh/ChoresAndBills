//
//  billRow.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-31.
//

import SwiftUI

struct billRow: View {
    @State var isExpanded = false
    var onEdit: (() -> Void)? = nil
    var bill: Bill
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack (alignment: .leading) {
                if let dueDate = bill.dueDate as? NSDate {
                    Text("Due: \(formattedDate((dueDate as NSDate) as Date))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                if let shared = bill.sharedWith, !shared.isEmpty {
                    Text("Shared With: \(shared.joined(separator: ", "))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Text("Status: \(bill.isPaid ? "Paid" : "Not Paid")")
                    .font(.caption)
                    .foregroundColor(bill.isPaid ? .green : .orange)
            }
        } label: {
            VStack(alignment: .leading) {
                Text(bill.title)
                Spacer()
                Text(bill.amount.description + " CAD")
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
    let mockBill: [String: Any] = [
        "title": "Pay This bill",
        "amount": 100,
        "dueDate": "2025-06-01",
        "isPaid": false,
        "sharedWith": ["hansmandersingh1998@gmail.com", "johndoe@gmail.com"]
    ]
    let bill = Bill(dictionary: mockBill as NSDictionary as? [AnyHashable: Any], documentId: "1")
    
    return billRow(bill: bill!)
}
