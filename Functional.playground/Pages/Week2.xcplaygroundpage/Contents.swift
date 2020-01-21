//
// Function Composition in Swift
// by Josh Smith - January 2017
// https://github.com/ijoshsmith/function-composition-in-swift
//

/*
 Suppose you need to process comma-separated values.
 You receive some CSV text and need to only keep the rows that contain exactly three values.
 The following functions would do the trick.
 */
import Foundation


/*
 Here is the CSV text to process. The last row (Cat,Cut) is invalid because it has two values.
 Ace,Ale,Are
 Bag,Beg,Bug
 Car,Cat
 */
let csv: String = [
    "Ace,Ale,Are",
    "Bag,Beg,Bug",
    "Cat,Cut"
    ].joined(separator: "\n")

/*
 Weaving these functions together might look something like this.
 */


let lines = splitLines(ofText: csv)
let rows = createRows(fromLines: lines)
var validRows = removeInvalidRows(fromRows: rows)

/*
 It can be tempting to remove temporary variables that store each
 return value, but that often makes the code harder to understand.
 */
let huh = removeInvalidRows(fromRows: createRows(fromLines: splitLines(ofText: csv)))


// MARK: 연산자 함수 사용

let processCSV = splitLines(ofText:) --> createRows(fromLines:) --> removeInvalidRows(fromRows:)
validRows = processCSV(csv)

// MARK: Debug

let processCSVWithLogging = splitLines(ofText:)
    --> { print("lines: \($0)") }
    --> createRows(fromLines:)
    --> { print("rows: \($0)") }
    --> removeInvalidRows(fromRows:)
    --> { print("valid rows: \($0)") }

validRows = processCSVWithLogging(csv)



// MARK: attributedHTMLForCompany

let attributedHTMLForCompany = url(forCompany:) -->? data(fromURL:) -->? attributedHTML(withData:)

let html = attributedHTMLForCompany("AAPL") // Pass AAPL, or GOOGL, or MSFT to download a web page.



// MARK: isWorkHour

//let isWorkHour = getHour(fromDate:) --> { isHour($0, between: 9, and: 17) }
//
//let now = Date()
//let shouldBeAtWork = isWorkHour(now)



// MARK: Currying

func add(_ a: Int,_ b: Int) -> Int {
  return a + b
}

let sum = add(2, 3) // sum = 5

let xs = 1...100
var x = xs.map { add($0, 2) } // x = [3, 4, 5, 6, etc]


//

func addTwo(a: Int) -> Int {
  return add(a, 2)
}

//let xs = 1...100
x = xs.map(addTwo) // x = [3, 4, 5, 6, etc]


let c : (Int) -> (Int) -> (Int) = curry(+)

let d = c(curry(+)(1)(2))














