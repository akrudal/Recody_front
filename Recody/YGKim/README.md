#  DI & VIP 추상화

# DependencyContainer
 종속성 주입을 위한 클래스 
 
# UIViewController+
  1) protocol CommonVC 
    공통적으로 VIP 패턴을 적용할 ViewController 용 procotol
  2) Method Swizzling
  UIViewController life Cycle을 트래킹 하기위함. 앱 최초시작시 실행해야됨.
  보통 didFinishLaunchingWithOptions()에서 호출한다.
  https://babbab2.tistory.com/76
  고급 라이브러리들은 이 기술을 사용함으로 개념적으로 알고 넘어가야함!
   
# SimpleRouter
  RoutingEvent 내에 타입정의가 필요
  Navigationtype -> ViewController 별로 Case 처리 필요
  Segmenttype -> Segment 별로 Case 처리 필요
  DataPassingType -> Next UIViewController 에 상속 bind() 함수를 통해 받은 데이터를 캐스트 해서 사용 (무조건 구조체로 던져야함)
  
  RoutingLogicType -> Enum 상속 구현필수
  NavigationType -> RoutingLogicType 하위 Enum 상속 구현필수 
  SegmentType -> RoutingLogicType 하위 Enum 상속 구현필수

# WorkerType
   1) WorkerDelegate.completeWork()
   서버통신 및 단순 작업을 완료함
   
   2) WorkerType.recept(Int)
   개별 작업코드를 Int로 저장 
   설명 : 이 Int 값은 1)에서 해당 작업을 케이스 처리하기위해 필요
   
   3) WorkerType.send(param,header)
   Api 호출후 1)로 결과를 반환 
   
   4)SimpleWoker
   WorkerType의 샘플입니다. 아직 사용하지마세요!
   
   5)WorkResult
   result : 작업의 결과 혹은 통신의 성공 실패 여부 Bool값
   obj : api 통신후 리스폰 받는 JSON으로 Dictionary<String,Any>? 원시형태로 1차저장
   
   5-1)WorkResult.fetch(DefaultDataModelType.Type) 
   DefaultDataModelType을 다운 캐스팅 하기위한 제네릭함수
   func completeWork(orderNumber: Int, reulst: WorkResult) {
        let d = reulst.fetch(ChildDataModel.self)
   }
   
   추가 - 아직 Api 통신 외의 케이스 외 작업케이스가 있는경우는 알려주세요!
# DefaultDataModel
  데이터 모델의 최상위 객체로 class타입
  init 함수시 Dictionary<String,Any> 형태로 변환된 JSON데이터를 dic 변수에 저장 후 
  build() 함수를 호출함.
  따라서 DefaultDataModel 상속받은 모델클래스 내에 Build() 함수내에서 개별적인 
  변수할당을 하면됨. DefaultDataModel.swift를 직접 보고 판단해주세요~  
   
# InteractorType
 작업중
 1) View에서 모든 Action 이벤트는 InteractorType의 Just() 함수를 호출하도록 할예정입니다.
  
# BusinessLogicType
 작업중
 이 부분은 화면별로 별도 상속(Enum)으로 정의 하도록 개발할예정입니다. ( 통합하고 싶은데 너무 커져서 안될것같습니다. )

# BasePresenter
  미구현
# UseCaseType
  미구현