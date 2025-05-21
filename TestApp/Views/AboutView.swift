//
//  AboutView.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

struct AboutView: View {
   
    
    var body: some View {
        NavigationView {
            VStack {
                Text("О приложении")
                    .font(.title)
                    .padding()
                Text("Наше приложение объединяет студентов Вышки")
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
    
}
