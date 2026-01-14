import SwiftUI
import RealmSwift

struct RealmTestView: View {
    
    @State var textName: String = ""
    @State var textAge: String = ""
    @State private var showAlert = false
    @State private var isAgeInvalid = false


    @Environment(\.realm) var realm
    @ObservedResults(Person.self) var people
    
    
    var body: some View {
        VStack(spacing: 16) {
            
            List {
                ForEach(people) { person in
                    Text("Name: \(person.name) \nage: \(person.age)")
                }
                .onDelete(perform: $people.remove)
            }
            .frame(height: 400)
            .cornerRadius(15)

            TextField("Name", text: $textName)
                .textFieldStyle(.roundedBorder)
                .shadow(radius: 10)
            
            TextField("Age", text: $textAge)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .shadow(radius: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isAgeInvalid ? Color.red : Color.clear, lineWidth: 2)
                )
            if isAgeInvalid {
                Text("Возраст должен быть больше 18")
                    .foregroundColor(.red)
                    .font(.caption)
            }


            Button("Сохранить") {
                savePerson()
            }
            .buttonStyle(.borderedProminent)
            .alert("vash vozrast menshe 18", isPresented: $showAlert) {
                Button("OK") {
                }
            }
        }
        .padding()
    }
    
    private func savePerson() {
        guard let age = Int(textAge), !textName.isEmpty else { return }
        guard age > 18 else {
            showAlert = true
            isAgeInvalid = true
            return
        }
        
        isAgeInvalid = false

        let person = Person()
        person.name = textName
        person.age = age
        

        try? realm.write {
            realm.add(person)
        }
        
        textName = ""
        textAge = ""
    }

}

#Preview {
    RealmTestView()
}
