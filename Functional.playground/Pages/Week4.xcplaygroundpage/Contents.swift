import Foundation

enum Maybe<T> : ExpressibleByNilLiteral {
    
    typealias T = Hashable
    
    case just(T)
    case nothing
    
    public init(_ some: T) { self = .just(some) }
    public init(nilLiteral: ()) { self = .nothing }
    
}

extension Maybe: CustomDebugStringConvertible {
    /// A textual representation of this instance, suitable for debugging.
    public var debugDescription: String {
        switch self {
        case .just(let value):
            var result = "Maybe("
            debugPrint(value, terminator: "", to: &result)
            result += ")"
            return result
        case .nothing:
            return "nil"
        }
    }
}


var maybeString: Maybe<String> = Maybe("테스트")
print(maybeString)
maybeString = nil
print(maybeString)


public enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

var either: Either<Int, String>

either = .left(1)
print(either)           // left(1)
either = .right("1")
print(either)           // right("1")


