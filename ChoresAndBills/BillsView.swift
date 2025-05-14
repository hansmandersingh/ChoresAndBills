//
//  BillsView.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-07.
//

import SwiftUI
import Foundation

@objc class BillsViewControllerSwift: UIViewController {
    @objc static func create(_ userInfo:GIDGoogleUser, _ userData: UserInfo) -> UIViewController {
        var swiftBillsView = BillsView()
        swiftBillsView.userInfo = userInfo;
        swiftBillsView.userData = userData;
        let hostingVC = UIHostingController(rootView: swiftBillsView)
         hostingVC.navigationItem.largeTitleDisplayMode = .always
        return hostingVC
    }
}


struct BillsView: View {
    @State private var searchText = ""
    var userInfo: GIDGoogleUser?
    var userData: UserInfo?
    @State var userBills: [String] = []
    
    var filteredBills  : [String] {
        if searchText.isEmpty {
            return userBills
        } else {
            return userBills.filter{ $0.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredBills, id: \.self) { bill in
                Text(bill)
            }
            .navigationTitle("Bills")
        }
        .onAppear {
            userBills = self.userData?.bills ?? []
        }
        .searchable(text: $searchText)
        
    }
}

#Preview {
    BillsView()
}
