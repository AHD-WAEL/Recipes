//
//  ModelClasses.swift
//  Recipes
//
//  Created by Ahmed on 26/05/2023.
//

import Foundation

struct Response: Decodable {
    var count: Int
    var results: [Result]
}

struct Result:Decodable{
    let id:Int
    let name: String
    let thumbnail_url: String
    let credits: [Brand]
    let original_video_url: String?
    let video_url: String?
    let num_servings: Int?
    let instructions: [Instruction]?
    let sections: [Section]?
    let yields:String?
}

struct Instruction: Decodable {
    var appliance: String?
    var end_time: Int
    var temperature: Int?
    var id:Int
    var position: Int
    let display_text: String
    let start_time: Int
}


struct Ingredient: Decodable {
    var created_at: Int
    var display_plural: String
    var id: Int
    var display_singular: String
    var updated_at: Int
    var name: String
}

struct Section: Decodable {
    var components: [Component]
    var name: String?
    var position: Int
}

struct Component: Decodable {
    var id:Int
    var position: Int
    var measurements: [Measurement]
    var raw_text:String
    var extra_comment: String
    var ingredient: Ingredient
}

struct Measurement: Decodable {
    let id: Int
    let unit: Unit
    let quantity: String
}

struct Unit: Decodable {
    var system: String
    var name: String
    var display_plural: String
    var display_singular:String
    var abbreviation: String
}

struct Brand: Decodable {
    let image_url: String?
    let name: String
    let id: Int?
    let slug: String?
    let type: String?
}
