import Foundation

// MARK:

public func splitLines(ofText text: String) -> [String] {
    return text.components(separatedBy: .newlines)
}

public func createRows(fromLines lines: [String]) -> [[String]] {
    return lines.map { line in
        line.components(separatedBy: ",")
    }
}

public func removeInvalidRows(fromRows rows: [[String]]) -> [[String]] {
    return rows.filter { row in
        row.count == 3
    }
}



// MARK: 연산자 함수 사용

infix operator --> :AdditionPrecedence

public func --> <A, B, C> (aToB: @escaping (A) -> B,
                    bToC: @escaping (B) -> C)
    -> (A)
    -> C
{
    return { a in
        let b = aToB(a)
        let c = bToC(b)
        return c
    }
}


// MARK: 디버그

public func --> <A, B> (
    aToB: @escaping (A) -> B,
    sideEffect: @escaping (B) -> Void)
    -> (A) -> B
{
    return { a in
        let b = aToB(a)
        sideEffect(b)
        return b
    }
}


// MARK: 옵셔널

infix operator -->? :AdditionPrecedence

public func -->? <A, B, C> (
    aToB: @escaping (A) -> B?,
    bToC: @escaping (B) -> C?)
    -> (A) -> C?
{
    return { a in
        guard let b = aToB(a) else { return nil }
        let c = bToC(b)
        return c
    }
}


// MARK: 사이트 html 

import UIKit

public func url(forCompany stockSymbol: String) -> URL? {
    let companyMap = ["AAPL":  "http://apple.com",
                      "GOOGL": "http://google.com",
                      "MSFT":  "http://microsoft.com"]
    guard let path = companyMap[stockSymbol] else { return nil }
    return URL(string: path)
}

public func data(fromURL url: URL) -> Data? {
    return try? Data(contentsOf: url)
}

public func attributedHTML(withData data: Data) -> NSAttributedString? {
    return try? NSAttributedString(data: data,
                                   options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                   documentAttributes: nil)
}


//MARK: 일하는 시간
public func getHour(fromDate date: Date) -> Int {
    return Calendar.current.component(.hour, from: date)
}

public func isHour(_ hour: Int, between startHour: Int, and endHour: Int) -> Bool {
    return (startHour...endHour).contains(hour)
}
