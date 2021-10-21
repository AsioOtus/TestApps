import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

enum GeneralUIError {
	case connection
	case critical
}

enum RegistrationFlowError: Error {
	case general
}
