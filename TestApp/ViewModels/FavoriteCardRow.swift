import SwiftUI

struct FavoriteCardRow: View {
    let event: EventCard

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Верхний ряд: дата и тип
            HStack {
                HStack {
                    Image(systemName: "clock")
                    Text(event.date, style: .date)
                }
                .font(.caption)
                .padding(6)
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Онлайн")
                }
                .font(.caption)
                .padding(6)
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                
                Spacer()
                
                Image(systemName: "bookmark.fill")
                    .font(.title3)
                    .foregroundColor(.purple)
            }

            // Заголовок
            Text(event.title)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)

            // Изображение
            Image(event.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .clipped()
                .cornerRadius(12)

            // Теги и аватарки
            HStack {
                if let tag = event.tags.first {
                    HStack(spacing: 4) {
                        Image(systemName: "tag")
                        Text(tag)
                    }
                    .font(.caption2)
                    .padding(6)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                }
                Spacer()
                HStack(spacing: -10) {
                    ForEach(0..<3) { i in
                        Image("avatar\(i+1)")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    }
                    Text("+17")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.3))
        .cornerRadius(20)
    }
}

