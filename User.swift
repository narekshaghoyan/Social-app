import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    
    var initial: String {
        let formatter = PersonNameComponentsFormatter()
        
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

func createUser() {
    
}

extension User {
    static var mock_user = User(id: NSUUID().uuidString, name: "blank", email: "blank")
}
