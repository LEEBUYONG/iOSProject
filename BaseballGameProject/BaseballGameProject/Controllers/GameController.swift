//  Lv.1. ~ LV.2
//  Controller Code

import Foundation

class GameController {
    
    private let randomGenerator = RandomGenerator()
    private let gameView = GameView()
    private let inputHandler = InputHandler()
    
    
    //-----게임 시작 함수-----
    func start() {
        let answer = randomGenerator.makeAnswer()
        
        while true {
            // ===== LV 1. 사용자 입력 받기 =====
            let userInput = inputHandler.getUserInput()
            
            // ===== LV 2. 입력이 올바르지 않다면 반복문 처음으로 =====
            guard inputHandler.isValidInput(userInput) else {
                    gameView.displayInvalidInputMessage()
                    continue
            }
            
            // ===== LV 2. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기 =====
            let (strike, ball) = calculateScore(answer: answer, userInput: userInput)
            
            // ===== LV 2. 결과 확인 =====
            gameView.displayResult(strike: strike, ball: ball)
            
            if strike == 3 {
                gameView.displayCorrectAnswerMessage()
                break
            }
        }
    }
    
    // ===== LV 2. Strike, Ball 구분 함수 =====
    private func calculateScore(answer: [Int], userInput: [Int]) -> (Int, Int) {
        var strike = 0
        var ball = 0
        
        for (index, number) in userInput.enumerated() {
            if answer[index] == number {
                strike += 1
            } else if answer.contains(number) {
                ball += 1
            }
        }
        return (strike, ball)
    }
}
