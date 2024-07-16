import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let rgbValue = UInt32(hex, radix: 16)
        let r = Double((rgbValue! & 0xFF0000) >> 16) / 255
        let g = Double((rgbValue! & 0x00FF00) >> 8) / 255
        let b = Double(rgbValue! & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

struct ContentView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            Color(hex: "375CBC")
                .ignoresSafeArea()
                .overlay(
                    VStack(spacing: 20) {
                        TextField(
                            "",
                            text: $firstName,
                            prompt: Text("First name").foregroundColor(Color.white)
                        )
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color(hex: "9C9797"), lineWidth: 1.5)
                        )
                        .padding() // Add padding around the text field
                        .frame(maxWidth: 180) // Ensure VStack fills parent width
                        .offset(x: -100)
                        .foregroundColor(Color.white)
                        
                        TextField(
                            "",
                            text: $lastName,
                            prompt: Text("Last name").foregroundColor(Color.white)
                        )
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color(hex: "9C9797"), lineWidth: 1.5)
                        )
                        .padding() // Add padding around the text field
                        .frame(maxWidth: 200) // Ensure VStack fills parent width
                        .offset(x: 80, y: -97)
                        .foregroundColor(Color.white)
                        
                        TextField(
                            "",
                            text: $email,
                            prompt: Text("example@example.com").foregroundColor(Color.white)
                        )
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color(hex: "9C9797"), lineWidth: 1.5)
                        )
                        .padding()
                        .frame(maxWidth: 370)
                        .offset(x: -3, y: -130)
                        .foregroundColor(Color.white)
                        
                        TextField(
                            "",
                            text: $password,
                            prompt: Text("password123").foregroundColor(Color.white)
                        )
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color(hex: "9C9797"), lineWidth: 1.5)
                        )
                        .padding() // Add padding around the text field
                        .frame(maxWidth: 370) // Ensure VStack fills parent width
                        .offset(x: -3, y: -160)
                        .foregroundColor(Color.white)
                        
                        Button("Sign up", action: <#T##() -> Void#>)
                        NavigationLink(destination: Register(), label: { Text("Sign in") })
                    }
                    
                )

        }
    }
}

#Preview {
    ContentView()
}
