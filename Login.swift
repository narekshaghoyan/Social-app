import SwiftUI

struct Login: View {
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
                        Text("Login")
                            .font(.system(size: 50))
                            .foregroundStyle(Color.white)
                            .offset(y: -70)
                            .padding(80)
                        
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
                        
                        Button(action: {
                            print("Send request to server, to login user...")
                        }) {
                            Text("Login")
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 250, height: 50)
                                .background(Color.green)
                                .cornerRadius(8)
                                .font(.system(size: 25, weight: .semibold))
                                .offset(y: -150)
                        }
                        
                        NavigationLink(
                            destination: Register().navigationBarBackButtonHidden(true),
                            label: {
                                Text("Already have an account? Register it")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 340, height: 30)
                                    .background(Color.green)
                                    .cornerRadius(8)
                                    .font(.system(size: 18, weight: .semibold))
                            }
                        )
                        .navigationBarBackButtonHidden(true)
                        .padding(.top, 200)
                    }
                )
        }
                
    }
}

#Preview {
    Login()
}
