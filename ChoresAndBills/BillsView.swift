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


struct BillsView: View {
    @State private var searchText = ""
    var userInfo: GIDGoogleUser?
    var userData: UserInfo?
    var bills:[Bill] = []
    
    var filteredBills : [Bill] {
        if searchText.isEmpty {
            return bills
        } else {
            return bills
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredBills, id: \.self) { bill in
                Text(bill.title)
            }
            .navigationTitle("Bills")
        }
        .searchable(text: $searchText)
        
    }
}

#Preview {
    BillsView()
}
