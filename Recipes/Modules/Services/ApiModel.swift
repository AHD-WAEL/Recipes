//
//  ApiModel.swift
//  Recipes
//
//  Created by Ahmed on 27/05/2023.
//

import Foundation
import Alamofire

struct ApiModel{
    var url:String
    var parameters:Parameters
    var headers:HTTPHeaders = [
                    "X-RapidAPI-Key": "608e33d92emshadaed143ae17241p18c449jsnc4587664b78a",
                    "X-RapidAPI-Host": "tasty.p.rapidapi.com"
                ]
    var httpMethod:ApiMethod
}

enum ApiMethod: String {
    case Get    = "GET"
    case post   = "POST"
    case Delete = "DELETE"
}
