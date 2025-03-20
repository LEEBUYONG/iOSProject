// ===== LV 1. 클로저 심화 실습하기 =====
// --- 요구사항 1, 2. 클로저 정의 및 클로저 상수 sum에 저장 ---
let sum: (Int, Int) -> String = {
    let result: Int = $0 + $1
    return "두 수의 합은 \(result) 입니다"
}

// --- 요구사항 4. 클로저를 파라미터로 받고 반환 값이 없는 함수 작성 및 호출 ---
func calculate(closure: (Int, Int) -> String, _ a: Int, _ b: Int) {
    let result = closure(a,b)
    print(result)
}
