import SwiftUI
import Firebase
import FirebaseAuth

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

struct Register: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRegistered: Bool = false // State variable for tracking registration status
    
    var body: some View {
        NavigationView {
            Color(hex: "375CBC")
                .ignoresSafeArea()
                .overlay(
                    VStack(spacing: 20) {
                        Text("Sign up")
                            .font(.system(size: 50))
                            .foregroundStyle(Color.white)
                            .offset(y: 15)
                            .padding(20)
                        
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
                        .onChange(of: email) { newEmail in
                            email = newEmail.lowercased()
                        }
                        
                        TextField(
                            "",
                            text: $password,
                            prompt: Text("password").foregroundColor(Color.white)
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
                        .onChange(of: password) { newPassword in
                            password = newPassword.lowercased()
                        }
                        
                        Button(action: {
                            register(email: email, password: password, firstName: firstName, lastName: lastName)
                        }) {
                            Text("Sign up")
                                .foregroundColor(.white)
                                .frame(width: 250, height: 50)
                                .background(Color.green)
                                .cornerRadius(8)
                                .font(.system(size: 25, weight: .semibold))
                        }
                        
                        NavigationLink(
                            destination: Login().navigationBarBackButtonHidden(true), // Navigate to Login view
                            isActive: $isRegistered, // Activate link based on state variable
                            label: {
                                Text("Already have an account? Login")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 340, height: 30)
                                    .background(Color.green)
                                    .cornerRadius(8)
                                    .font(.system(size: 20, weight: .semibold))
                            }
                        )
                        .navigationBarBackButtonHidden(true)
                        .padding(.top, 130)
                    }
                    
                )

        }
    }
    private func register(email: String, password: String, firstName: String, lastName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                // Handle error
            } else {
                // User created successfully
                print("User created")
                // Optionally, update user's display name
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = "\(firstName) \(lastName)"
                changeRequest?.commitChanges(completion: { error in
                    if let error = error {
                        print("Error updating profile: \(error.localizedDescription)")
                    } else {
                        // Profile updated successfully
                        self.isRegistered = true
                        print("Profile updated")
                    }
                })
            }
        }
    }
}



#Preview {
    Register()
}
