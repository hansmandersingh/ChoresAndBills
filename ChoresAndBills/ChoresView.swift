//
//  ChoresView.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-07.
//

import SwiftUI

@objc class ChoresViewControllerSwift: UIViewController {
    @objc static func create(_ userData: UserInfo, _ chores: [Chore]) -> UIViewController {
        var choreView = ChoresView()
        choreView.userData = userData
        choreView.chores = chores
        let hostingVC = UIHostingController(rootView: choreView)
         hostingVC.navigationItem.largeTitleDisplayMode = .always
        return hostingVC
    }
}



struct ChoresView: View {
    @State var selectedTab = 1
    @State private var isPresented = false
    var userInfo: GIDGoogleUser?
    var userData: UserInfo?
    var chores: [Chore] = []
    @State private var searchText: String = ""
    
    var filteredChores  : [Chore] {
        if searchText.isEmpty {
            return chores
        } else {
            return chores.filter { chore in
                chore.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        
        NavigationView {
            List(filteredChores, id: \.self) { chore in
                HStack {
                    Text(chore.title)
                }
            }
            .navigationTitle("Chores")
        }
        .searchable(text: $searchText, prompt: "Search Chores")
        
    }
}


#Preview {
    ChoresView()
}
