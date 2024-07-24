import SwiftUI

struct UserInfo {
    let id: UUID
    let firstName: String
    let lastName: String
    let regDate: String
    let email: String
    let lastLogin: String
    let avatarName: String // Assuming avatar images are stored in Assets.xcassets
    
    init(id: UUID, firstName: String, lastName: String, regDate: String, email: String, lastLogin: String, avatarName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.regDate = regDate
        self.email = email
        self.lastLogin = lastLogin
        self.avatarName = avatarName
    }
    
    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}

struct Admin: View {
    // Sample data of users
    let users: [UserInfo] = [
            UserInfo(id: UUID(), firstName: "John", lastName: "Doe", regDate: "2023-01-01", email: "john.doe@example.com", lastLogin: "2023-07-19", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Jane", lastName: "Smith", regDate: "2022-12-15", email: "jane.smith@example.com", lastLogin: "2023-07-18", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Michael", lastName: "Johnson", regDate: "2023-02-20", email: "michael.johnson@example.com", lastLogin: "2023-07-17", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Michael", lastName: "Johnson", regDate: "2023-02-20", email: "michael.johnson@example.com", lastLogin: "2023-07-17", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Michael", lastName: "Johnson", regDate: "2023-02-20", email: "michael.johnson@example.com", lastLogin: "2023-07-17", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Michael", lastName: "Johnson", regDate: "2023-02-20", email: "michael.johnson@example.com", lastLogin: "2023-07-17", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Michael", lastName: "Johnson", regDate: "2023-02-20", email: "michael.johnson@example.com", lastLogin: "2023-07-17", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Michael", lastName: "Johnson", regDate: "2023-02-20", email: "michael.johnson@example.com", lastLogin: "2023-07-17", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Michael", lastName: "Johnson", regDate: "2023-02-20", email: "michael.johnson@example.com", lastLogin: "2023-07-17", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Michael", lastName: "Johnson", regDate: "2023-02-20", email: "michael.johnson@example.com", lastLogin: "2023-07-17", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Michael", lastName: "Johnson", regDate: "2023-02-20", email: "michael.johnson@example.com", lastLogin: "2023-07-17", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Michael", lastName: "Johnson", regDate: "2023-02-20", email: "michael.johnson@example.com", lastLogin: "2023-07-17", avatarName: "default-avatar"),
            UserInfo(id: UUID(), firstName: "Michael", lastName: "Johnson", regDate: "2023-02-20", email: "michael.johnson@example.com", lastLogin: "2023-07-17", avatarName: "default-avatar"),
        ]
    var body: some View {
        NavigationView {
            VStack {
                List(users, id: \.id) { user in
                    NavigationLink(destination: UserDetailsView(user: user)) {
                        UserRow(user: user)
                    }
                }
                .navigationBarTitle("All Users", displayMode: .inline)

                Spacer()

                NavigationLink(destination: CreatePost()) {
                    Text("Create Post")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
    }
}

struct UserRow: View {
    let user: UserInfo
    
    var body: some View {
        HStack {
            Image(user.avatarName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.trailing, 10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.getFullName())
                    .font(.headline)
                Text("Registered: \(user.regDate)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("Last Login: \(user.lastLogin)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

struct UserDetailsView: View {
    let user: UserInfo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Image(user.avatarName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 20)
                    .offset(x: 70)
                
                Text(user.getFullName())
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(x: 70)
                
                Spacer()
                
                Text("Registered: \(user.regDate)")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Text("Email: \(user.email)")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Text("Last Login: \(user.lastLogin)")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(user.getFullName())
    }
}

struct Admin_Previews: PreviewProvider {
    static var previews: some View {
        Admin()
    }
}
