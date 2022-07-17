# Musinsa_Pre_Assignment
MUSINSA 모바일 개발 그룹 모바일 개발자 채용 사전과제

---

## Installation

> git clone https://github.com/SangHwi-Back/Musinsa_Pre_Assignment.git

프로젝트를 다운받게 되면 xcconfig 파일이 참조만 되어있을 뿐 실제 존재하지 않은 상태입니다.

일부러 키 값이나, 구체적인 URL 등을 따로 관리하기 위해 DEBUG, Release 환경에 사용할 xcconfig 파일을 생성/적용 하였으며,   
해당 파일은 따로 전달드릴 예정입니다.

---

## README 활용 방안

이번 전형은 이력서를 제외하고 진행하게 되었습니다.

과제를 어떠한 방식으로 진행하였는지 적을 수 있는 방법을 고민해 보았을 때,   
제출하는 메일을 이용할 수도 있겠지만 GitHub의 README 라면 공유가 좀 더 편할 것 같습니다.

아래와 같이 README 에는 제가 주목한 점을 적어 놓았으며, 특이한 작업의 경우   
왜 이런 방향을 취하였는지 적어놓았습니다.

---

## Version Control을 사용하는 이유

개발자의 입장에서는 코드를 효과적으로 수정하고 복구하기 위해서입니다.

지원자의 입장에서는 프로젝트 파일과 압축파일을 받는 걸 부담스러워 하시는 분들도 있다고 들어서 (안에 무슨 파일이 있을지 모르기 때문)
GitHub에서 프로젝트를 다운로드 받으실 수 있도록 하였습니다.

## Trunk-Based 선정 이유

주로 Git-Flow를 많이 사용하였지만, 이번에는 사전과제이므로 Trunk-Based를 사용하였습니다.

개인 프로젝트나 팀 내에서의 협업만 생각하면 Trunk-Based 도 충분히 협업이 가능한 방식이라고 생각합니다.

하지만, 실제 업무에서는 한 Repository에 서버/웹 개발팀의 프로젝트가 들어갈 가능성도 존재하기 때문에 Git-Flow에 익숙해지려 노력하고 있었습니다.

어쨋든 결과적으로 현재 이 Repository는 Trunk-Based 방식을 채택하였습니다.

## No-Library

이번 과제에서는 라이브러리를 사용하지 않습니다. Alamofire 를 고려해보았지만 결국 채택하지 않기로 결정하였습니다.

Alamofire를 사용해본 결과 Alamofire 내의 DataStreamPublisher 등 Combine 기능을 사용할 경우 간단하게 비동기 네트워크 처리 로직을 생성할 수 있지만,
여러 확장된 기능이 있다면 아직까지는 Alamofire에 URLRequest 클래스로 API 요청을 하는 것과 URLSession 을 이용한 API 요청에 큰 차이가 없다는 결론을 내렸습니다.

아직 Alamofire를 제대로 사용할 수 없다면 차라리 외부 라이브러리가 없는 Native한 프로젝트로 생성하기로 결정한 것입니다.
새로운 개발자가 프로젝트를 세팅하는 등의 부담을 줄여줄 수 있을 것이라고 생각하였습니다.

더불어, 원래는 Snapkit을 이용하여 Code-Based UI 를 애용하고 있지만 Native 프로젝트로 진행하기로 하였으므로 Storyboard 를 사용하려 합니다.

---

## 구현에 관하여

### MVC 

구조적으로 심화하는 것 보다는 MVC의 View 를 얼마나 객체지향적으로 구현하는냐가 중요하다고 판단하였습니다.


### UICollectionView

UICollectionView, UITableView, UIScrollView 를 고민하였습니다.

- UIScrollView 는 한번에 모든 뷰를 메모리에 올려야 하기 떄문에 메모리 부담이 높을거라고 생각했습니다.
  - 하지만, 작업하는 과정에서 든 생각은 완벽히 부드러운 화면을 구현하기 위해서는 메모리 부담을 감수하는 방향도 좋았을 것이라고 생각합니다.
- UITableView 도 선택할 수 있었지만, GridLayout 을 보여주기에는 더 좋은 대안이 있을 것이라고 생각했습니다.
- 그렇기에, UICollectionView를 선택하였습니다.


### Custom UICollectionViewDataSource

- DataSource와 관련된 여러 모델들이 있기 떄문에 DataSource를 분리하면 관리가 용이할 것이라고 생각하였습니다.
- 몇 개의 셀을 보여주어야 하는지, 셀의 순서는 어떻게 되는지 판단하는 InterviewListModel을 만들었습니다.

### Delegate Pattern

DataSource 와 Header/Footer 셀은 델리게이트 패턴을 이용하여 서로 소통합니다. 재사용이 자주 되는 Header/Footer는 직접적으로 DataSource를 참조하는 것이 직관적으로 느껴졌기 때문입니다.

