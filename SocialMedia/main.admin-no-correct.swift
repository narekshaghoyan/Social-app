import SwiftUI

struct Lines: View {
    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(width: UIScreen.main.bounds.width - 40, height: 2)
            .padding(.bottom, 10)
    }
}

// Model representing an item
struct Item: Identifiable {
    let id: UUID
    let name: String
    let description: String
    let imageName: String // Assuming images are stored in Assets.xcassets
}

// Sample data
let testData: [Item] = [
    Item(id: UUID(), name: "Item 1", description: "Description for Item 1", imageName: "item1"),
    Item(id: UUID(), name: "Item 2", description: "Description for Item 2", imageName: "item2"),
    Item(id: UUID(), name: "Item 3", description: "Description for Item 3", imageName: "item3"),
]

struct Object: View {
    let title: String
    let categoryName: String
    let imageName: String
    let paragraph: String
    
      var body: some View {
        ZStack() {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 69, height: 69)
            .background(Color(red: 0.85, green: 0.85, blue: 0.85))
            .cornerRadius(21)
            .offset(x: 0, y: 0)
            .zIndex(2)

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 41, height: 41)
                .zIndex(2)
            
          .frame(width: 41, height: 41)
          .offset(x: 0, y: -14)
          Text("  All \nposts")
            .font(Font.custom("Inconsolata", size: 11).weight(.light))
            .foregroundColor(Color(red: 0.17, green: 0.21, blue: 0.15))
            .offset(x: 1.50, y: 19.50)
            .zIndex(2)
        }
        .offset(y: -95)
        .zIndex(1)
        .frame(width: 69, height: 69);
        
      }
}

struct BlockPost: View {
    let title: String
    let categoryName: String
    let imageUrl: String
    let paragraph: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            let items: [Item] = testData // Assuming testData is defined as above

                
            // Category name
            Text(categoryName)
                .font(.caption)
                .foregroundColor(.secondary)

            // Title
            Text(title)
                .font(.title)
                .fontWeight(.bold)

            // Image
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }

            // Mini paragraph
            Text(paragraph)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


struct MainAdmin: View {
    var firstName: String = "Narek"
    var lastName: String = "Shaghoyan"
    var fullName: String

    init() {
        fullName = firstName + " " + lastName
    }

    var body: some View {
        NavigationView {
            Color(hex: "375CBC")
                .ignoresSafeArea()
                .overlay(
                    ScrollView {
                        VStack(spacing: 20) {
                            HStack {
                                Text(fullName)
                                    .foregroundColor(.white)
                                    .padding()
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(width: 2, height: 40)
                                
                                Text(currentDateTime())
                                    .font(Font.custom("Inconsolata", size: 17).weight(.light))
                                    .foregroundColor(.white)
                                    .padding()
                                    .cornerRadius(8)
                                    .frame(width: 200, height: 40)
                            }
                            
                            ForEach(0..<4) { _ in
                                BlockPost(title: "This is a sample title", categoryName: "Category Name", imageUrl: "https://via.placeholder.com/690x690", paragraph: "This is a sample mini paragraph that will be displayed below the image.")
                                    .padding(.bottom)
                                Lines()
                            }
                            
                        }
                        .padding()
                    }
                )
        }
    }
}

struct MainAdmin_Previews: PreviewProvider {
    static var previews: some View {
        MainAdmin()
    }
}

// Get actual date in format dd/MM/yyyy HH:mm
func currentDateTime() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    return dateFormatter.string(from: Date())
}


