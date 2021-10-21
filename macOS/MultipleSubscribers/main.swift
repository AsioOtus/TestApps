import Combine
import Foundation

var cancellables = Set<AnyCancellable>()

let requestPublisher = URLSession(configuration: .ephemeral)
	.dataTaskPublisher(for: URL(string: "http://127.0.0.1/count")!)
	.multicast { PassthroughSubject() }

requestPublisher
	.sink(
		receiveCompletion: { completion in
			print(completion)
		},
		receiveValue: { (data, response) in
			print(String(data: data, encoding: .utf8)!)
		}
	)
	.store(in: &cancellables)

DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
	requestPublisher
		.sink(
			receiveCompletion: { completion in
				print(completion)
			},
			receiveValue: { (data, response) in
				print(String(data: data, encoding: .utf8)!)
			}
		)
		.store(in: &cancellables)
}

DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
	requestPublisher
		.connect()
		.store(in: &cancellables)
}

print(requestPublisher)

RunLoop.current.run()
