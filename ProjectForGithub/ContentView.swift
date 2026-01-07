//
//  ContentView.swift
//  ProjectForGithub
//
//  Created by Shahriyor on 06/01/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var text: String = "chain"
    @State var textTwo: String = "chain"

    var body: some View {
        VStack {
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(textTwo)
            Text(text)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
