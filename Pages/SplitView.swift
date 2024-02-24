//
//  SplitView.swift
//  
//
//  Created by 정종인 on 2/15/24.
//

import SwiftUI

struct SplitView: View {
    @State private var selection: TokenGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @EnvironmentObject var tokenStorage: TokenStorage
    @Environment(\.showType) var showType

    // MARK: Add Items
    @State private var text: String = ""
    @State private var addingWordItem: Bool = false
    @State private var addingPhraseItem: Bool = false
    @State private var addingSentence: Bool = false

    @State private var choosedTokens: [TokenModel] = []

    // MARK: Tutorial
    @State private var phase: Int = 0
    @State private var showingTutorial: Bool = true
    @State private var tutorialAnimation: Bool = false
    @State private var isFlickering = false

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List {
                wordsSection()
                Divider()
                phrasessSection()
                Divider()
                sentencesSection()
            }
        } detail: {
            Group {
                if let selection {
                    TokenGroupView(selection.id, $columnVisibility, $tutorialAnimation)
                } else {
                    Text("choose any Words, Phrases, or Sentences in Sidebar")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Picker("Show Type", selection: showType) {
                        Image(systemName: "rectangle")
                            .tag(ShowType.text)
                        Image(systemName: "rectangle.tophalf.inset.filled")
                            .tag(ShowType.text_picture)
                        Image(systemName: "rectangle.fill")
                            .tag(ShowType.picture)
                    }
                    .pickerStyle(.segmented)
                    if phase < 4 {
                        Button(action: {
                            phase += 1
                        }, label: {
                            Text("Next Tutorial")
                        })
                        .buttonStyle(.borderedProminent)
                        .opacity(isFlickering ? 0.7 : 1.0)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                                isFlickering.toggle()
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .tint(.brown)
        .onChange(of: phase, perform: { value in
            showingTutorial = true
        })
        .sheet(isPresented: $showingTutorial, content: {
            if phase == 0 {
                TutorialPage(
                    "Welcome",
                    "Tutorial",
                    """
                    In this app, a "token" refers to a word or a phrase.

                    When you select an item from the left sidebar, the corresponding token for that item will be displayed.

                    You can illustrate the selected token with a simple drawing or symbol.

                    After selecting the word "smile" from the left sidebar, touch the token to draw a smiling face symbol.

                    After completing everything, click the 'Next Tutorial' button at the top right.
                    """,
                    buttonAction: {
                        tokenStorage.words.append(TokenGroup(tokens: [TokenModel("smile")]))
                        selection = tokenStorage.words.last
                        tutorialAnimation = true
                    }
                ) {
                    HStack {
                        Spacer()
                        ConstTokenView(token: .init("smile"), showType: .text)
                        Spacer()
                    }
                    .padding()
                }
            }
            if phase == 1 {
                TutorialPage(
                    "Step 1",
                    "Creating Words",
                    """
                    In this step, you need to complete the word 'I'. Select the word 'I' from the left sidebar, and use the Apple Pencil to draw a simple picture or symbol that represents this word.

                    Additionally, you can change the display format at any time. You can choose to display text only, both text and canvas, or canvas only.

                    After completing everything, click the 'Next' button at the top right.
                    """,
                    buttonAction: {
                        tokenStorage.words.append(TokenGroup(tokens: [TokenModel("I")]))
                        selection = tokenStorage.words.last
                    }
                ) {
                    VStack {
                        Picker("Show Type", selection: showType) {
                            Image(systemName: "rectangle")
                                .tag(ShowType.text)
                            Image(systemName: "rectangle.tophalf.inset.filled")
                                .tag(ShowType.text_picture)
                            Image(systemName: "rectangle.fill")
                                .tag(ShowType.picture)
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        HStack {
                            Spacer()
                            TokenView(token: .constant(.init("I")))
                            Spacer()
                        }
                        .padding()
                    }
                }
            } else if phase == 2 {
                TutorialPage(
                    "Step 2",
                    "Creating Phrases",
                    """
                    In this step, I will create the phrase 'in the morning'.
                    Select this phrase from the left sidebar and use the Apple Pencil to draw a simple picture or symbol that represents the phrase.

                    After completing everything, click the 'Next' button at the top right.
                    """,
                    buttonAction: {
                        tokenStorage.phrases.append(TokenGroup(tokens: [TokenModel("in the morning")]))
                        selection = tokenStorage.phrases[0]
                    }
                ) {
                    HStack {
                        Spacer()
                        ConstTokenView(token: .init("in the morning"), showType: .text)
                        Spacer()
                    }
                    .padding()
                }
            } else if phase == 3 {
                TutorialPage(
                    "Step 3",
                    "Creating Sentences",
                    """
                    Now, let's use the words and phrases we have created to make a sentence.
                    Select 'Add Sentence' from the left sidebar and complete the sentence 'I smile in the morning'.

                    After finishing the sentence, click on the filled rectangle icon at the top right to check the results.

                    After completing everything, click the 'Next' button at the top right.
                    """,
                    buttonAction: {
                        addingSentence.toggle()
                    }
                ) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ConstTokenView(token: .init("I", colorTheme: .peach), showType: .text)
                            ConstTokenView(token: .init("smile", colorTheme: .mint), showType: .text)
                            ConstTokenView(token: .init("in the morning", colorTheme: .skyblue), showType: .text)
                        }
                    }
                    .padding()
                }
            } else if phase == 4 {
                TutorialPage(
                    "Step 4",
                    "Conclusion",
                    """
                    Congratulations! 🎉🎉
                    You have just combined words and phrases to create a sentence, which is the process of creating your own new language.

                    All languages started from pictures, which are tools we use to effectively express thoughts, emotions, and ideas. We hope this experience has given you a new understanding of the origins and development of language.

                    Also, share the creative thoughts or unique ideas that came to you during this process of creating a new language with the people around you. This is the final step in our journey to create a new language.
                    """
                ) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            if let word1 = tokenStorage.findWord(text: "I") {
                                ConstTokenView(token: word1, showType: .picture)
                            }
                            if let word2 = tokenStorage.findWord(text: "smile") {
                                ConstTokenView(token: word2, showType: .picture)
                            }
                            if let phrase = tokenStorage.findPhrase(text: "in the morning") {
                                ConstTokenView(token: phrase, showType: .picture)
                            }
                        }
                    }
                    .padding()
                }
            }
        })
    }

    @ViewBuilder
    private func TutorialPage(_ title: String, _ subtitle: String, _ message: String, buttonAction: @escaping () -> () = {}, contents: () -> some View) -> some View {
        VStack(spacing: 10) {
            Spacer()

            Text(title)
                .font(.subheadline)
                .fontWeight(.light)

            Text(subtitle)
                .font(.title)

            Spacer()

            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            contents()

            Spacer()

            Button(action: {
                buttonAction()
                showingTutorial = false
            }, label: {
                Text("Got it 😎")
                    .padding()
            })
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
        .transition(.identity)
    }

    private func wordsSection() -> some View {
        Section("Words") {
            tokenListItems(tokenGroups: tokenStorage.words)
            addWordItemView()
        }
        .deleteDisabled(false)
    }

    private func phrasessSection() -> some View {
        Section("Phrases") {
            tokenListItems(tokenGroups: tokenStorage.phrases)
            addPhraseItemView()
        }
    }

    private func sentencesSection() -> some View {
        Section("Sentences") {
            tokenListItems(tokenGroups: tokenStorage.sentences)
            addSentenceView()
        }
    }

    @ViewBuilder
    private func addWordItemView() -> some View {
        Button(action: {
            addingWordItem.toggle()
        }, label: {
            Label(
                title: { Text("Add Item") },
                icon: { Image(systemName: "plus.app") }
            )
        })
        .padding(.horizontal)
        .padding(.top, 5)
        .alert("Add Word", isPresented: $addingWordItem) {
            TextField("Enter any word", text: $text)
            Button("OK") {
                if text.trimmingCharacters(in: [" "]) != "" {
                    tokenStorage.words.append(TokenGroup(tokens: [TokenModel(text)]))
                }
                text = ""
                selection = tokenStorage.words.last
            }
            Button("Cancel", role: .cancel, action: {
                text = ""
            })
        }
    }

    @ViewBuilder
    private func addPhraseItemView() -> some View {
        Button(action: {
            addingPhraseItem.toggle()
        }, label: {
            Label(
                title: { Text("Add Item") },
                icon: { Image(systemName: "plus.app") }
            )
        })
        .padding(.horizontal)
        .padding(.top, 5)
        .alert("Add Phrase", isPresented: $addingPhraseItem) {
            TextField("Enter any phrase", text: $text)
            Button("OK") {
                if text.trimmingCharacters(in: [" "]) != "" {
                    tokenStorage.phrases.append(TokenGroup(tokens: [TokenModel(text)]))
                }
                text = ""
                selection = tokenStorage.phrases.last
            }
            Button("Cancel", role: .cancel, action: {
                text = ""
            })
        }
    }

    @ViewBuilder
    private func addSentenceView() -> some View {
        Button(action: {
            addingSentence.toggle()
        }, label: {
            Label(
                title: { Text("Add Item") },
                icon: { Image(systemName: "plus.app") }
            )
        })
        .padding(.horizontal)
        .padding(.top, 5)
        .sheet(isPresented: $addingSentence, content: {
            NavigationStack {
                HStack {
                    List {
                        Section(header: Text("Words")) {
                            ForEach(tokenStorage.words) { word in
                                Button(word.text) {
                                    withAnimation {
                                        choosedTokens.append(
                                            TokenModel(
                                                word.tokens[0].text,
                                                colorTheme: word.tokens[0].colorTheme,
                                                canvas: word.tokens[0].canvas
                                            )
                                        )
                                    }
                                }
                            }
                        }
                        Section(header: Text("Phrases")) {
                            ForEach(tokenStorage.phrases) { phrase in
                                Button(phrase.text) {
                                    withAnimation {
                                        choosedTokens.append(
                                            TokenModel(
                                                phrase.tokens[0].text,
                                                colorTheme: phrase.tokens[0].colorTheme,
                                                canvas: phrase.tokens[0].canvas
                                            )
                                        )
                                    }
                                }
                            }
                        }
                    }
                    if choosedTokens.isEmpty {
                        VStack {
                            Text("Select words or phrases")
                                .padding(.top)

                            List {
                                ForEach(choosedTokens) { token in
                                    Text(token.text)
                                }
                                .onDelete(perform: delete)
                            }
                        }
                    } else {
                        List {
                            ForEach(choosedTokens) { token in
                                Text(token.text)
                            }
                            .onDelete(perform: delete)
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            addingSentence.toggle()
                            choosedTokens.removeAll()
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            tokenStorage.sentences.append(TokenGroup(tokens: choosedTokens))
                            choosedTokens.removeAll()
                            addingSentence.toggle()
                            selection = tokenStorage.sentences.last
                        }, label: {
                            Text("Done")
                        })
                    }
                }
                .navigationTitle("Add Sentence")
                .padding()
            }
        })
    }

    private func delete(at offsets: IndexSet) {
        choosedTokens.remove(atOffsets: offsets)
    }

    @ViewBuilder
    private func tokenListItems(tokenGroups : [TokenGroup]) -> some View {
        ForEach(tokenGroups) { tokenGroup in
            HStack {
                Button(action: {
                    withAnimation {
                        selection = tokenGroup
                    }
                }, label: {
                    TokenListItem(tokenGroup: tokenGroup)
                })
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(self.selection == tokenGroup ? Colors.point : Color.clear, in: RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .foregroundStyle(self.selection == tokenGroup ? Colors.textBright : Color.primary)
            .padding(.vertical, -6.3)
        }
    }
}

#Preview {
    SplitView()
        .environmentObject(TokenStorage.mockData)
}
