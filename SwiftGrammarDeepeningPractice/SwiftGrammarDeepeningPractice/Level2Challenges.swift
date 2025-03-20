// ===== 25.03.19.(수) 구현 =====
// ===== LV 2. map과 고차함수 구현 =====

// ----- 요구사항 1. map 변환 코드 -----
let numbers = [6, 7, 8, 9, 10]
var resultMap = numbers.map { $0 }

// ----- 요구사항 2. 고차함수 체이닝: Array[Int] -> Array[String]
var resultStringMap = numbers.map { String($0) }

// ----- 요구사항 3. 고차함수 직접 만들어보기 (String 변환 Map 기능) -----
func myMap (_ numbers: [Int], _ closure: (Int) -> String) -> [String] {
    var resultMap = [String]()
    for number in numbers {
        resultMap.append(closure(number))
    }
    return resultMap
}
