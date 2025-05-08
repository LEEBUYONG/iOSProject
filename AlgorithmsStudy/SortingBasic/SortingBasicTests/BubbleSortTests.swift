
import Testing

@Suite("BubbleSort")
struct BubbleSortTests {

    @Test func bubbleSort() {
        var array = [8, 4, 6, 2, 1, 1, 10, 7, 8]
        let sorted = array.sorted()
        
        // TODO:
        for _ in array.indices { //i 썼는데 사용하지 않아서 _로 바꿈
            for j in 0..<array.count - 1 {
                if array[j] < array[j + 1] {
                    array.swapAt(j, j + 1)
                }
            }
        }
        #expect(array == sorted)
    }
    
    @Test func bubbleSortOptimized() {
        var array = [8, 4, 6, 2, 1, 1, 10, 7, 8]
        let sorted = array.sorted()
        
        // TODO:
        for i in array.indices {
            for j in 0..<array.count - 1 - i { //이미 정렬된 부분을 제거 하기 위해 - i (외부루프 i 활용) 사용
                if array[j] < array[j + 1] {
                    array.swapAt(j, j + 1)
                }
            }
        }
        #expect(array == sorted)
    }
}
