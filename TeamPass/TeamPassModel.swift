import SwiftUI
import SwiftData

@Model
class TeamPassModel: Identifiable {
    var id: UUID
    var serviceName: String
    var accountName: String
    var image: String
    var password: String
    var isShowing: Bool = false
    
    init(serviceName: String, accountName: String, image: String, password: String) {
        self.id = UUID()
        self.serviceName = serviceName
        self.accountName = accountName
        self.image = image
        self.password = password
    }
}
