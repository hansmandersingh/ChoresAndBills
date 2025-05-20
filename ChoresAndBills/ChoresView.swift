//
//  ChoresView.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-07.
//

import SwiftUI

struct SwiftChore: Identifiable, Hashable {
    var id: String
    
    let title: String
    let details: String
    let originalChore: Chore
    
    init(chore:Chore) {
        self.id = chore.choreId
        self.title = chore.title
        self.details = chore.details
        self.originalChore = chore
    }
}

@objc class ChoresViewControllerSwift: UIViewController {
    @objc static func create(_ userData: UserInfo, _ chores: [Chore]) -> UIViewController {
        let swiftChores = chores.map{ SwiftChore(chore:$0) }
        let choreView = ChoresView(userData, stateFullChores: swiftChores)
        let hostingVC = UIHostingController(rootView: choreView)
         hostingVC.navigationItem.largeTitleDisplayMode = .always
        return hostingVC
    }
}

struct CustomRow: View {
    var title: String
    var details: String
    
    
    var body: some View {
        Text(title)
    }
}

struct ChoresView: View {
    @State var selectedTab = 1
    @State private var isPresented = false
    @State private var showingEditSheet = false
    var userInfo: GIDGoogleUser?
    var userData: UserInfo?

    @State private var searchText: String = ""
    @State private var stateFullChores:[SwiftChore] = []
    @Environment(\.editMode) private var editMode
    
    init(_ userData: UserInfo? = nil, stateFullChores: [SwiftChore]) {
        self.userData = userData
        _stateFullChores = State(initialValue: stateFullChores)
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(filteredChores) { chore in
                    
                    choreRow(chore: chore.originalChore)
                        .padding(.vertical, 4)
                    
                }
                .onDelete(perform: deleteChores)
            }
            .navigationTitle("Chores")
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
        .searchable(text: $searchText, prompt: "Search Chores")
        
    }
    
    var filteredChores: [SwiftChore] {
        if searchText.isEmpty {
            return stateFullChores
        } else {
            return stateFullChores.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.details.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func deleteChores(at offsets: IndexSet) {
        let filtered = filteredChores
        for offset in offsets {
            if let indexInOriginal = stateFullChores.firstIndex(of: filtered[offset]) {
                stateFullChores.remove(at: indexInOriginal)
            }
        }
    }
}


