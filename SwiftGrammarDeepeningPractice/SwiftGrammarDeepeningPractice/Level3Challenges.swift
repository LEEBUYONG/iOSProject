// ===== 25.03.19.(수) 구현 =====
// ===== LV 3. 차후 수정 계획: print 지우기, 주석 정리, 코드 컨벤션 확인 =====

// ----- 함수 a 구현 -----
func a(_ x: [Int]) -> [Int] {
    var result: [Int] = []
    for num in x {
        if num % 2 == 0 {
            continue
        } else {
            result.append(num)
        }
    }
    return result
}

// ----- 함수 b 구현 -----
func b(_ x: [String]) -> [String] {
    var result: [String] = []
    for (index, str) in x.enumerated() { //인덱스와 값을 같이 가져오고
        if index % 2 == 1 {
            continue
        } else {
            result.append(str)           //홀수 인덱스만 결과에 추가
        }
    }
    return result
}

// ----- 함수 c 구현 -----
func c(_ x: [Int], _ y: [String]) -> ([Int], [String]) {
    var resultInt: [Int] = []
    var resultString: [String] = []
    
    for num in x {
        if num % 2 == 1 {       //값이 짝수인지 확인
            resultInt.append(num)
        }
    }
    
    for (index, str) in y.enumerated() {
        if index % 2 == 0 {     //인덱스가 짝수인지 확인
            resultString.append(str)
        }
    }
    return (resultInt, resultString)
}

func c1 (_ x: [Int], _ y: [String]) -> ([Int], [String]) {
    let resultInt: [Int] = x.filter { $0 % 2 == 1 }
    let resultString: [String] = y.enumerated().filter { $0.offset % 2 == 0 }.map
    { $0.element } //y를 인덱스, 값 형태로 만들기 > 필터로 인덱스 짝수 거르기 > 맵으로 값만 추출하기
    return (resultInt, resultString)
}

// ----- 함수 d 구현: Numeric 프로토콜 사용 -----
//함수 제네릭 타입 T는 Numeric 프로토콜을 준수하는데 T는 숫자만 처리 가능
//배열을 함께 처리해야하는지 아니면 Numeric 프로토콜을 사용해서 숫자만 받아서 처리하는지
//Numeric 프로토콜은 %연산자 사용을 못해서 짝수를 추출하지 못해서 인덱스 순서를 추출함
//현재 코드는 인덱스의 짝수만 반환(값은 홀수)하는 건데 짝수를 추출하는게 아니라 단순하게 인덱스 순서만을 구분
//이런 방식이 아니라 Numeric 사용하면서 값 중에 짝수만을 구분해서 반환하는 방법은 없는건지..
//ㅠㅠㅠ내일 튜터님께 조언을 구해봐야겠다..

func d<T: Numeric>(_ x: [T]) -> [T] {
    let resultInt: [T] = x.enumerated().filter{ $0.offset % 2 == 0 }.map { $0.element }
    return resultInt
}
