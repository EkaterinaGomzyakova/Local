import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var cards: [EventCard]
    
    // MARK: — Поля формы
    @State private var title: String = ""
    @State private var showDatePicker = false
    @State private var selectedDate: Date = Date()
    @State private var selectedBuilding: String = ""
    @State private var selectedAuditorium: String = ""
    @State private var description: String = ""
    @State private var tagsText: String = ""
    @State private var tags: [String] = []
    @State private var isFromCommunity: Bool = false
    @State private var selectedCommunity: String = ""
    @State private var isOnlyFriends: Bool = false
    @State private var pickedImage: UIImage?
    @State private var showingImagePicker = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Навигационный бар
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    Spacer()
                    Text("Новое событие")
                        .font(.headline)
                    Spacer()
                    Spacer().frame(width: 32) // центрирование заголовка
                }
                .padding()

                ScrollView {
                    VStack(spacing: 24) {
                        // Фото-заглушка с возможностью выбора
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 150)
                            Button {
                                showingImagePicker = true
                            } label: {
                                if let img = pickedImage {
                                    Image(uiImage: img)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 140)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                } else {
                                    Image(systemName: "camera")
                                        .font(.title)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .sheet(isPresented: $showingImagePicker) {
                            ImagePicker(image: $pickedImage)
                        }
                        
                        // Название события
                        ZStack(alignment: .leading) {
                            if title.isEmpty {
                                Text("Название события")
                                    .font(.title2).fontWeight(.bold)
                                    .foregroundColor(Color.gray.opacity(0.5))
                            }
                            TextField("", text: $title)
                                .font(.title2).fontWeight(.bold)
                        }
                        .padding(.horizontal)

                        // Дата и время
                        Button {
                            showDatePicker.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "clock")
                                Text(selectedDate, style: .date)
                                Spacer()
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                        }
                        .sheet(isPresented: $showDatePicker) {
                            DatePicker(
                                "Выберите дату и время",
                                selection: $selectedDate,
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                        }
                        .padding(.horizontal)

                        // Корпус и аудитория
                        HStack(spacing: 16) {
                            Button {
                                // выбор корпуса
                            } label: {
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                    Text(selectedBuilding.isEmpty ? "Корпус" : selectedBuilding)
                                    Image(systemName: "chevron.down")
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                            }
                            Button {
                                // выбор аудитории
                            } label: {
                                HStack {
                                    Image(systemName: "building.2.crop.circle")
                                    Text(selectedAuditorium.isEmpty ? "Аудитория" : selectedAuditorium)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                            }
                        }
                        .padding(.horizontal)

                        // Описание
                        ZStack(alignment: .topLeading) {
                            if description.isEmpty {
                                Text("Описание")
                                    .foregroundColor(Color.gray.opacity(0.5))
                                    .padding(8)
                            }
                            TextEditor(text: $description)
                                .frame(minHeight: 120)
                                .padding(4)
                        }
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                        .padding(.horizontal)

                        // Теги
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Добавить теги")
                                .font(.headline)
                                .padding(.horizontal)
                            HStack {
                                ForEach(tags, id: \.self) { tag in
                                    Text(tag)
                                        .font(.caption2)
                                        .padding(6)
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(Capsule())
                                }
                                Button {
                                    let newTag = tagsText.trimmingCharacters(in: .whitespaces)
                                    if !newTag.isEmpty {
                                        tags.append(newTag)
                                        tagsText = ""
                                    }
                                } label: {
                                    Image(systemName: "plus")
                                        .padding(8)
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(Circle())
                                }
                                TextField("Новый тег", text: $tagsText)
                                    .padding(6)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal)
                        }

                        // Дополнительные настройки
                        VStack(spacing: 16) {
                            Text("Немного дополнительных настроек")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)

                            Toggle(isOn: $isFromCommunity) {
                                HStack {
                                    Image(systemName: "flag")
                                    Text("От сообщества")
                                }
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .purple))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                            .padding(.horizontal)

                            Button {
                                // выбор сообщества
                            } label: {
                                HStack {
                                    Image(systemName: "at")
                                    Text(selectedCommunity.isEmpty ? "Выбери сообщество" : selectedCommunity)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                            }
                            .padding(.horizontal)

                            Toggle(isOn: $isOnlyFriends) {
                                HStack {
                                    Image(systemName: "star")
                                    Text("Видно только друзьям")
                                }
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .purple))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }

                // Кнопка «Опубликовать»
                Button("Опубликовать") {
                    let newCard = EventCard(
                        title: title,
                        description: description,
                        tags: tags,
                        date: selectedDate,
                        imageName: pickedImage != nil ? "uploadedImageName" : "",
                        username: "CurrentUser"
                    )
                    cards.append(newCard)
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 + 8)
            }
            .navigationBarHidden(true)
        }
    }
}

// Если ImagePicker объявлен отдельно, вам не нужно его тут дублировать

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(cards: .constant([]))
    }
}

