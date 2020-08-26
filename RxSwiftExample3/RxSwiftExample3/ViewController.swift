//
//  ViewController.swift
//  RxSwiftExample3
//
//  Created by Andrew Han on 2020/08/18.
//  Copyright © 2020 escapeanaemia. All rights reserved.
//

import UIKit
import Moya
import Moya_ModelMapper
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    var provider : MoyaProvider<Github>!
    var issueTrackerModel : IssueTrackerModel!
    
    var latestRepositoryName:Observable<String>{
        return searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }

    
    func setupRx(){
        provider = MoyaProvider<Github>()
        
        issueTrackerModel = IssueTrackerModel(provider: provider, repositoryName: latestRepositoryName)
        issueTrackerModel.trackIssues()
            .bind(to: tableView.rx.items){ tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "issueCell", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = item.title
                
                return cell
                
        }
        .disposed(by: self.disposeBag)
        
        
        tableView.rx.itemSelected
            .subscribe(onNext:{ IndexPath in
                if self.searchBar.isFirstResponder == true{
                    self.view.endEditing(true)
                }
            }).disposed(by: disposeBag)
    }

}

