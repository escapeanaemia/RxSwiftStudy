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
}s

struct IssueTrackerModel {
    let provider: MoyaProvider<Github>
    let repositoryName: Observable<String>
    func trackIssues() -> Observable<[Issue]>{
        
    }
    internal func findIssues(repository: Repository) -> Observable<[Issue]?>{
        return self.provider
            .request(Github.issues(repositoryFullName: repository.fullName), completion: {_ in })
        .debug()
            .mapArrayOptional(Issue.self)
    }
    internal func findRepository(name: String) -> Observable<Repository?> {

    }
}
