# Baseball Game Project

1. 이 프로젝트는 숫자 야구 게임을 구현한 Swift 콘솔 애플리케이션
2. 사용자는 3자리 숫자를 입력하여 컴퓨터가 생성한 정답과 비교하며 스트라이크와 볼을 맞추는 게임

---

## 프로젝트 폴더 및 파일 구조

<pre>
BaseballGameProject/
├── GameController.swift       // 게임의 핵심 로직을 관리하는 컨트롤러
├── RandomGenerator.swift      // 정답 숫자를 랜덤으로 생성하는 유틸리티
├── InputHandler.swift         // 사용자 입력값을 처리하고 검증하는 구조체
├── GameView.swift             // 사용자에게 메시지를 출력하는 뷰
└── main.swift                 // 프로그램의 시작점 (entry point)
</pre>

---

## 주요 파일 설명

### 1. **GameController.swift**
- 게임의 전반적인 흐름을 관리하는 핵심 로직
- 사용자 입력값을 받아 정답과 비교하고, 결과를 출력하며 게임을 종료

### 2. **RandomGenerator.swift**
- 1부터 9까지의 숫자 중에서 중복되지 않는 3자리 숫자를 랜덤으로 생성
- 게임의 정답 역할

### 3. **InputHandler.swift**
- 사용자로부터 입력값을 받고, 그 값을 검증하는 로직이 포함
- 입력값이 3자리 숫자인지, 중복이 없는지 확인

### 4. **GameView.swift**
- 사용자에게 메시지를 출력하는 역할
- 예를 들어, "숫자를 입력하세요" 또는 "정답입니다!" 같은 메시지를 출력

### 5. **main.swift**
- `GameController`를 호출하여 게임을 실행

---

##  실행 방법

1. Swift로 실행: swift main.swift
2. 숫자야구 즐기기
