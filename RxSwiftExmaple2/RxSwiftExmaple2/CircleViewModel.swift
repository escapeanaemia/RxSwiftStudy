//
//  CircleViewModel.swift
//  
//
//  Created by Andrew Han on 2020/08/18.
//

import Foundation
import ChameleonFramework
import RxSwift
import RxCocoa

class CircleViewModel{
    var centerVariable = Variable<CGPoint?>(.zero)
    var backgroundColorObservable : Observable<UIColor>!
    
    init(){
        setup()
    }
    
    func setup(){
        backgroundColorObservable = centerVariable.asObservable()
            .map{ center in
                guard let center = center else { return UIColor.flatten(.black)()}
                let red : CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255.0)) / 255.0
                let green : CGFloat = 0.0
                let blue : CGFloat = 0.0
                
                return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1))()
        }
        
    }
}
