//
//  GithubModel.swift
//  RxSwiftExample3
//
//  Created by Andrew Han on 2020/08/18.
//  Copyright © 2020 escapeanaemia. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift
import RxCocoa

struct Repository: Mappable {
    let identifier: Int
    let language : String
    let name: String
    let fullName:String
    
    init(map: Mapper) throws{
        try identifier = map.from("id")
        try language = map.from("language")
        try name = map.from("name")
        try fullName = map.from("fullName")
    }
}

struct Issue: Mappable {
    let identifier: Int
    let number: Int
    let title:String
    let body: String
    init(map:Mapper) throws{
        try identifier = map.from("id")
        try number = map.from("number")
        try title = map.from("title")
        try body = map.from("body")
    }
}

struct IssueTrackerModel {
    let provider: MoyaProvider<Github>
    let repositoryName: Observable<String>
    func trackIssues() -> Observable<[Issue]>{
        let a = repositoryName.observeOn(MainScheduler.instance)
            .flatMapLatest { (name) -> Observable<Repository?> in
                print("Name: \(name)")
                return self.findRepository(name: name)
                
        }
        .flatMapLatest { repository -> Observable<[Issue]?> in
            guard let repository = repository else { return Observable.just(nil) }

            print("Repository: \(repository.fullName)")
            return self.findIssues(repository: repository)
        }
        .replaceNilWith([])
        
        return a
    }
    
    internal func findIssues(repository: Repository) -> Observable<[Issue]?>{
        let a = self.provider.rx.request(Github.issues(repositoryFullName: repository.fullName))
//        let b = a.debug().mapOptional(to: [Issue])
        let b = a.debug().mapOptional(to: [Issue].self).asObservable()
        
        return b
    }
    internal func findRepository(name: String) -> Observable<Repository?>{
        let a = self.provider.rx.request(Github.repo(fullName: name)).debug().mapOptional(to: Repository.self).asObservable()
        
        return a
    }
    
    /*
    internal func findIssues(repository: Repository) -> Observable<[Issue]?>{
        return self.provider.rx
            .request(Github.issues(repositoryFullName: repository.fullName))
            .debug()
            .mapArrayOptional(Issue.self)
    }
    internal func findRepository(name: String) -> Observable<Repository?> {

        return self.provider.rx.request(Github.repo(fullName: name)).debug().mapO

    }*/
    
}
