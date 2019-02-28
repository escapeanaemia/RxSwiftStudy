//
//  example.swift
//  RxSwiftExample1
//
//  Created by 한상준 on 27/02/2019.
//  Copyright © 2019 한상준. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class example {
    
    func 함수1 (){
        //출처:https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Examples.md
        let a = BehaviorRelay(value: 1) //Observable<Int> 생성, a = 1
        let b = BehaviorRelay(value: 2) //Observable<Int> 생성, b = 2
        
        //연속된 두 변수를 결합 , a 와 b를 + 기호를 이용해서
        let c = Observable.combineLatest(a, b) { $0 + $1 }
            .filter { $0 >= 0 }  //만약 a + b >= 0 이면 참, 'a + b'가 map operator로 패스됨
            .map{ "\($0) is positive" } // maps `a + b` to "\(a + b) is positive"
        //
        
        c.subscribe(onNext: { print($0) })
        a.accept(4)
        b.accept(-8)
    }
    
    func 함수2(){
        
    }
    func 함수3(){
        
    }
}
