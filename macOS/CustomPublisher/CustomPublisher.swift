import Foundation
import Combine

struct Progressions {
	static func exponent (base: Double) -> (Double) -> Double {
		{ iteration in pow(base, iteration) }
	}
	
	static func geometric (initial: Double, scaleFactor: Double) -> (Double) -> Double {
		{ iteration in initial * pow(scaleFactor, iteration - 1) }
	}
}

extension Publisher {
	static func functional (count: Subscribers.Demand, function: @escaping (Double) -> Double) -> Publishers.Functional {
		.init(count: count, function: function)
	}
}

extension Publishers {
	struct Functional: Publisher {
		typealias Output = Double
		typealias Failure = Never
		
		let count: Subscribers.Demand
		let function: (Double) -> Double
		
		func receive <S> (subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
			let subscription = Subscriptions.FunctionalSubscription(subscriber: subscriber, count: count, function: function)
			subscriber.receive(subscription: subscription)
		}
	}
}
extension Subscriptions {
	class FunctionalSubscription <S: Subscriber>: Subscription where S.Input == Double {
		var subscriber: S?
		
		let function: (Double) -> Double
		let count: Subscribers.Demand
		var iteration: Int
		
		init (subscriber: S?, count: Subscribers.Demand = .unlimited, function: @escaping (Double) -> Double) {
			self.subscriber = subscriber
			
			self.function = function
			self.count = count
			self.iteration = 0
		}
		
		func request (_ demand: Subscribers.Demand) {
			repeat {
				guard let subscriber = subscriber, iteration <= demand && iteration <= count else {
					subscriber?.receive(completion: .finished)
					break
				}
				
				let input = function(Double(iteration))
				_ = subscriber.receive(input)
				
				iteration += 1
			} while true
		}
		
		func cancel() {
			subscriber = nil
		}
	}
}

extension Subscribers {
	class FunctionalSubscriber: Subscriber {
		typealias Input = Double
		typealias Failure = Never
		
		var limit: Subscribers.Demand
		
		init (_ limit: Subscribers.Demand) {
			self.limit = limit
		}
		
		func receive (subscription: Subscription) {
			subscription.request(limit)
		}
		
		func receive (_ input: Double) -> Subscribers.Demand {
			print(input)
			return .none
		}
		
		func receive (completion: Subscribers.Completion<Never>) {
			Swift.print("COMPLETED")
		}
	}
}
