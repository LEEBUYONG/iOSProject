// 25.03.24.(월)
// 프로그래머스 이중우선순위큐
// https://school.programmers.co.kr/learn/courses/30/lessons/42628?language=swift

import Foundation

func solution(_ operations:[String]) -> [Int] {
    var queue: [Int] = []
    
    // ===== 1. 명령어 배열 순회 처리 =====
    operations.forEach {
        let parts = $0.split(separator: " ")
        // ===== 2. 큐 삽입 삭제 명령 =====
        if parts[0] == "I" {
            queue.append(Int(parts[1])!)
            queue.sort()
        } else if !queue.isEmpty { // ===== 3. 최대값과 최소값 삭제=====
            parts[1] == "1" ? queue.removeLast() : queue.removeFirst()
        }
    }
    
    // ===== 5. 큐가 비어있으면 [0, 0], 아니면 [최대값, 최소값] 반환
    return queue.isEmpty ? [0, 0] : [queue.last!, queue.first!]
}
