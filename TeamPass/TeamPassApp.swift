import SwiftUI
import SwiftData

@main
struct TeamPassApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: TeamPassModel.self)
        }
    }
}
