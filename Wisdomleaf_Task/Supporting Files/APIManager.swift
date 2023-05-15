//
//  APIManager.swift
//  Wisdomleaf_Task
//
//  Created by $umit on 15/05/23.
//

import Foundation
import UIKit
import Alamofire


class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

// MARK: - GET/POST API method

func callAPI(apiname: String,
             params: [String:Any]?,
             viewController : UIViewController,
             success _success:  @escaping ([[String: Any]])-> Void) {
    
    if !Connectivity.isConnectedToInternet {
        hideActivityIndicator()
        showAlertMessage(vc: viewController, title: "No internet connection!", message: nil, actionTitle: "Ok", handler: nil)
        return
    }
    
    let urlString = APIMethods.baseUrl + apiname
    print ("API Url :- \(urlString)")
    
    var used_params = [String: Any]()
    if let params = params{
        used_params = params
    }
    let jsonData = try? JSONSerialization.data(withJSONObject: used_params, options: .prettyPrinted)
    if let jsonString = String(data: jsonData!, encoding: .utf8){
        print ("Parameters:- \(jsonString)")
    }
    
    let manager = Alamofire.Session.default
    manager.session.configuration.timeoutIntervalForRequest = 120
    manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    URLCache.shared.removeAllCachedResponses()
    manager.request(
        URL(string: urlString)!,
        method: used_params.isEmpty ? .get : .post,
        parameters: used_params)
        .validate()
        .responseJSON {response in
            switch response.result {
            case let .success(result):
                print("Response:- \(result)")
                guard let jsonResult = result as? [[String: Any]] else { return }
                _success(jsonResult)
            case let .failure(error):
                print("Error description is: \(error.localizedDescription)")
                hideActivityIndicator()
                showAlertMessage(vc: viewController, title: "Error!", message: error.localizedDescription, actionTitle: "Ok", handler: nil)
            }
        }
}
