//
//  AboutView.swift
//  Local
//
//  Created by Kate on 29.10.2024.
//
import SwiftUI
struct AboutView: View {
    @State private var isSettingsPresented = false
    @StateObject private var userProfile = UserProfile() // Создаем экземпляр UserProfile
    
    var body: some View {
        ScrollView {
            // MARK: - Логотип
            HStack {
                Spacer()
                Image("A_Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 78, height: 22)
                    .padding(.trailing, 95)
                
           // MARK: - Кнопка настроек
                Button(action: {
                    isSettingsPresented = true // открывание настроек
                }) {
                    Image("Settings")
                        .padding()
                }
            }

            // MARK: - Карточка с миссией
                VStack(spacing: 15) {
                    CustomTitle(text: "Миссия")
                    
                    Image("Girl")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 295, height: 289)
                        .padding(-80)
                    
                    Text("Все ивенты и встречи Вышки в одном\nместе")
                        .foregroundColor(Color("AlmostBlack"))
                        .font(.custom("TT Interphases Edu", size: 28))
                        .fontWeight(.medium)
                        .lineSpacing(-4) /*уменьшение высоты строки*/
                        .multilineTextAlignment(.center)
                        .tracking(-1.12)
                        .frame(maxWidth: 264) /*ограничиваем ширину*/
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Присоединяйся к сообществу")
                        .font(.custom("TT Interphases Edu", size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(Color("MediumGray"))
                        .multilineTextAlignment(.center)
                }
                .frame(width: 358, height: 391)
                .background(Color("White"))
                .cornerRadius(20)
                .padding(.horizontal, 16)
            
            // MARK: - Текст с миссиями
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        MissionItem(number: "01", description: "собрать все ивенты Вышки в\u{00A0}удобном приложении")
                        
                        MissionItem(number: "03", description: "помочь студентам знакомиться и\u{00A0}находить новых друзей")
                    }
                    
                    // MARK: - Блок текста с миссиями номер 2
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MissionItem(number: "02", description: "помочь студентам найти активности по\u{00A0}душе")
                        
                        MissionItem(number: "04", description: "упростить привлечение аудитории для организаторов")
                    }
                    .padding(.top, 75)
                }
            
                // MARK: - Блок фич
            
                VStack(alignment: .center, spacing: 20) {
                    CustomTitle(text: "Фичи")
                    .padding(.top, 60)
                    
                    FeatureCard(title: "Найди компанию", description: "Куда угодно, не\u{00A0}важно, это научная конференция или поход в\u{00A0}Спар")
                        .padding(.trailing, 60)
                        .rotationEffect(.degrees(-7))
                    
                    FeatureCard(title: "Добавь свои ивенты", description: "Добавляй и\u{00A0}приглашай друзей!")
                        .padding(.leading, 60)
                        .padding(.top, -20)
                        .rotationEffect(.degrees(7))
                    
                    FeatureCard(title: "Не забудь, куда\u{00A0}хочешь пойти", description: "С нашими напоминаниями об\u{00A0}ивентах")
                        .padding(.trailing, 60)
                        .padding(.top, -20)
                        .rotationEffect(.degrees(-6))
                    
                    FeatureCard(title: "Только то, что\u{00A0}тебе интересно", description: "Добавляем теги по\u{00A0}категориям")
                        .padding(.leading, 60)
                        .padding(.top, -20)
                        .rotationEffect(.degrees(6))
                    
                    // MARK: - Блок команды
                    
                    CustomTitle(text: "Команда")
                    
                    TeamMemberCard(imageName: "Dima", name: "Дима", role: "Айдентика и фуллстек-разработка", description: "Знает про\u{00A0}Вышку примерно все")
                        .padding(.trailing, 100)
                    
                    TeamMemberCard(imageName: "Katya", name: "Катя", role: "Интерфейс и iOS разработка", description: "Организует и\u{00A0}посещает ивенты")
                        .padding(.leading, 100)
                    
                    TeamMemberCard(imageName: "Diana", name: "Диана", role: "Исследования и интерфейс", description: "Менторит и\u{00A0}волонтерит")
                        .padding(.trailing, 100)
                    
                    // MARK: - Блок ТГ-канала
                    CustomTitle(text: "Го в телеграм")
    
                    Link(destination: URL(string: "https://t.me/localhseapp")!) {
                        HStack {
                            Image("Telegram") // Имя иконки в ассетах
                                .resizable()
                                .frame(width: 24, height: 24) // Размер иконки
                                .padding(.leading, 8) // Отступ слева для иконки
                            
                            Text("@localhseapp")
                                .font(.custom("SF Pro Medium", size: 20))
                                .foregroundColor(Color("AlmostBlack"))
                            
                            Spacer() // Заполнение оставшегося пространства
                        }
                        .frame(width: .infinity, height: 68)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("AlmostBlack"), lineWidth: 1)
                        )
                        .padding(.horizontal, 16)
                        .tracking(-0.04 * 20)
                    }
                    .padding()
                }
            }
            .padding()
            .background(Color("LightBg"))
            .sheet(isPresented: $isSettingsPresented) {
                SettingsView(isPresented: $isSettingsPresented, userProfile: userProfile) // Передаем экземпляр userProfile
            }
        }
    }


#Preview {
    AboutView()
}

