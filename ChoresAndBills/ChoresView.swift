//
//  ChoresView.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-07.
//

import SwiftUI

@objc class ChoresViewControllerSwift: UIViewController {
    @objc static func create(_ userInfo: GIDGoogleUser, _ userData: UserInfo) -> UIViewController {
        var choreView = ChoresView()
        choreView.userInfo = userInfo
        choreView.userData = userData
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
    @State var userChores: [String] = []
    @State private var searchText: String = ""
    
    var body: some View {
        
        NavigationView {
            List(userChores, id: \.self) { chore in
                Text(chore)
            }
            .navigationTitle("Chores")
        }.onAppear {
            userChores = self.userData?.chores ?? []
        }
        .searchable(text: $searchText)
        
    }
}


#Preview {
    ChoresView()
}
