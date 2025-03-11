
//  main.swift
//  baseballGameProjectBY
//
//  Created by iOS study on 3/11/25.
//  Lv.1. ~ LV.2

import Foundation

class BaseballGame {
//-----게임 시작 함수-----
func start() {
    
    let answer = makeAnswer()
    
    while true {
        //===== LV 2-1. 사용자 입력받기 =====
        print("숫자를 입력하세요 : ")
        guard let input = readLine() else {
            continue
        }
        
        // ===== LV 2-2. 정수로 변환되지 않는다면 반복문 처음으로 =====
        guard let userInputNumber = Int(input) else {
            print("올바르지 않은 입력값입니다")
            continue
        }
        
        //compachtMap사용
        let userInput = String(userInputNumber).compactMap { $0.wholeNumberValue }
        
        
        // ===== LV 2-3. 올바르지 않은 입력 값 제어(3. 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우) =====
        if userInput.count != 3 || Set(userInput).count != 3 || userInput.contains(0) {
            print("올바르지 않은 입력값입니다")
            continue
        }
        
        // ===== LV 2-4. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기 =====
        var strike = 0
        var ball = 0
        
        for (index, number) in userInput.enumerated() {
            if answer[index] == number {
                strike += 1
            } else if answer.contains(number) {
                ball += 1
            }
        }
        
        // ===== LV 2.5 결과 확인 =====
        if ball == 0 && strike == 0 {
            print("Nothing")
        } else {
            print("\(strike)스트라이크 \(ball)볼")
        }
        
        if strike == 3 {
            print("정답입니다!")
            break
        }
    }
}

//-----랜덤숫자 생성 함수-----
func makeAnswer() -> [Int] {
    // ===== 중복되지 않은 3개의 랜덤 숫자 생성 =====
    var answer: [Int] = []
            
    while answer.count < 3 {
        let randomNumber = Int.random(in: 1...9)
        if !answer.contains(randomNumber) { //중복체크
            answer.append(randomNumber)
        }
    }
    return answer //랜덤 숫자 리턴
}

}
//===== 게임 실행 =====
let game = BaseballGame()
game.start()
