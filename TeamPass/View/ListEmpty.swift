import SwiftUI

struct ListEmpty: View {
    
    @Binding var showSheet: Bool

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.1))
                .frame(width: 361, height: 240.59)
                .overlay {
                    VStack {
//                        Image(.group)
                        Text("Add your first Passwords")
                            .fontWeight(.bold)
                        Text("Select the way to add")
                    }
                }
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.1))
                .frame(width: 361, height: 36)
                .overlay {
                    HStack {
                        Text("App Supports:")
                        Text("Web-site & Servecies")
                            .fontWeight(.medium)
                    }
                }
            
            Button(action: {
                self.showSheet.toggle()
            })
            {
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.blue)
                    .frame(width: 361, height: 56)
                    .overlay {
                        Text("add password")
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                    }
            }
        }   .frame(maxHeight: .infinity, alignment: .top)
    }
}
