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
