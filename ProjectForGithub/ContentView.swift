//
//  ContentView.swift
//  ProjectForGithub
//
//  Created by Shahriyor on 06/01/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var text: String = "Main"
    
    var body: some View {
        VStack {
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello my Friends!")
            Text(text)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
