// 25.03.26.(수)
// 프로그래머스: 가장 먼 노드
// https://school.programmers.co.kr/learn/courses/30/lessons/49189

import Foundation

func solution(_ n:Int, _ edge:[[Int]]) -> Int {
    // ===== 1. 그래프 사용
    var graph = [[Int]](repeating: [], count: n + 1)
    // ===== 2. 그래프 연결(edge <-> graph)
    for i in edge{
        graph[i[0]].append(i[1])
        graph[i[1]].append(i[0])
    }
    
    // ===== 3. 1에서 부터 각 노드의 거리 탐색(BFS)
    var distances = [Int](repeating: -1, count: n + 1) //모든 노드 초기 거리 -1
    var queue = [1] //BFS 탐색 시작 노드 1
    distances[1] = 0
    
    while !queue.isEmpty {
        let current = queue.removeFirst() //큐에서 현재노드 꺼내기
        for neighbor in graph[current] {
            if distances[neighbor] == -1 {
               distances[neighbor] = distances[current] + 1 //미방문 노드 탐색하여 노드 거리 1 증가
                queue.append(neighbor) //큐 추가
            }
        }
    }
    
    // ===== 4. 가장 먼 노드의 총 갯수를 리턴
    let maxNode = distances.max()!
    let resultCount = distances.filter { $0 == maxNode }.count
    
    return resultCount
}
