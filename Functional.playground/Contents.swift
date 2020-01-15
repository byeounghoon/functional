import Foundation


func test() -> Int {
    return Int(5 * arc4random_uniform(5))
}

test()

func map() -> (Int) -> (Int) {
    return { Int -> Int in
        return 1
    }
}


let arr = [1,2,3]

arr.map { (value) -> Int in
    return value * 5
}

let evens = [0, 2, 4, 6, 8]
let odds = [1, 3, 5, 7, 9]
let multiplyTwo: (Int) -> Int = { $0 * 2 }

let doubledEvens = evens.map(multiplyTwo)
let doubledOdds = odds.map(multiplyTwo)

let tripleEvens = evens.map({ $0 * 3 })
let tripleOdds = odds.map({ $0 * 3 })

print(tripleEvens)
print(tripleOdds)

//func reduceFunt(initialResult: Int) -> (Int, Int)
//extension Array {
//    func reduceFuncreduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result {
//        
//        return
//    }
//
//}


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
