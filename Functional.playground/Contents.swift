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
