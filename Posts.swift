import SwiftUI
import Firebase
import FirebaseFirestore

// Model representing a post
struct Post: Identifiable {
    let id: String // Use String for ID if using Firestore
    let name: String
    let description: String
    let imageUrl: String
}

struct PostsView: View {
    @State private var showAllPosts = true
    @State private var isAdmin = true // Initial state: not admin
    @State private var posts: [Post] = [] // Array to hold fetched posts

    var body: some View {
        NavigationView {
            VStack {
                List(posts) { post in
                    NavigationLink(destination: DetailView(post: post)) {
                        PostRow(post: post)
                    }
                }
                .listStyle(PlainListStyle())

                Spacer()

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
                            destination: Admin(),
                            label: {
                                Text("Admin Panel")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.gray)
                                    .cornerRadius(20)
                            }
                        )

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
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(showAllPosts ? "All Posts" : "Today Posts")
            .onAppear {
                fetchPosts()
            }
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
    }

    // Function to fetch posts from Firebase
    private func fetchPosts() {
        let db = Firestore.firestore()
        db.collection("posts").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching posts: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }

            self.posts = documents.compactMap { document in
                let data = document.data()
                let id = document.documentID
                let name = data["title"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String ?? ""

                print("Image" + imageUrl)
                return Post(id: id, name: name, description: description, imageUrl: imageUrl)
            }
        }
    }
}

struct PostRow: View {
    let post: Post

    var body: some View {
        HStack(spacing: 10) {
            if let url = URL(string: post.imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(width: 100, height: 100)
                             .cornerRadius(8)
                             .padding(5)
                             .background(Color.gray.opacity(0.2))
                } placeholder: {
                    ProgressView()
                }
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(post.name)
                    .font(.headline)
                Text(post.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 8)
    }
}


struct DetailView: View {
    let post: Post

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                if let url = URL(string: post.imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    } placeholder: {
                        ProgressView()
                    }
                }


                Text(post.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text(post.description)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(post.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
