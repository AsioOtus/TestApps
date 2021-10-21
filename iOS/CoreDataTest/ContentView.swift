import SwiftUI
import CoreData

struct DefaultError: Error { }

struct ContentView: View {
	let container: NSPersistentContainer

	var items = ProcessingState<Void, Void, [Item], DefaultError>()
	
	init () {
		container = NSPersistentContainer(name: "Main")
		
		container.loadPersistentStores(
			completionHandler: { (storeDescription, error) in
				if let error = error as NSError? {
					fatalError("Unresolved error \(error), \(error.userInfo)")
				}
			}
		)
	}
	
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
