//
//  AboutView.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationView {
            VStack {
                Text("About This App")
                    .font(.title)
                    .padding()
                Text("This is a sample app to demonstrate SwiftUI and customization.")
                    .padding()
                Spacer()
            }
            .navigationBarTitle("About", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                UIApplication.shared.windows
                    .first?.rootViewController?.dismiss(animated: true, completion: nil)
            })
        }
    }
}

#Preview {
    AboutView()
        .environmentObject(ThemeManager())  // Добавляем объект ThemeManager для Preview
}
