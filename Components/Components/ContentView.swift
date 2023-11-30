import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var outputText: String = "Welcome to the Terminal.\n"
    @FocusState private var isInputFieldFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Text(outputText)
                    .font(.system(size: UIFont.systemFontSize, weight: .regular, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .background(Color.black)
                    .foregroundColor(Color.green)
            }
            .padding()

            HStack {
                TextField("Enter command", text: $inputText)
                    .focused($isInputFieldFocused)
                    .font(.system(size: UIFont.systemFontSize, weight: .regular, design: .monospaced))
                    .foregroundColor(.red) // Updated the color to red
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(10)

                Button(action: executeCommand) {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .foregroundColor(.orange)
                }
            }
            .padding()
            .background(Color.black)
            .cornerRadius(10)
            .padding(.bottom, isInputFieldFocused ? 320 : 0)
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.bottom)
        .onChange(of: isInputFieldFocused) { focused in
            if !focused {
                hideKeyboard()
            }
        }
    }
    
    func executeCommand() {
        outputText += "$ \(inputText)\n"
        inputText = ""
        isInputFieldFocused = false
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}