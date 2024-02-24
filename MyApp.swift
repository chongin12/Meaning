import SwiftUI

@main
struct MyApp: App {
    @StateObject private var tokenStorage = TokenStorage()
    @State private var showType: ShowType = .text
    var body: some Scene {
        WindowGroup {
            ZStack {
                Colors.background
                    .ignoresSafeArea()
//                InitialPage()
                SplitView()
                    .environment(\.showType, $showType)
                    .environmentObject(tokenStorage)
            }
        }
    }
}
