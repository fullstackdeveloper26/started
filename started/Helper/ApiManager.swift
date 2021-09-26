//
//  ApiManager.swift
//  started
//
//  Created by Gabriel Pino on 9/26/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

enum HttpResponseCode : Int{
    case ok = 200
    case redirect = 300
    case badrequest = 400
    case unauthorized = 401
}

let baseURL = "http://jsonplaceholder.typicode.com"
let photoURL = "/photos"

class ApiManager: NSObject {
    static var sharedInstance : ApiManager = {
        var instance = ApiManager()
        return instance
    }()

    // MARK - Response Blocks
    typealias DefaultResponse       = (JSON?, Error?, Int) -> Void

    // MARK - REQUEST METHOD
    // Send request with URL Encoding
    func requestWC(method:HTTPMethod, endPoint:String, params:[String:Any]?, headers :HTTPHeaders? = nil, encoding: ParameterEncoding = URLEncoding.default, complete: @escaping DefaultResponse) -> Void {
        
        let url = "\(baseURL)\(endPoint)"
        
        Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: headers).responseJSON { (response:DataResponse<Any>) in
            print("**** Response from server : url = \(url) **** \n")
            
            let statusCode = response.response?.statusCode ?? HttpResponseCode.unauthorized.rawValue
            print("Http request respone code = \(statusCode)")
            
            switch response.result{
            case .success(let data):
                let result = JSON(data)
                complete(result, nil, statusCode)
                break
            case .failure(let error):
                complete(nil, error, statusCode)
                break
            }
        }
    }

    // Mark - Get Photos
    func getPhotos(params : [String : Any]?, complete:@escaping([STImage]?, String?) -> Void) {
        ApiManager.sharedInstance.requestWC(method: .get, endPoint: photoURL, params: params, headers: ["Content-Type": "application/json"]) { (response, error, responseCode) in
            if let json = response {
                if let data = json.array {
                    let photos = data.map({return STImage($0)})
                    complete(photos, nil)
                }
                else{
                    var message = "Occur error on Server"
                    if let error = json["error"].array, error.count > 0 {
                        message = error[0]["message"].string ?? message
                    }
                    complete(nil, message)
                }
            }
            else{
                complete(nil, error?.localizedDescription)
            }
        }
    }

}
