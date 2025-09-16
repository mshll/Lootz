//
//  GPService.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import Foundation
import Moya
internal import Alamofire

enum GPService {
    case getGiveaways
    case getGiveaway(id: Int)
}

extension GPService: TargetType {
    var baseURL: URL { URL(string: "https://www.gamerpower.com/api")! }
    
    var path: String {
        switch self {
        case .getGiveaways:
            return "/giveaways"
        case .getGiveaway(let id):
            return "/giveaway?id=\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
