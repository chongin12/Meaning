import SwiftUI

struct InitialPage: View {
    @ViewBuilder
    private func textConstTokenViews() -> some View {
        ConstTokenView(token: TokenModel("AaBb", colorTheme: .empty), showType: .text)
        ConstTokenView(token: TokenModel("AaBb", colorTheme: .mint), showType: .text)
        ConstTokenView(token: TokenModel("AaBb", colorTheme: .skyblue), showType: .text)
        ConstTokenView(token: TokenModel("AaBb", colorTheme: .smoky), showType: .text)
        ConstTokenView(token: TokenModel("AaBb", colorTheme: .turquoise), showType: .text)
        ConstTokenView(token: TokenModel("AaBb", colorTheme: .violet), showType: .text)
    }
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        textConstTokenViews()
                    }
                }

                Spacer()

                Text("Meaning")
                    .font(.system(size: 64))

                Spacer()

                NavigationLink {
                    SplitView()
                } label: {
                    Text("Start")
                }
                .buttonStyle(.borderedProminent)
                .scaleEffect(1.5)

                Spacer()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ConstTokenView(token: TokenModel("AaBbaaaaaaaaaa", colorTheme: .mint), showType: .text_picture)
                        ConstTokenView(token: TokenModel("AaBbaaaaaaaaaa", colorTheme: .peach), showType: .text_picture)
                        ConstTokenView(token: TokenModel("AaBbaaaaaaaaaa", colorTheme: .pink), showType: .text_picture)
                        ConstTokenView(token: TokenModel("AaBbaaaaaaaaaa", colorTheme: .ravender), showType: .text_picture)
                    }
                }

                Spacer()
            }
        }
        .background(Colors.background)
    }
}
