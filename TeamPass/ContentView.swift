import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var teamPasses: [TeamPassModel]
    @Environment(\.modelContext) var context
    let teamPassController = TeamPassController()
    
    var listPassEmpty: Bool {
        teamPasses.isEmpty
    }
    
    var filteredPasses: [TeamPassModel] {
        if search.isEmpty {
            return teamPasses
        } else {
            return teamPasses.filter { pass in
                pass.serviceName.localizedCaseInsensitiveContains(search) ||
                pass.accountName.localizedCaseInsensitiveContains(search)
            }
        }
    }
    
    @State private var showSheet = false
    @State private var showSheetButton = false
    @State private var newServiceName: String = ""
    @State private var newPassword: String = ""
    @State private var newAccName: String = ""
    @State private var newImg: String = "Default"
    @State private var search: String = ""
    @FocusState var isAnyTextFieldFocused: Bool
    
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.92, green: 0.92, blue: 0.92),
                        Color(red: 0.86, green: 0.87, blue: 1.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    if listPassEmpty {
                        ListEmpty(showSheet: $showSheet)
                    } else {
                        ScrollView {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(.systemGray6), lineWidth: 2)
                                .frame(height: 47)
                                .overlay(
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(Color(.placeholderText))
                                            .padding(.leading, 16)
                                        TextField("Search service or account" , text: $search)
                                            .focused($isAnyTextFieldFocused)
                                            .frame(height: 47)
                                    }
                                )
                                .padding(.bottom, 14)
                            
                            ForEach(filteredPasses) { teamPass in
                                ListPassword(teamPass: teamPass, teamPassController: teamPassController)
                            }
                            
                            
                        }.padding(.horizontal, 14.5)
                        
                    }
                    Button(action: {
                        self.showSheet.toggle()
                    }){
                        Circle()
                            .frame(width: 52)
                            .overlay {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 28, weight: .medium))
                            }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 14.5)
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Team")
                                .foregroundColor(.white)
                                .font(.system(size: 29, weight: .bold))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(Color.blue)
                                )
                            Text("Passwords")
                                .font(.system(size: 29, weight: .semibold, design: .rounded))
                                .fontWeight(.bold)
                                .layoutPriority(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.top, 50)
                    }
                }
            }
        }
        .onTapGesture {
            isAnyTextFieldFocused = false
        }
        .sheet(isPresented: $showSheet) {
            NavigationStack {
                addSheetView
            }
            .onTapGesture {
                isAnyTextFieldFocused = false
            }
        }.presentationBackground(.white)
    }
    
    
    
    @ViewBuilder
    private var addSheetView: some View {
        VStack {
            CustomTextField(title: "New service name", isTextFieldFocus: $isAnyTextFieldFocused, text: $newServiceName)
            CustomTextField(title: "Account name", isTextFieldFocus: $isAnyTextFieldFocused, text: $newAccName)

            NavigationLink {
                SelectServiceView(selectedImageName: $newImg)
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(.systemGray6), lineWidth: 4)
                    .frame(height: 56)
                    .padding(.horizontal, 15)
                    .overlay(
                        HStack {
                            Image(newImg.isEmpty ? "Default" : newImg)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .scaledToFit()
                            Text(newImg.isEmpty ? "Default" : newImg)
                                .foregroundColor(.black)
                            Text("Tap to select")
                                .foregroundColor(Color(.placeholderText))
                        }
                    )
                    .padding(.bottom, 12)
            }
            
            
            CustomTextField(title: "Your password", isTextFieldFocus: $isAnyTextFieldFocused, text: $newPassword)
            
            Button(action: {
                newPassword = generateStrongPassword(length: 16)
            }) {
                Text("Generate password")
                    .foregroundColor(.blue)
                    .fontWeight(.medium)
                    .underline(true, color: .blue)
                    .padding(.bottom, 20)
            }
            Button(action: {
                if !(newServiceName.isEmpty || newPassword.isEmpty || newAccName.isEmpty){
                    teamPassController.addPass(newServiceName, newAccName, newImg, newPassword, context: context)
                    newServiceName = ""
                    newImg = "Default"
                    newPassword = ""
                    newAccName = ""
                    showSheet = false
                }
            }) {
                RoundedRectangle(cornerRadius: 100)
                    .foregroundStyle((newServiceName.isEmpty || newPassword.isEmpty || newAccName.isEmpty) ? Color.blue.opacity(0.3) : Color.blue)
                    .frame(height: 54)
                    .padding(.horizontal, 15)
                    .overlay {
                        Text("Save")
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 22)
            }
            .disabled(newServiceName.isEmpty || newPassword.isEmpty || newAccName.isEmpty)
        }
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(30)
        .presentationDetents([.height(500)])
    }
}

func generateStrongPassword(length: Int = 12) -> String {
    guard length >= 4 else { return "" }
    let lower = Array("abcdefghjkmnpqrstuvwxyz")
    let upper = Array("ABCDEFGHJKMNPQRSTUVWXYZ")
    let digits = Array("23456789")
    let symbols = Array("!@#$%^&*()-_=+<>?")
    var password = [
        lower.randomElement()!,
        upper.randomElement()!,
        digits.randomElement()!,
        symbols.randomElement()!
    ]
    let all = lower + upper + digits + symbols
    password += (0..<(length - 4)).compactMap { _ in all.randomElement() }
    password.shuffle()
    return String(password)
}

#Preview {
    ContentView()
}

