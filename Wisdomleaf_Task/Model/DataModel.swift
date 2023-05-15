//
//  DataModel.swift
//  Wisdomleaf_Task
//
//  Created by $umit on 15/05/23.
//

import Foundation


//struct WelcomeElement: Codable {
//    let id, author: String?
//    let width, height: Int?
//    let url, downloadURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, author, width, height, url
//        case downloadURL = "download_url"
//    }
//}


struct DataModel{
    
    public let id,author: String?
   
    public let url,downloadURL: String?
    
    public init? (json:[String:Any]){
        id = json["id"] as? String ?? ""
        author = json["author"] as? String ?? ""
        downloadURL = json["download_url"] as? String ?? ""
        url = json["url"] as? String ?? ""
    }
    
    static func array(jsonObject: [[String:Any]])->[DataModel]{
        var dataArray: [DataModel] = []
        jsonObject.forEach { json in
            guard let infoDict = DataModel(json: json) else { return }
            dataArray.append(infoDict)
        }
        return dataArray
    }
}
