//
//  BillsView.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-07.
//

import SwiftUI
import Foundation

@objc class BillsViewControllerSwift: UIViewController {
     @objc static func create() -> UIViewController {
        let hostingVC = UIHostingController(rootView: BillsView())
         hostingVC.navigationItem.largeTitleDisplayMode = .always
        return hostingVC
    }
}


struct BillsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("hello")
                }
            }
            .navigationTitle("Bills")
        }
    }
}

#Preview {
    BillsView()
}
