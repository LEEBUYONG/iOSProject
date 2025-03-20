// ===== LV 4. 객체 지향 설계 (class 상속 구현)
// ----- 요구사항 1. 엔진 커스텀 정의 -----
class Engine: CustomStringConvertible {
    var engineType: String
    
    init(engineType: String) {
        self.engineType = engineType
    }
    
    //CMD 출력을 위한 CustomStringConvertible 프로토콜 추가
    var description: String {
            return "엔진 타입: \(engineType)"
        }
}

// ----- 요구사항 1. class car 설계 -----
class Car: CustomStringConvertible {
    var brand: String
    var model: String
    var carYear: String
    var engine: Engine
    
    var isTurnOn: Bool = false
    
    init(brand: String, model: String, carYear: String, engine: Engine) {
        self.brand = brand
        self.model = model
        self.carYear = carYear
        self.engine = engine
    }
    
    func turnOn() -> String {
        if isTurnOn == false {
            isTurnOn = true
        }
        return "\(model) 자동차 시동이 켜졌습니다"
    }
    
    func turnOff() -> String {
        if isTurnOn == true {
            isTurnOn = false
        }
        return "\(model) 자동차 시동이 꺼졌습니다"
    }
    
    func drive() -> String {
        if isTurnOn == true {
            return "\(model) 자동차가 주행 중입니다"
        } else {
            return "\(model) 자동차 시동부터 켜주세요"
        }
    }
    
    //CMD 출력을 위한 CustomStringConvertible 프로토콜 추가
    var description: String {
            return """
            브랜드: \(brand)
            모델: \(model)
            연식: \(carYear)
            \(engine)
            """
        }
}

// ----- 요구사항 2. ElectricEngine 타입 사용 -----
class ElectricEngine: Engine {
    override init(engineType: String) {
        super.init(engineType: engineType)
    }
}

class ElectricCar: Car {
    init(brand: String, model: String, carYear: String) {
        let electricEngine = ElectricEngine(engineType: "전기차 전용 엔진")
        super.init(brand: brand, model: model, carYear: carYear, engine: electricEngine)
    }
}

// ----- 요구사항 3, 4. HybrideCar, switchEngine(to:) 구현 -----
class HydrogenEngine: Engine {
    override init(engineType: String) {
        super.init(engineType: engineType)
    }
}

class HydrogenCar: Car {
    init(brand: String, model: String, carYear: String) {
        let hydrogenEngine = HydrogenEngine(engineType: "하이브리드 차량 전용 엔진")
        super.init(brand: brand, model: model, carYear: carYear, engine: hydrogenEngine)
    }
    
    func switchEngine(to newEngine: Engine) {
        self.engine = newEngine
    }
    
    override var engine: Engine {
        willSet(newEngine) {
            print("기존 \(engine.engineType)에서 \(newEngine.engineType)으로 교체 중입니다")
        }
        didSet {
            print("엔진이 \(engine.engineType)으로 교체되었습니다")
        }
    }
}

// ----- 실행 코드 -----
func carPlayCode() {
    let car = Car(brand: "bmw", model: "x5", carYear: "2020", engine: Engine(engineType: "디젤 Engine"))
    print(car)
    
    let electricCar = ElectricCar(brand: "tesla", model: "model 3", carYear: "2021")
    print(electricCar)
    
    let hydrogenCar = HydrogenCar(brand: "ford", model: "mustang", carYear: "2022")
    print(hydrogenCar)
    
    hydrogenCar.switchEngine(to: ElectricEngine(engineType: "전기차 전용 엔진"))
    print(hydrogenCar)
}

// ----- 요구사항 5. 상속과 프로토콜 장단점, 차이 서술 -----
/*
    - 상속과 프로토콜 모두 코드 재사용과 확장에 사용되는데 두 개 모두 다형성 지원이 가능하고 사용 시 유지보수성이 향상된다는 장점이 있음
    - 상속: class에서 부모의 속성과 메서드를 자식이 물려받는 방식
        (장점)
        1. 부모 클래스에서 정의된 기능을 그대로 사용 할 수 있어서 코드 재사용성이 좋음
        2. 클래스간 계층 관계로 부모 메서드를 오버라이드하거나 새로운 기능 추가 가능
        3. 프로토콜과 비교하면 상태를 저장할 수 있고, 기본 구현이 있는게 있음
        (단점)
        1. 부모 자식 간의 의존성이 강해지면 강한 결합으로 인해 오히려 유지보수가 어려워지는 단점이 있음
        2. 다형성(같은 이름의 메서드나 객체가 상황에 따라 다르게 동작하는 것)이 가능하지만 단일 상속으로 활용이 어려움
        3. 클래스에서만 활용이 가능하며 구조체나 열거형에서는 사용할 수 없어서 유연성이 부족함
        (활용)
        1. 종속 관계(is-a)를 표현하고 싶을 때 유용 (동물(부모)-> 개, 고양이, 햄스터(자식))
        2. 공통 기능을 공유하는 클래스가 계층 구조에 있을 경우 활용 가능(UI -> UIView 상속 받아 커스텀 뷰 생성)
    - 프로토콜: enum, class, struct에서 특정 기능(메서드, 속성)을 정의하는 청사진 역할
        (장점)
        1. 클래스에 종속되지 않고 구조체와 열거형, 클래스 모두 유연하게 사용 가능
        2. 약한 결합이라 독립적이고 유지보수가 쉬우며, 확정성이 뛰어남
        3. 클래스와 비교해서 다중 채택이 가능해서 다형성이 활용을 극대화할 수 있음
        (단점)
        1. 프로토콜은 기본 구현을 제공하지 않고,프로토콜 자체로는 상태 저장이 불가(저장 프로퍼티 X)
        2. 프로토콜을 채택하면 요구 사항을 반드시 구현해야해서 코드가 길어질 수 있음
        (활용)
        1. 반드시 구현해야하는 기능(can-do)을 사용할 때 우용(Flyable(날 수 있는 능력을 프로토콜로 정의) -> 새, 비행기, 드론)
        2. 다양한 타입을 하나의 프로토콜로 묶어 다형성을 활용할 때
        3. 구조체나 열거형에서도 정의된 내용과 기능을 공유하고 싶을 때
 */
