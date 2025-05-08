
import Testing

@Suite("Swap")
struct SwapTests {

    @Test func swap() {
        var a = 2
        var b = 3
        
        // TODO:
        var temp = a
        a = b
        b = temp
        
        #expect(a == 3)
        #expect(b == 2)
    }
    
    @Test func swapWithArrayTest() {
        var array = [2, 3]
        
        // TODO:
        let temp = array[0]
        array[0] = array[1]
        array[1] = temp
        
        #expect(array == [3, 2])
    }
    
    @Test func swapWithArrayTest2() {
        var array = [2, 3]
        swap(&array, at: 0, with: 1)
        #expect(array == [3, 2])
    }
    
    private func swap(_ array: inout Array<Int>, at i: Int, with j: Int) {
        // TODO:
        let temp = array[i]
        array[i] = array[j]
        array[j] = temp
    }
}
