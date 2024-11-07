//
//  LoginView.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAnimating = false

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding(.bottom, 40)

            TextField("Username", text: $username)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.3), value: isAnimating)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)

            Button(action: {
                print("Button tapped")
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .padding()
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(ThemeManager())  // Добавляем объект ThemeManager для Preview
}
