import SwiftUI
import SwiftData

@Observable
class TeamPassController {
    func addPass(_ serviceName: String,
                 _ accountName: String,
                 _ image: String,
                 _ password: String,
                 context: ModelContext)
    {
        let newPass = TeamPassModel(
            serviceName: serviceName,
            accountName: accountName,
            image: image,
            password: password
        )
        context.insert(newPass)
        try? context.save()
    }

    func toggleShow(_ pass: TeamPassModel, context: ModelContext) {
        pass.isShowing.toggle()
        try? context.save()
    }
    func deletePass(_ pass: TeamPassModel, context: ModelContext) {
        context.delete(pass)
        try? context.save()
    }
}
