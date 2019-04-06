#RxSwift 시작하기 

## 비동기 프로그래밍에 대한 이해

하나의 앱에서 노래를 들으면서 또 다른 노래를 다운받을 때, 터치 이벤트에 따른 에니메이션이 발생할 때 등 비동기 프로그래밍은 여러 상황에서 사용되고 있습니다. 각각의 작업이 async 하게 이루어지는 것 입니다.  
비동기 프로그래밍을 하기 위한 방법으로 Cocoa, UIKit에서 제공하는 Asynchronous API를 사용할 수 있습니다. 따라서 아래와 같은 방법으로 비동기 프로그래밍을 할 수 있습니다.

### Grand Central Dispatch (GCD)
멀티코어 프로세스를 가능하게 하며 다중 처리 최적화를 위한 기술
### NotificationCenter
NotificationCenter는 관찰하고 싶은 객체를 NotificationCenter에 등록 그리고 관찰하며 이벤트가 발생할 때 마다 코드를 실행합니다.

### Closures
### Delegate pattern



우리는 Cocoa, UIKit에서 제공하는 방법이 아닌 RxSwift(Reactive Programming)을 활용한 비동기 프로그래밍을 학습할 것 입니다.

## 동기 코드(Synchronous) 
RxSwift를 활용한 비동기 프로그래밍을 시작하기에 앞서 Synchronous에 대한 간단한 예제를 통해 동기 코드에 대한 이해를 해보겠습니다.

```
var str = "Hello"
for row in str{
    print(row)
    str = "andrew"
}
print(str)
```

출력결과

```
H
e
l
l
o
andrew
```
위 문자열은 반복문이 실행되는 동안 동기적으로 작동하여 기존의 값이 변하지 않습니다. 기존 문자열 'Hello'가 다 출력된 이후 str의 값이 바뀝니다. 

## Reactive Programming
리엑티브 프로그래밍은 Microsoft에서 비동기 문제를 해결하고 실시간(real-time) 응용 프로그램을 개발하기 위해 만든 개념입니다.  
Java, JS, .Net등 여러 언어에서 사용되며 Swift역시 사용가능합니다.  
지금부터는 Microsoft에서 만든 Reactive Programming concept을 ReactiveX라고 부르겠습니다. 

### ReactiveX
**_An API for asynchronous programming
with observable streams_**

저는 위 문장이 ReactiveX의 특징을 가장 잘 나타내는 문장이라고 생각합니다.  
한글로 직역을 해보면 **_관찰 가능한 스트림을 이용한 비동기 프로그래밍 API_**로 해석됩니다.  
여기서 중요한 점은 바로  **관찰 가능한(Observable)** 무언가입니다.  
~~관찰 가능한 무언가라니... 제가 설명하는 실력이 많이 부족합니다 ㅠㅠ~~

## Observer와 Observables
ReactiveX에서 중요하게 사용되는 개념으로 Observer와 Observable이 있습니다.  
옵저버(Observer)는 Observable을 구독하면서 Observable에서 어떠한 객체가 나오면 옵저버 안에 있는 관찰자를 통해 Observable에서 객체가 나왔다는 알림을 받을 수 있습니다.  
**_"Observable은 객체를 배출한다"_**  
**_"Observer는 Observer내부의 관찰자를 통해 배출된 객체에 대한 알림을 받는다."_**

ObervableType 프로토콜에서는 아래의 세가지 유형의 이벤트만 배출할 수 있습니다.  
**onNext** :Observable에서 새로운 항목을 배출할 때 마다 호출되는 메서드입니다. 배출되는 항목을 파라미터로 받습니다.    
**onError** : 오류가 발생할 경우 오류를 알리기 위해 호출되는 메서드입니다. `onError`메서드가 한번 호출되면 더이상 `onNext`나 `onCompleted`는 더이상 호출되지 않습니다.   
**onCompleted** : 마지막 `onNext`가 호출된 이후 이 메소드가 호출됩니다.

## Observable

## Observable Lifecycle


리엑터 패턴
