import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct CreatePost: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var isShowingDestination = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Create a New Post")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Enter the details for your new post below.")
                    .foregroundColor(.gray)
                
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .cornerRadius(8)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                }
                
                Button(action: {
                    self.isImagePickerPresented = true
                }) {
                    Text("Choose Image")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextEditor(text: $description)
                    .frame(height: 150)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .padding(.bottom, 16)
                
                Button(action: {
                    self.isLoading = true
                    self.uploadPost { success in
                        self.isLoading = false
                        isShowingDestination = success
                    }
                }) {
                    Text("Post")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(isLoading)
                
                NavigationLink(
                    destination: PostsView().navigationBarBackButtonHidden(true),
                    isActive: $isShowingDestination,
                    label: {
                        EmptyView()
                    })
            }
            .padding()
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: self.$selectedImage)
            }
        }
    }
    
    func uploadPost(completion: @escaping (Bool) -> Void) {
        guard let image = selectedImage else {
            print("No image selected")
            completion(false)
            return
        }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imageName = UUID().uuidString
        let imageRef = storageRef.child("images/\(imageName).jpg")
        
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let uploadTask = imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                guard metadata != nil else {
                    print("Error uploading image: \(error?.localizedDescription ?? "Unknown error")")
                    completion(false)
                    return
                }
                print("Image uploaded successfully")
                
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                        completion(false)
                        return
                    }
                    
                    self.savePostToFirestore(with: downloadURL.absoluteString) { success in
                        completion(success)
                    }
                }
            }
            
            uploadTask.resume()
        }
    }
    
    func savePostToFirestore(with imageUrl: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("posts").addDocument(data: [
            "id": UUID().uuidString,
            "title": title,
            "description": description,
            "imageUrl": imageUrl,
            "timestamp": Timestamp()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                print("Document added successfully")
                completion(true)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No update needed
    }
}

#Preview {
    CreatePost()
}