NotificationCenter 를 이용한 Observer Pattern 은 어느 클래스로든지 Notification을 보낼 수 있기 때문에 직관적이지 않다고 생각했습니다.

### Observer Pattern

현재 프로젝트에는 DataSource와 ViewController 만이 사용하지만, Footer/Header/Cell 어디서든 추가 모델이 개입하거나, 비동기 방식 등 여러 예외적인 상황을 커버하기 위해 도입하였습니다.

## 구조에 관하여

<img width="1000" alt="Musinsa_Architecture" src="https://user-images.githubusercontent.com/65931336/179383840-ad7ecd84-3991-4577-9c0e-94d6a126a112.png">

### Model의 역할

애플리케이션의 입장에서 아주 적지만 구체적인 역할을 담당합니다.

List JSON 을 받아오고,   
JSON Decoding 을 하고,   
뷰에 셀을 어떤 방식으로 얼마나 보여줘야 할지 계산하는 것은   
각각의 모델 클래스로 정의될 수 있는 것입니다.

### View의 역할

View는 Entity와 Interface Builder를 참고하여 자신이 어떻게 보여야할지 정의합니다.   
ViewController 나 DataSource 등이 Entity를 전달하면, 이를 이용해 UI를 구성하는 것은 View의 역할입니다.

### ViewController의 역할

DataSource 중개, View 중개, UICollectionView reload 등을 담당합니다.   
특별히 GridLayout도 담당하게 되었는데, 다른 클래스로 나누는 것보단 뷰와 깊은 연관이 있는 ViewController가 담당하도록 하였습니다.

### UseCase의 역할

개인적으로 UseCase 란 **사용자가 원하는 여러 작업을 정의하는 객체**로 생각하고 있습니다.

그렇기 때문에 UseCase 는 대부분 구체적인 역할을 정의하는 Model을 조합하여 자신의 역할을 수행하게 됩니다.   
굉장히 많은 모델 클래스를 초기화하여 메모리에 올리기 때문에, 아래의 Disposable 타입을 정의하게 되었습니다.

## Disposable

### Disposable 객체를 도입한 이유

  * 부트캠프를 진행하는 와중에 모델 클래스와 유즈케이스에서 메모리 사용과 해제를 자동화하는 주제를 리뷰 받던 과정에서 RxSwift 를 참고해보라는 리뷰가 생각 났습니다.
  * 현재 프로젝트에서는 ViewController가 UseCaseContainer 에서 UseCase 를 받아와서 특정 작업을 수행합니다.
  * 이 과정에서 여러 구체타입의 Model을 초기화 하는데 이로 인한 메모리 점유율을 낮추기 위해 Disposables, DisposeBag 을 직접 구현해 보았습니다.
 
### Code Review

  * 각 UseCase 클래스 중 구체타입이 된 클래스들은 UseCaseResponsible 의 서브클래스 입니다.
  * UseCaseResponsible은 Disposable 의 서브클래스입니다. 이 타입들은 UseCaseContainer 등에 있는 disposeBag에 저장할 수 있습니다.
  * DisposeBag과 Disposable의 구현은 RxSwift 를 참조하여 구현하였습니다.
  * 현재 사용되는 RequestInterviewUseCase 유즈 케이스는 deinit될 경우 자신이 사용한 모델의 메모리를 모두 해제(.dispose()) 합니다.

---

## 아쉬운 점.

1. View가 자신을 구성해야 하는 역할이다보니 Model의 역할을 일부 가져왔습니다. 구조적으로 정확한 것이 아니라는 생각이 듭니다.
    - 각 뷰가 커스텀 클래스가 되었다면 뷰 컨트롤러와 지속적으로 소통하게 되고, 여러 모델을 붙일 수 있었을 것 같다는 아쉬움이 듭니다.
    - 제한시간 안에 진행하기 위해 기능구현을 먼저 하기로 하였습니다.
2. Disposable 클래스는 많이 활용해보지 못했습니다.
    - 테스트를 통해 구체적으로 Disposable 에 문제가 있는지 확인해보려 하였지만, RxSwift 의 코드는 제 입장에서는 많이 어려웠습니다.
    - 또한, 많은 이미지를 표시해야 하는 이번 과제에서는 메모리 해제(UIImageView의 image가 보여지기엔 스크롤이 너무 많이 내려갔을 경우 image를 nil 처리하여 자동 메모리 해제)를 하기 위해 Disposable을 활용하는 것을 기대하였지만, 그 부분까지 진행하지는 못했습니다.
    - Disposable이 필요한 부분인지, 단순히 `imageView.image = nil`만 해도 무관한지 확인이 필요하였으며 View Programming 에 많은 관심이 생겼습니다.

## 이번 과제를 구현하면서 처음 시도해 본 것

언제나 발전하는 개발자가 되기 위해 항상 새로운 시도를 해보려 노력하고 있습니다.

- xcconfig : 민감 정보를 숨기기 위해 도입하였습니다.
- Disposable : 효과적인 메모리 점유율 개선을 위해 도입하였습니다.