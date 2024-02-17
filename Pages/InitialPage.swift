import SwiftUI

struct InitialPage: View {
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ConstTokenView(token: TokenModel("AaBb", colorTheme: .empty), showType: .text)
                        ConstTokenView(token: TokenModel("AaBb", colorTheme: .mint), showType: .text)
                        ConstTokenView(token: TokenModel("AaBb", colorTheme: .skyblue), showType: .text)
                        ConstTokenView(token: TokenModel("AaBb", colorTheme: .smoky), showType: .text)
                        ConstTokenView(token: TokenModel("AaBb", colorTheme: .turquoise), showType: .text)
                        ConstTokenView(token: TokenModel("AaBb", colorTheme: .violet), showType: .text)
                    }
                }
                .scrollIndicators(.hidden)
                Text("Meaning")
                    .font(.system(size: 128))
                NavigationLink {
                    SplitView()
                } label: {
                    Text("Start")
                }

                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ConstTokenView(token: TokenModel("AaBbaaaaaaaaaa", colorTheme: .mint), showType: .text_picture)
                        ConstTokenView(token: TokenModel("AaBbaaaaaaaaaa", colorTheme: .peach), showType: .text_picture)
                        ConstTokenView(token: TokenModel("AaBbaaaaaaaaaa", colorTheme: .pink), showType: .text_picture)
                        ConstTokenView(token: TokenModel("AaBbaaaaaaaaaa", colorTheme: .ravender), showType: .text_picture)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .background(Colors.background)
    }
}
