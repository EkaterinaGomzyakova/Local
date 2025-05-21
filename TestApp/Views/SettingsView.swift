import SwiftUI

struct SettingsView: View {
    
    @State private var showFeedback = false
    @State private var showAbout = false
    @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Theme")) {
                    HStack {
                        Text("Light")
                        Spacer()
                    }
                }
                
                Section(header: Text("Information")) {
                    Button(action: {
                        showFeedback.toggle()
                    }) {
                        Text("Feedback")
                    }
                    .sheet(isPresented: $showFeedback) {
                        FeedbackView()
                    }
                    
                    Button(action: {
                        showAbout.toggle()
                    }) {
                        Text("About")
                    }
                    .sheet(isPresented: $showAbout) {
                        AboutView()
                    }
                }
                
                Section {
                    Button(action: {
                        showLogoutAlert.toggle()
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showLogoutAlert) {
                        Alert(
                            title: Text("Logout"),
                            message: Text("Are you sure you want to log out?"),
                            primaryButton: .destructive(Text("Logout")) {
                                print("User logged out")
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}

