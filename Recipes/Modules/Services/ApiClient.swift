//
//  ApiHandler.swift
//  Recipes
//
//  Created by Ahmed on 26/05/2023.
//

import Foundation
import Alamofire

protocol ApiClientProtocol{
    func getData<T:Decodable>(urlDetails: ApiModel, completionHandler: @escaping(T?)->Void)
}
class ApiClient:ApiClientProtocol{
    
    func getData<T:Decodable>(urlDetails: ApiModel, completionHandler: @escaping(T?) -> Void){
        let url = urlDetails.url
        let parameters = urlDetails.parameters
        let headers = urlDetails.headers
        AF.request(url,parameters: parameters , headers: headers).response{response in
            switch response.result {
            case .success(let data):
                do{
                    let result = try JSONDecoder().decode(T.self, from: data!)
                    completionHandler(result)
                }catch let error{
                    completionHandler(nil)
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
