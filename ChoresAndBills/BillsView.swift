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
    var bill: Bill
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(bill.title)")
                .font(.headline)
            DisclosureGroup("Show Description") {
                Text("Amount: \(bill.amount.formatted(.currency(code: "CAD")))")
            }
        }
    }
    
}


struct BillsView: View {
    @State private var searchText = ""
    var userInfo: GIDGoogleUser?
    var userData: UserInfo?
    @State var stateFullBill:[SwiftBill] = []
    
    var filteredBills : [SwiftBill] {
        if searchText.isEmpty {
            return stateFullBill
        } else {
            return stateFullBill.filter { $0.title.localizedStandardContains(searchText)}
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredBills, id: \.self) { bill in
                    BillRow(bill: bill.originalBill)
                }
            }
            .navigationTitle("Bills")
        }
        .searchable(text: $searchText, prompt: "Search Bills")
        
    }
}

#Preview {
    BillsView()
}
