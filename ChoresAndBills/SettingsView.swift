//
//  SettingsView.swift
//  ChoresAndBills
//
//  Created by hansmander Singh on 2025-05-11.
//

import SwiftUI

@objc class SettingsViewControllerSwift: UIViewController {
     @objc static func create() -> UIViewController {
        let hostingVC = UIHostingController(rootView: SettingsView())
         hostingVC.navigationItem.largeTitleDisplayMode = .always
        return hostingVC
    }
}


struct SettingsView: View {
    @State private var showLoginView: Bool = false
    var body: some View {
        NavigationView() {
            List {
                Section("Preferences") {
                    Toggle("Notifications", isOn: .constant(true))
                }
                
                Section(header: Text("Account")) {
                    NavigationLink("Profile", destination: Text("Profile Settings"))
                }
                
                Section() {
                    Button("Log Out") {
                        GIDSignIn.sharedInstance.signOut()
                        showLoginView.toggle()
                    }.fullScreenCover(isPresented: $showLoginView) {
                        ObjectiveCViewControllerWrapperForLogin()
                            .ignoresSafeArea(.all)
                    }.foregroundColor(.red)
                }
                Section ("Made with ❤️ by Hans") {
                    
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct ObjectiveCViewControllerWrapperForLogin: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let objCVC = LoginViewController()
        return UINavigationController(rootViewController: objCVC)
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // No updates needed
    }
}

#Preview {
    SettingsView()
}
