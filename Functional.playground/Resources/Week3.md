# Week3 <Functor와 모나드>

## 컨텍스트 (Context)

- 맥락, 문맥
- 어떠한 값이 존재할 수 있는 맥락
- Optional, Array, Dictionary
- Rx의 Observable

<br>

## 함수객체 (Functor)

- 고차함수인 map, filter를 적용할 수 있는 컨테이너 타입

```swift
var myNumber: Int? = 2

myNumber
    .map({$0+3})    // Optional(5)
    .map("\($0)")   // Optional("5") 
```

- Array, Dictionary도 컨테이너 타입

```swift
let arrayFunctor: Array<Int> = [1,2,3,4,5,6,7]

arrayFunctor
    .map { $0 * 10 }        // Array<Int>
    .map { "\($0)" }        // Array<String>
```

```swift
let dictionaryFunctor: Dictionary<Int,Int> = [1:1,
                                              2:2]

dictionaryFunctor
    .mapValues { "\($0)" }  // Dictionary<Int, String>
```

<br>

## 모나드 (Monad)

- 함수 객체의 일종이다.
- 함수 객체(Functor)에서 값이 있는 지 없는지 모르는 상태 까지 포괄하는 개념
- flatMap을 쓸수 있다면 모나드라 할 수 있다. 

```swift
let optionalNumber: String? = "2"

print(optionalNumber.map({ Int($0) }))  // Optional(Optional(2))
print(optionalNumber.flatMap({ Int($0) }))  // Optional(2)
```


