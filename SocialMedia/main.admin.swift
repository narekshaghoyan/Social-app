import SwiftUI

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
                    VStack(spacing: 20) {
                        HStack {
                            Text(fullName)
                                .offset(x: -70, y: 100)
                                .foregroundColor(.white)
                                .padding()
                            Rectangle()
                                .fill(Color.black)
                                .offset(x: -70, y: 100)
                                .frame(width: 2, height: 40)
                            
                            Text(currentDateTime())
                                .font(Font.custom("Inconsolata", size: 17).weight(.light))
                                .foregroundColor(.white)
                                .padding()
                                .cornerRadius(8)
                                .frame(width: 200, height: 40)
                                .offset(x: -90, y: 100)
                        }
                        .offset(x: 90, y: -300)
                        
                        // Additional Blocks
                        BlockView(title: "Block 1", color: .red)
                        BlockView(title: "Block 2", color: .green)
                        BlockView(title: "Block 3", color: .blue)
                    }
                )
        }
    }
    
    func currentDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: Date())
    }
}

struct BlockView: View {
    var title: String
    var color: Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(color)
                .cornerRadius(8)
                .padding(.top, 20)
        }
    }
}

struct MainAdmin_Previews: PreviewProvider {
    static var previews: some View {
        MainAdmin()
    }
}
