//
//  BillsView.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-07.
//

import SwiftUI
import Foundation

struct SwiftBill: Identifiable, Hashable {
    var id: String
    var title: String
    var amount: Float
    var originalBill: Bill
    
    init(bill: Bill) {
        self.id = bill.billId
        self.title = bill.title
        self.amount = bill.amount
        self.originalBill = bill
    }
}

@objc class BillsViewControllerSwift: UIViewController {
    @objc static func create(_ userData: UserInfo, _ bills:[Bill]) -> UIViewController {
        let swiftBills = bills.map{ SwiftBill(bill: $0) }
        let swiftBillsView = BillsView(userData: userData, stateFullBill: swiftBills)
        let hostingVC = UIHostingController(rootView: swiftBillsView)
         hostingVC.navigationItem.largeTitleDisplayMode = .always
        return hostingVC
    }
}

struct BillRow: View {
    var title:String
    var bill: Bill
    var body: some View {
        Text(title)
    }
    
}


struct BillsView: View {
    @State var selectedTab = 1
    @State private var isPresented: Bool = false
    @State private var showingEditSheet: Bool = false
    
    @State private var searchText:String = ""
    var userInfo: GIDGoogleUser?
    var userData: UserInfo?
    @State var stateFullBill:[SwiftBill] = []
    @Environment(\.editMode) private var editMode
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredBills) { bill in
                        billRow(bill: bill.originalBill)
                            .padding(.vertical, 4)
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
                .onDelete(perform: deleteChores)
            }
            .navigationTitle("Bills")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingEditSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }.sheet(isPresented: $showingEditSheet) {
                // Use this sheet to add a new Chore or edit an existing one
                // You can pass nil to mean "add new chore"
                //                ChoreEdit(chore: nil, title: "") // <-- You'd have to adapt ChoreEditView to handle this
            }
        }
        .searchable(text: $searchText, prompt: "Search Bills")
        
}
    
    
    var filteredBills:[SwiftBill] {
        if searchText.isEmpty {
            return stateFullBill
        } else {
            return stateFullBill.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func deleteChores(at offsets: IndexSet) {
        let filtered = filteredBills
        for offset in offsets {
            if let indexInOriginal = stateFullBill.firstIndex(of: filtered[offset]) {
                stateFullBill.remove(at: indexInOriginal)
            }
        }
    }
}

#Preview {
    BillsView()
}
