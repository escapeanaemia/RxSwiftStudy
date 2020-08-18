//
//  ViewController.swift
//  RxSwiftExmaple2
//
//  Created by Andrew Han on 2020/08/18.
//  Copyright © 2020 escapeanaemia. All rights reserved.
//

import UIKit
import ChameleonFramework
import RxSwift
import RxCocoa
class ViewController: UIViewController {

    var circleView: UIView!
    var circleViewModel :CircleViewModel!
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }

    func setup(){
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = .green
        view.addSubview(circleView)
        
        circleViewModel = CircleViewModel()
        circleView.rx.observe(CGPoint.self, "center")
            .bind(to: self.circleViewModel.centerVariable)
            .disposed(by: disposeBag)
        
        circleViewModel.backgroundColorObservable.subscribe(onNext: { [weak self] backgroundColor in
            UIView.animate(withDuration: 0.1) {
                self?.circleView.backgroundColor = backgroundColor
                let viewBackgroundColor = UIColor(complementaryFlatColorOf: backgroundColor)
                if viewBackgroundColor != backgroundColor{
                    self?.view.backgroundColor = viewBackgroundColor
                }
            }
            }).disposed(by: disposeBag)
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        circleView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    @objc func circleMoved(_ recognizer : UIPanGestureRecognizer){
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1) {
            self.circleView.center = location
        }
    }
    
}

