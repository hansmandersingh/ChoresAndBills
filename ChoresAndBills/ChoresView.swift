//
//  ChoresView.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-07.
//

import SwiftUI

@objc class ChoresViewControllerSwift: UIViewController {
     @objc static func create() -> UIViewController {
        let hostingVC = UIHostingController(rootView: ChoresView())
         hostingVC.navigationItem.largeTitleDisplayMode = .always
        return hostingVC
    }
}


struct ChoresView: View {
    @State var selectedTab = 1
    @State private var isPresented = false
    
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationTitle("Chores")
        }
        
    }
}


#Preview {
    ChoresView()
}
