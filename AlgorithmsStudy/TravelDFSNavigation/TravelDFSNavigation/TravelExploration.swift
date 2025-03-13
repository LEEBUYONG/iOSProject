// ========== 03.13.(목) ==========
// ========== 알고리즘 공부: 여행탐색 DFS ==========

/*
import Foundation

class TravelExploration {
    // ===== 그래프를 2차원 배열로 정의 (인접 리스트) =====
    let graph = [
        [1,2],      //0과 연결된 노드들
        [0,3,4],    //1과 연결된 노드르
        [0,5],      //2...
        [1],        //3...
        [1],        //4...
        [2]         //5...
    ]

    // ===== 방문 여부를 확인(노드별로 방문했는지 체크) =====
    var visited: [Bool]

    //===== 초기화 메서드: visited 배열을 false로 초기화 =====
    init() {
        self.visited = Array(repeating: false, count: graph.count)
    }

    // ===== 깊이 우선 탐색(DFS) 메서드 =====
    func dfs(node: Int) {
        visited[node] = true        //현재 노드를 방문 처리
        print(node)                 //방문한 노드 출력
        
        for next in graph[node] {   //현재 노드와 연결된 노드 순회
            if !visited[next] {     //방문하지 않은 노드라면
                dfs(node: next)     //재귀 호출
            }
        }
    }
}
*/

// ========== 코드스터디 여행경로탐색 (DFS) ==========

/*
주어진 항공권을 모두 이용하여 여행경로를 짜려고 합니다. 항상 "ICN" 공항에서 출발

항공권 정보가 담긴 2차원 배열 tickets가 매개변수로 주어질 때,
방문하는 공항 경로를 배열에 담아 return 하도록 solution 함수를 작성

**제한사항**
1. 모든 공항은 알파벳 대문자 3글자로 이루어집니다.
2. 주어진 공항 수는 3개 이상 10,000개 이하입니다.
3. tickets의 각 행 [a, b]는 a 공항에서 b 공항으로 가는 항공권이 있다는 의미입니다.
4. 주어진 항공권은 모두 사용해야 합니다.
5. 만일 가능한 경로가 2개 이상일 경우 알파벳 순서가 앞서는 경로를 return 합니다.
6. 모든 도시를 방문할 수 없는 경우는 주어지지 않습니다.
 */

import Foundation

//ICN 출발, 모든 항공권 사용, 다중 경로 시 알파벳 순서대로 경로 선택
func solution(_ tickets:[[String]]) -> [String] {
    
    //===== 1. ["ICN", "JFK"]: Dictionar 형태 =====
    var graph = [String: [String]]()
    
    //===== 2. 항공권 딕셔너리 추가(초기화) =====
    for ticket in tickets {
        let (from, to) = (ticket[0] ,ticket[1])
        graph[from, default: []].append(to)
    }
    
    //===== 3. 도착 공항 알파벳 순 정렬(sort 사용) =====
    for startAirport in graph.keys { //.keys로 값 구하기
        graph[startAirport]?.sort()  //정렬
    }
    
    //===== 4. 모든 경로 확인 시 DFS 사용 =====
    var visited = [String]()
    func dfs(_ current: String) {
        while let next = graph[current]?.first {
            graph[current]?.removeFirst()       //항공권 사용
            dfs(next)                           //다음공항이동
        }
        visited.append(current)                 //경로 저장
    }
    
    //===== 5. ICN 출발 및조건이 안맞으면 되돌아가야함 =====
    dfs("ICN")
    return visited.reversed() //경로 역순 반환
}
