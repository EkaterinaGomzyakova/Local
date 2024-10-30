//
//  ContentView.swift
//  Local
//
//  Created by Kate on 29.10.2024.
//

import SwiftUI
import PhotosUI

// Класс для хранения настроек профиля
class UserProfile: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var nickname: String = ""
    @Published var faculty: String = ""
    @Published var program: String = ""
    @Published var selectedImage: UIImage? // Для хранения выбранного изображения
}

struct ContentView: View {
    @State private var isSettingsPresented = false
    @StateObject private var userProfile = UserProfile() // Создаем экземпляр UserProfile

    var body: some View {
        ZStack {
            Color.backgroundCustom.ignoresSafeArea() // Цвет фона на всю страницу

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        isSettingsPresented = true
                    }) {
                        Image("Settings")
                    }
                    .padding()
                }

                Spacer()

                ZStack {
                    Image("Hserun")
                        .resizable()
                        .frame(width: 210, height: 139)
                        .rotationEffect(.degrees(15))
                        .padding(.bottom, 10)

                    Image("Guitar")
                        .resizable()
                        .frame(width: 210, height: 139)
                        .rotationEffect(.degrees(-15))
                        .padding(.bottom, 10)

                    Image("Alfa")
                        .resizable()
                        .frame(width: 210, height: 139)
                        .rotationEffect(.degrees(30))
                        .padding(.bottom, 10)

                    Image("Chess")
                        .resizable()
                        .frame(width: 210, height: 139)
                        .rotationEffect(.degrees(-30))
                }
                .frame(height: 200)

                VStack {
                    Image("A_Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 330, height: 91)

                    Text("все ивенты Вышки здесь")
                        .font(.custom("SF Pro Medium", size: 20))
                        .foregroundColor(Color("AlmostBlack"))
                        .multilineTextAlignment(.center)
                }

                NavigationLink(destination: AboutView()) {
                    Text("Узнать о нас")
                        .font(.custom("SF Pro Medium", size: 20))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 68)
                        .background(Color("AlmostBlack"))
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                        .tracking(-0.04 * 20)
                }

                Spacer(minLength: 50)
            }
            .padding(.top, 20)
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView(isPresented: $isSettingsPresented, userProfile: userProfile) // Передаем экземпляр userProfile
        }
    }
}

struct SettingsView: View {
    @Binding var isPresented: Bool // Привязка для управления состоянием
    @ObservedObject var userProfile: UserProfile // Привязка к userProfile

    @State private var isImagePickerPresented: Bool = false // Для управления отображением ImagePicker

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Профиль")) {
                    HStack {
                        // Отображаем выбранное изображение или заглушку
                        if let image = userProfile.selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        
                        Button("Изменить фото") {
                            isImagePickerPresented = true // Показать выбор изображения
                        }
                    }

                    TextField("Имя", text: $userProfile.firstName) // Привязка к переменной firstName
                    TextField("Фамилия", text: $userProfile.lastName) // Привязка к переменной lastName
                    TextField("Никнейм", text: $userProfile.nickname) // Привязка к переменной nickname
                    TextField("Факультет", text: $userProfile.faculty) // Привязка к переменной faculty
                    TextField("Программа", text: $userProfile.program) // Привязка к переменной program
                }
            }
            .navigationTitle("Настройки")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        isPresented = false // Закрыть лист
                    }
                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $userProfile.selectedImage) // Передаем привязку к выбранному изображению
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1 // Ограничение на выбор одного изображения
        configuration.filter = .images // Только изображения

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            if let result = results.first {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        if let image = image as? UIImage {
                            self.parent.selectedImage = image // Устанавливаем выбранное изображение
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}

