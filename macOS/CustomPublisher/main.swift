import Foundation
import Combine

var cancellables = Set<AnyCancellable>()

let exponentialPublisher = Publishers.Functional(count: .max(10), function: Progressions.exponent(base: 3))

print("START")

exponentialPublisher
//	.subscribe(on: DispatchQueue.global(qos: .default))
	.receive(on: DispatchQueue.global(qos: .default))
	.sink { print($0) }
	.store(in: &cancellables)

print("FINISH")

RunLoop.current.run()
