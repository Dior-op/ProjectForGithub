import SwiftUI
import RealmSwift

struct ContentView: View {
        
    @StateObject private var gvm = GenericsViewModel()
    @StateObject var vm = MainScreenViewModel()
    @State var sostyaniye: Bool = false
    @State var textTwo: String = "main.history.txt"
    @State var textUIkit: String = ""

    var body: some View {

        VStack {
            HStack {
                Text("UIkit:")
                UITextFiledViewRepresentable(textUIkit: $textUIkit)
                    .background(Color.gray)
                    .frame(height: 45)
            }

            HStack {
                Text(gvm.genericsBoolModel.info?.description ?? "no data")
                Text(gvm.genericsStringModel.info ?? "no data")
            }
            if sostyaniye == true {
                Rectangle()
                    .frame(width: 280, height: 340)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(AnyTransition.rotating.animation(.easeInOut))
            }
            Button("Regtangle") {
                sostyaniye.toggle()
            }
            Text(vm.text)
            TextField("napishite", text: $vm.text)
                .textFieldStyle(.roundedBorder)
            
            Button {
                guard vm.text.count > 5 else { return }
                vm.download(vm.text, textName: textTwo)
            } label: {
                Text("Soxranit")
                    .buttonModefire()
            }
            .withPressableStyle()

            
            Button {
                vm.text = vm.read(textTwo)
            } label: {
                Text("prochitat")
                    .buttonModefire()
            }
            .withPressableStyle()
            
            VStack {
                Image(systemName: "heart")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
        }
        .padding()

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

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(15)
            .foregroundColor(.black)
    }
}

struct ButtonAnatherStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.15),
                       value: configuration.isPressed)
    }
}

struct RotateViewModefier: ViewModifier {
    
    let rotation: Double
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.width : 0
            )
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        return AnyTransition.modifier(active: RotateViewModefier(rotation: 180), identity: RotateViewModefier(rotation: 0))
    }
}
extension View {
    func withPressableStyle() -> some View {
        buttonStyle(ButtonAnatherStyle())
    }
    func buttonModefire() -> some View {
        modifier(ButtonModifier())
    }
}

class GenericsViewModel: ObservableObject {
    
    @Published var genericsStringModel = GenericModel(info: "Hello world")
    @Published var genericsBoolModel = GenericModel(info: true)

    func removeData() {
        genericsStringModel = genericsStringModel.removeInfo()
        genericsBoolModel = genericsBoolModel.removeInfo()
    }

}

struct GenericModel<T> {
    let info: T?
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
    
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}

struct UITextFiledViewRepresentable: UIViewRepresentable {

    @Binding var textUIkit: String
    
    func makeUIView(context: Context) -> some UIView {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(textUIkit: $textUIkit)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var textUIkit: String
        init(textUIkit: Binding<String>) {
            self._textUIkit = textUIkit
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            textUIkit = textField.text ?? ""
        }
    }
    private func getTextField() -> UITextField {
        let textfield = UITextField(frame: .zero)
        textfield.layer.cornerRadius = 15
        let placeholder = NSAttributedString(string: "pishite", attributes: [.foregroundColor : UIColor.red])
        textfield.attributedPlaceholder = placeholder
        return textfield
    }
}

protocol ColorThemeProtocol {
    var primary: Color { get set }
    var secondary: Color { get set }
}

struct DefauldAnather: ColorThemeProtocol {
    var primary: Color = .red
    var secondary: Color = .blue
}
