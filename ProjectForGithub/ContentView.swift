//
//  ContentView.swift
//  ProjectForGithub
//
//  Created by Shahriyor on 06/01/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = MainScreenViewModel()
    
    @State var textTwo: String = "main.history.txt"

    var body: some View {
        VStack {
            Text(vm.text)
            TextField("napishite", text: $vm.text)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button {
                guard vm.text.count > 5 else { return }
                vm.download(vm.text, textName: textTwo)
            } label: {
                Text("Soxranit")
            }
            
            Button {
                vm.text = vm.read(textTwo)
            } label: {
                Text("prochitat")
            }

            
            VStack {
                Image(systemName: "heart")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

class MainScreenViewModel: ObservableObject {
    
    @Published var text: String = ""

    func download(_ text: String, textName: String) {
        
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let url = directory.appendingPathComponent(textName)
        
        do {
            try text.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print(error)
        }
    }
    
    func read(_ textName: String) -> String {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return ""}
        let url = directory.appendingPathComponent(textName)
        return (try? String(contentsOf: url, encoding: .utf8)) ?? ""
    }
}
