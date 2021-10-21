public enum ProcessingState <Initial, Processing, Completed, Failed> {
	case initial(Initial)
	case processing(Processing)
	case completed(Completed)
	case failed(Failed)
	
	public var stateName: String {
		switch self {
		case .initial:
			return "inital"
			
		case .processing:
			return "processing"
			
		case .completed:
			return "completed"
			
		case .failed:
			return "failed"
		}
	}
}

extension ProcessingState where Initial == Void {
	init () {
		self = .initial()
	}
	
	static func initial () -> Self {
		.initial(Void())
	}
}

extension ProcessingState where Processing == Void {
	static func processing () -> Self {
		.processing(Void())
	}
}

extension ProcessingState where Completed == Void {
	static func completed () -> Self {
		.completed(Void())
	}
}

extension ProcessingState where Failed == Void {
	static func completed () -> Self {
		.failed(Void())
	}
}
