import SwiftUI

struct ListPassword: View {
    @State var teamPass: TeamPassModel
    @State var teamPassController: TeamPassController
    @Environment(\.modelContext) var context

    @State private var showAlert = false
    
    var body: some View {
        HStack () {
            Circle()
                .fill(Color.white)
                .frame(width: 44)
                .overlay {
                    Image(teamPass.image)
                        .resizable()
                        .scaledToFill()
                        .padding(7.8)
                }
            if teamPass.isShowing == false {
                HStack {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20))
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20))
                    Text("Tap to unlock")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                teamPassController.toggleShow(teamPass, context: context)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            } else {
                VStack (alignment: .leading) {
                    Text(teamPass.password)
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Text(teamPass.serviceName)
                            .font(.system(size: 14))
                            .lineLimit(1)
                        
                        Text(teamPass.accountName)
                            .foregroundColor(Color.gray)
                            .font(.system(size: 14))
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            Button(action: {
                UIPasteboard.general.string = teamPass.password
            }){
                Image(systemName: "document.on.document")
            }
            .padding(.leading)
            Button(action: {
                self.showAlert.toggle()
            }){
                Image(systemName: "ellipsis")    .rotationEffect(.degrees(90))
                    .foregroundColor(Color.gray)
            }
            .confirmationDialog("Please select an action", isPresented: $showAlert) {
                Button("Show password") {
                    teamPassController.toggleShow(teamPass, context: context)
                }
                .disabled(teamPass.isShowing)
                
                Button("Hide password") {
                    teamPassController.toggleShow(teamPass, context: context)
                }
                .disabled(!teamPass.isShowing)
                
                Button("Delete", role: .destructive) {
                    teamPassController.deletePass(teamPass, context: context)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 78)
        .padding(.horizontal, 12)
        .padding(.bottom, 12)
        .background(Color(.systemGray6))
        .cornerRadius(20)
    }
}
