//
//  ViewController.swift
//  RxSwiftExample1
//
//  Created by Andrew Han on 2020/08/18.
//  Copyright © 2020 escapeanaemia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    var shownCities = [String]()
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin","Praga"]
    let disposeBag = DisposeBag() // 뷰가 할당 해제될 때 놓아줄 수 있는 일회용품의 가방
    @IBOutlet weak var cityTableView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.dataSource = self
        
        //MARK:-
        // unowned -> 미소유 참조, 강력순환 참조를 벗어나기 위해 사용, nil이면 크래쉬가 생김
        self.searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
            .filter{ !$0.isEmpty }
            .subscribe(onNext: { [unowned self] query in
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) }
                self.cityTableView.reloadData()
            })
        .disposed(by: disposeBag)
    }


}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for:indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    
}
