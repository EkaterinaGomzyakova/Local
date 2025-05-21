import SwiftUI

struct AddView: View {
    // Позволяет закрыть модальный экран
    @Environment(\.presentationMode) private var presentationMode
    
    // Поля формы
    @State private var title = ""
    @State private var description = ""
    
    // Состояние загрузки и возможная ошибка
    @State private var isLoading = false
    @State private var errorMsg: String?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Информация")) {
                    TextField("Заголовок", text: $title)
                    TextField("Описание", text: $description)
                }
                
                Section {
                    Button {
                        publish()
                    } label: {
                        if isLoading {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        } else {
                            Text("Опубликовать")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .disabled(isLoading || title.isEmpty || description.isEmpty)
                }
            }
            .navigationTitle("Новое событие")
            // Кнопка Отмена слева
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            // Ошибки
            .alert(
                "Ошибка",
                isPresented: Binding(
                    get: { errorMsg != nil },
                    set: { _ in errorMsg = nil }
                )
            ) {
                Button("ОК", role: .cancel) {}
            } message: {
                Text(errorMsg ?? "")
            }
        }
    }
    
    private func publish() {
        isLoading = true
        errorMsg = nil
        
        EventService.shared.createEvent(
            title: title,
            description: description,
            communityId: 1,
            isPublic: true
        ) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success:
                    // Закрываем экран при успехе
                    presentationMode.wrappedValue.dismiss()
                case .failure(let err):
                    // Показываем сообщение об ошибке
                    errorMsg = err.localizedDescription
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
