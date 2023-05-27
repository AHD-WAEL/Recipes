//
//  ApiHandler.swift
//  Recipes
//
//  Created by Ahmed on 26/05/2023.
//

import Foundation
import Alamofire

protocol ApiClientProtocol{
    func getRecipesForACategory(category:String,completionHandler:@escaping(Response?)->Void)
}
class ApiClient:ApiClientProtocol{
    func getRecipesForACategory(category:String,completionHandler:@escaping(Response?)->Void){
        let url = "https://tasty.p.rapidapi.com/recipes/list?"
        let parameters: Parameters = [
            "from": "0",
            "size":"20",
            "tags":"\(category)",
        ]
        let headers:HTTPHeaders = [
            "X-RapidAPI-Key": "608e33d92emshadaed143ae17241p18c449jsnc4587664b78a",
            "X-RapidAPI-Host": "tasty.p.rapidapi.com"
        ]
        AF.request(url,parameters: parameters , headers: headers).response{response in
            switch response.result {
            case .success(let data):
                do{
                    let result = try JSONDecoder().decode(Response.self, from: data!)
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
