import SwiftUI

struct SelectServiceView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    // Переменная для хранения выбранного изображения
    @Binding var selectedImageName: String
    
    let images = ["Default", "Facebook"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(images, id: \.self) { imageName in
                        Button {
                            selectedImageName = imageName
                        } label: {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedImageName == imageName ? Color.blue : Color.clear, lineWidth: 3)
                                .fill(selectedImageName == imageName ? Color(red: 28/255, green: 119/255, blue: 255/255, opacity: 0.2) : Color(red: 0.96, green: 0.97, blue: 0.98))
                                .frame(width: 115, height: 109)
                                .overlay {
                                    VStack {
                                        Image(imageName)
                                            .resizable()
                                            .frame(width: 48, height: 48)
                                            .scaledToFit()
                                        Text(imageName)
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .frame(maxHeight: .infinity)
                            .foregroundColor(.black)
                    }
//                    .padding(.leading, 31)
                }
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Text("Select icon")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                    .frame(maxHeight: .infinity)
                }
            }
        }
    }
}

