# Week1

## 함수형 프로그래밍을 왜 알아야 할까

사실 객체지향적 사고와 명령형 프로그래밍을 사용하기만 해도 왠만한 프로그램을 설계하고 작성하는 데는 무리가 없다. 우리는 이미 몇십 년간 이러한 사고방식으로 거대한 프로그램을 만들어왔지 않은가?

그러나 함수형 프로그래밍이 이렇게 주목받는 이유는 분명 기존의 그것들과는 분명한 차이가 있기 때문이고, 그 차이로 인해 개발자들이 조금 더 생산성있는 프로그래밍을 할 수 있기 때문일 것이다.

> 높은 수준의 추상화를 제공한다.  
> 함수 단위의 코드 재사용이 수월해진다.  
> 불변성을 지향하기 때문에 프로그램의 동작을 예측하기 쉬워진다  

</br></br>

## 순수함수 (pure function)

### 정의

- 동일한 인풋(인자)에는 항상 동일한 결과를 내야한다.
- 함수 외부의 상태를 변경하거나, 외부의 상태에 영향을 받아서는 안된다.

</br>

```swift
// 동일한 인풋에 대해서 동일한 결과를 내야 한다.
func sum(x: Int) -> Int {
    return x * 5
}

sum(x: 5) // 25
sum(x: 10) // 50
```

</br>

```swift
// 동일한 인풋에 대해서 동일한 결과를 예측할 수가 없다.
func sum(x: Int) -> Int {
    return x * Int(arc4random_uniform(5))
}

sum(x: 5) // ???
sum(x: 5) // ???
```

</br>

> 대표적인 순수하지 않은 함수로는 `API를 호출`하는 함수다  
> 같은 인풋을 보내더라도 예측 가능한 값을 얻기 어렵다.

</br></br>

## 익명함수 (anonymous function)

- 이름이 없는 함수  
- Swift의 클로저에 해당

```swift
{ <#매개변수#> -> <#리턴타입#> in
    return <#리턴값#>
}
```

</br>

```swift
func name() -> Void {
    print("나는 이름이 있는 함수다") 
}
name() // "나는 이름이 있는 함수다"

let nonName = { return "나는 이름이 없는 함수다" }
print( nonName() ) // "나는 이름이 없는 함수다"

```


</br>

```swift
var stringArray: [String] = [
    "나는 그냥 스트링",
    {
        let returnString = "나는" + "" + "익명함수"
        return returnString
    }()
]

print(stringArray) // ["나는 그냥 스트링", "나는익명함수"]

```

</br></br>

## 고차함수 (Higher-Order Function)

- Swift의 함수는 1급 객체로 취급받기 때문에 함수를 객체화 할 수 있다.  
- 전달인자로써 사용할 수 있다.  
- 매개변수로 받을 수 있다.
- 대표적인 고차함수에는 `map`, `filter`, `reduce`가 있다. 

고차함수를 사용할 수 있는 타입은 다음과 같다.

> Sequence와 Collection 프로토콜을 따르는 타입  
> Array, Dictionary, Set  
> Optional  

</br>

```swift
// map
let evens = [0, 2, 4, 6, 8]
let odds = [1, 3, 5, 7, 9]
let multiplyTwo: (Int) -> Int = { $0 * 2 }

let doubledEvens = evens.map(multiplyTwo) // [0, 4, 8, 12, 16]
let doubledOdds = odds.map(multiplyTwo)  // [2, 6, 10, 14, 18]

let tripleEvens = evens.map({ %0 * 3 }) // [0, 6, 12, 18, 24]
let tripleOdds = odds.map({ %0 * 3 }) // [3, 9, 15, 21, 27]
```

```swift
// filter

let numbers = [0, 1, 2, 3, 4, 5]
let filterFunc: (Int) -> Bool = { $0 % 2 == 0 }

let evens = numbers.filter(filterFunc) // [0, 2, 4]
let odds = numbers.map{ $0 + 3 }.filter{ $0 % 2 != 0 } // [3, 5, 7]

```

```swift
// reduce

let numbers = [1, 2, 3, 4]
let numberSum = numbers.reduce(0, { x, y in
  x + y
})
// CHECK-NEXT: 10
print(numberSum)

let letters = "abracadabra"
let letterCount = letters.reduce(into: [:]) { counts, letter in
  counts[letter, default: 0] += 1
}
// CHECK-NEXT: ["a", "b", "c", "d", "r"]
print(letterCount.keys.sorted())
print(letterCount["a"]!) // CHECK: 5
print(letterCount["b"]!) // CHECK: 2
print(letterCount["c"]!) // CHECK: 1
print(letterCount["d"]!) // CHECK: 1
print(letterCount["r"]!) // CHECK: 2
```

```swift
// Test the two reduce methods with different levels of inference
let numbers2 = Array(2..<7)

// Test reduce(_:_:)
// CHECK-NEXT: 20
let sum1 = numbers2.reduce(0) { (x: Int, y: Int) -> Int in x + y }
print(sum1)

// CHECK-NEXT: 20
let sum2 = numbers2.reduce(0) { (x, y) in x + y }
print(sum2)

// CHECK-NEXT: 20
let sum3 = numbers2.reduce(0) { $0 + $1 }
print(sum3)

// CHECK-NEXT: 20
let sum4 = numbers2.reduce(0, +)
print(sum4)

// Test reduce(into:_:)
// CHECK-NEXT: 20
let sum5 = numbers2.reduce(into: 0) { (x: inout Int, y: Int) in x += y }
print(sum5)

// CHECK-NEXT: 20
let sum6 = numbers2.reduce(into: 0) { x, y in x += y }
print(sum6)

// CHECK-NEXT: 20
let sum7 = numbers2.reduce(into: 0) { $0 += $1 }
print(sum7)

// CHECK-NEXT: 20
let sum8 = numbers2.reduce(into: 0, +=)
print(sum8)


// Test that the initial value remains unmodified
var original = [0, 1]
let result = numbers2.reduce(into: original) { acc, x in
  acc.append(x)
}
// CHECK-NEXT: [0, 1]
print(original)
// CHECK-NEXT: [0, 1, 2, 3, 4, 5, 6]
print(result)

```  
