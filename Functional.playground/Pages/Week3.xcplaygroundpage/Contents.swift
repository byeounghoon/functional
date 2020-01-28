
import Foundation

// MARK: Context

var myNumber: Int? = 2

myNumber
    .map({$0+3})            // Optional(5)
    .map({"\($0)"})         // Optional("5")


// MARK: Functor

let arrayFunctor: Array<Int> = [1,2,3,4,5,6,7]

arrayFunctor
    .map { $0 * 10 }        // Array<Int>
    .map { "\($0)" }        // Array<String>


let dictionaryFunctor: Dictionary<Int,Int> = [1:1,
                                              2:2]

dictionaryFunctor
    .mapValues { "\($0)" }  // Dictionary<Int, String>


// MARK: Monad

let optionalNumber: String? = "2"

print(optionalNumber.map({ Int($0) }))  // Optional(Optional(2))
print(optionalNumber.flatMap({ Int($0) }))  // Optional(2)



