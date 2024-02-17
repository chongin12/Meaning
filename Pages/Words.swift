//
//  Words.swift
//
//
//  Created by 정종인 on 2/15/24.
//

import SwiftUI

struct WordsPage: View {
    var body: some View {
        NavigationSplitView {
            List {
                Label("asdf", systemImage: "circle")
            }
            .listStyle(.sidebar)
        } detail: {
            Text("asdf")
        }
    }
}

#Preview {
    WordsPage()
}
