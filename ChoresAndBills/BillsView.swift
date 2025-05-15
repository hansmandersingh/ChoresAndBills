//
//  BillsView.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-07.
//

import SwiftUI
import Foundation

@objc class BillsViewControllerSwift: UIViewController {
    @objc static func create(_ userData: UserInfo, _ bills:[Bill]) -> UIViewController {
        var swiftBillsView = BillsView()
        swiftBillsView.userData = userData;
        swiftBillsView.bills = bills;
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
    var bills:[Bill] = []
    
    var filteredBills : [Bill] {
        if searchText.isEmpty {
            return bills
        } else {
            return bills.filter { $0.title.localizedStandardContains(searchText) && $0.description.localizedStandardContains(searchText)}
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredBills, id: \.self) { bill in
                    BillRow(bill: bill)
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
