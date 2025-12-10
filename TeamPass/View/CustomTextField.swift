import SwiftUI

struct CustomTextField: View {
    var title: String
    @FocusState<Bool>.Binding var isTextFieldFocus: Bool
    @Binding var text: String
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color(.systemGray6), lineWidth: 4)
            .frame(height: 56)
            .padding(.horizontal, 15)
            .overlay(
                TextField(title , text: $text)
                    .frame(height: 56)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15)
                    .focused($isTextFieldFocus)
            )
            .padding(.bottom, 12)
    }
}
