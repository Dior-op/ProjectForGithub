//
//  ContentView.swift
//  ProjectForGithub
//
//  Created by Shahriyor on 06/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello my Friends!")
            
            Button("click here") {
                
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
