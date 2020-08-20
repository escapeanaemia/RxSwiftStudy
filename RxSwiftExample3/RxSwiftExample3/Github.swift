//
//  Github.swift
//  
//
//  Created by Andrew Han on 2020/08/18.
//

import Foundation
import Moya

enum Github{
    case userProfile(username:String)
    case repos(username:String)
    case repo(fullName: String)
    case issues(repositoryFullName: String)
}

private extension String{
    var URLEscapedString : String{
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

extension Github: TargetType{
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL { return URL(string: "https://api.github.com")!}
    var path:String{
        switch self {
        case .repos(let name):
            return "/users/\(name.URLEscapedString)/repos"
        case .userProfile(let name):
            return "/users/\(name.URLEscapedString)"
        case .repo(let name):
            return "/repos/\(name)"
        case .issues(let repositoryName):
            return "/repos/\(repositoryName)/issues"
        }
    }
    
    var method: Moya.Method{
        return .get
    }
    var parameters: [String : Any]? {
        return nil
    }
    var sampleData: Data {
        switch self {
        case .repos(_):
            return "}".data(using: .utf8)!
        case .userProfile(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: .utf8)!
        case .repo(_):
            return "{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}".data(using: .utf8)!
        case .issues(_):
            return "{\"id\": 132942471, \"number\": 405, \"title\": \"Updates example with fix to String extension by changing to Optional\", \"body\": \"Fix it pls.\"}".data(using: .utf8)!
        }
    }
    var task: Task {
        return .requestPlain
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
