# Week4 <Maybe와 Either>


## Maybe

기본적으로 두가지 형태를 띄고 있다

- Just 
- Nothing

Swift의 `Optional`과 유사하다

```Swift
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
print(maybeString)      // Maybe("테스트")
maybeString = nil
print(maybeString)      // nil
```

## Either

둘 중 하나의 값을 가지는 패턴

Swift의 `Result` 타입과 비슷하다.

```Swift
public enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

var either: Either<Int, String>

either = .left(1)
print(either)           // left(1)
either = .right("1")
print(either)           // right("1")
```

- API의 응답결과에서 많이 사용(데이터가 있거나, 에러이거나)