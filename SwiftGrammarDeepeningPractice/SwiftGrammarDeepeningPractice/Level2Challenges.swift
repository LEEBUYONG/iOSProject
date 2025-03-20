// ===== 25.03.20.(목) 수정(numbers, numbers2 숫자 변경) =====
// ===== LV 2. map과 고차함수 구현 =====

// ----- 요구사항 1. map 변환 코드 -----
let numbers = [1, 2, 3, 4, 5]
var resultMap = numbers.map { $0 }

// ----- 요구사항 2. 고차함수 체이닝: Array[Int] -> Array[String] -----
let numbers2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var resultStringMap = numbers2.filter { $0 % 2 == 0 }.map { String($0) }

// ----- 요구사항 3. 고차함수 직접 만들어보기 (String 변환 Map 기능) -----
func myMap (_ numbers: [Int], _ closure: (Int) -> String) -> [String] {
    var resultMap = [String]()
    for number in numbers {
        resultMap.append(closure(number))
    }
    return resultMap
}
