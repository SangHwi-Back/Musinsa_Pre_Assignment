# Musinsa_Pre_Assignment
MUSINSA 모바일 개발 그룹 모바일 개발자 채용 사전과제

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
