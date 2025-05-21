//
//  EditProfileView.swift
//  TestApp
//
//  Created by Kate on 06.11.2024.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss  // Добавлено для закрытия представления
    
    @Binding var user: UserProfile
    @Binding var selectedImage: UIImage?
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var showImagePicker: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Avatar")) {
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        }
                    }
                }
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                }
            }
            .navigationBarTitle("Edit Profile")
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()  // Закрывает представление при нажатии на Cancel
            }, trailing: Button("Save") {
                user.firstName = firstName
                user.lastName = lastName
                user.email = email
                if let selectedImage = selectedImage {
                    user.avatar = selectedImage
                }
                dismiss()  // Закрывает представление после сохранения
            })
            .onAppear {
                // Инициализация значений для редактирования
                firstName = user.firstName
                lastName = user.lastName
                email = user.email
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
}

#Preview {
    EditProfileView(user: .constant(UserProfile(firstName: "Jane", lastName: "Doe", email: "jane.doe@example.com", avatar: nil)), selectedImage: .constant(nil))
    
}

