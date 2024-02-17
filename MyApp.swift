import SwiftUI

@main
struct MyApp: App {
    @StateObject private var tokenStorage = TokenStorage.mockData
    @State private var showType: ShowType = .text
    var body: some Scene {
        WindowGroup {
            ZStack {
                Colors.background
                    .ignoresSafeArea()
                InitialPage()
                    .environment(\.showType, $showType)
                    .environmentObject(tokenStorage)
            }
        }
    }
}
