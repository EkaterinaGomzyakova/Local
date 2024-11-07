//
//  ProfileView.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var themeManager: ThemeManager  // Для работы с темами
    
    @State private var user: UserProfile = UserProfile(
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@example.com",
        avatar: UIImage(named: "avatar_placeholder")
    )
    @State private var isEditing: Bool = false
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationView {
            VStack {
                if let avatar = user.avatar {
                    Image(uiImage: avatar)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                }

                Text("\(user.firstName) \(user.lastName)")
                    .font(.largeTitle)
                    .foregroundColor(themeManager.currentTheme.textColor)  // Применяем текстовый цвет темы
                    .padding(.top, 20)

                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(themeManager.currentTheme.textColor)  // Применяем текстовый цвет темы
                    .padding(.top, 5)

                Spacer()

                Button(action: {
                    isEditing.toggle()
                }) {
                    Text("Edit Profile")
                        .font(.headline)
                        .foregroundColor(themeManager.currentTheme.buttonTextColor)  // Цвет текста кнопки
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(themeManager.currentTheme.buttonColor)  // Цвет фона кнопки
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isEditing) {
                    EditProfileView(user: $user, selectedImage: $selectedImage) // Передаем привязки
                }
            }
            .padding()
            .background(themeManager.currentTheme.backgroundColor)  // Применяем цвет фона к представлению
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView()) {
                Image(systemName: "gear")
                    .foregroundColor(themeManager.currentTheme.textColor)  // Цвет иконки настроек
            })
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(ThemeManager())  // Добавляем объект ThemeManager для Preview
}
