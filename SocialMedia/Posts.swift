import SwiftUI

// Model representing an item
struct Item: Identifiable {
    let id: UUID
    let name: String
    let description: String
    let imageName: String // Assuming images are stored in Assets.xcassets
    let postDate: Date // Date of the post
}

// Sample data with dates
let testData: [Item] = [
    Item(id: UUID(), name: "Lorem Ipsum", description: "Description for Item 2", imageName: "post-preview", postDate: Date()),
    Item(id: UUID(), name: "Item 2", description: "Description for Item 2", imageName: "post-preview", postDate: Date()),
    Item(id: UUID(), name: "Item 3", description: "Description for Item 3", imageName: "post-preview", postDate: Date(timeIntervalSinceNow: -86400)), // Example: 1 day ago
]

struct PostsView: View {
    // State variable to track whether to show all posts or only today's posts
    @State private var showAllPosts = true
    
    // Filtered array based on the state
    private var filteredItems: [Item] {
        if showAllPosts {
            return testData
        } else {
            // Filter for today's posts
            let today = Date()
            print()
            return testData.filter { Calendar.current.isDate($0.postDate, inSameDayAs: today) }
        }
    }
    
    @State private var isAdmin = true // Initial state: not admin

    var body: some View {
        NavigationView {
            VStack {
                List(filteredItems) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        PostRow(item: item)
                    }
                }
                .listStyle(PlainListStyle())
                
                // Spacer to push buttons to the bottom
                Spacer()

                // Button bar with four buttons
                HStack {
                    Button(action: {
                        self.showAllPosts = true
                    }) {
                        Text("All posts")
                            .foregroundColor(.white)
                            .padding()
                            .background(showAllPosts ? Color.green : Color.gray)
                            .cornerRadius(20)
                    }

                    Spacer()

                    Button(action: {
                        self.showAllPosts = false
                    }) {
                        Text("Today posts")
                            .foregroundColor(.white)
                            .padding()
                            .background(showAllPosts ? Color.gray : Color.green)
                            .cornerRadius(20)
                    }
                    
                    Spacer()
                    
                    if isAdmin {
                        NavigationLink(
                            destination: Admin().navigationBarBackButtonHidden(true),
                            label: {
                                Text("Admin Panel")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.gray)
                                    .cornerRadius(20)
                            }
                        )
                        .navigationBarBackButtonHidden(true)
                        
                        Spacer()
                    }

                    NavigationLink(
                        destination: Login().navigationBarBackButtonHidden(true),
                        label: {
                            Text("Logout")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(20)
                                .font(.system(size: 20))
                        }
                    )
                    .navigationBarBackButtonHidden(true)
                }
                .padding()
                .background(Color(UIColor.systemBackground))
            }
            .navigationBarTitleDisplayMode(.inline) // Center-align navigation title
            .navigationTitle(showAllPosts ? "All Posts" : "Today Posts")
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
    }
}

// Extracted row view for reusability
struct PostRow: View {
    let item: Item
    
    var body: some View {
        HStack(spacing: 10) {
            Image(item.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(8)
                .padding(5)
                .background(Color.gray.opacity(0.2))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.headline)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2) // Limit description to 2 lines
            }
        }
        .padding(.vertical, 8)
    }
}


struct DetailView: View {
    let item: Item
    
    // DateFormatter to format the date
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(.horizontal)

                Text(item.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text(item.description)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                
                // Display formatted date
                Text("Posted on \(dateFormatter.string(from: item.postDate))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 5)

                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(item.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
