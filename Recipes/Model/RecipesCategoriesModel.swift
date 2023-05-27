//
//  ModelClasses.swift
//  Recipes
//
//  Created by Ahmed on 26/05/2023.
//

import Foundation

struct Response: Decodable {
    var count: Int?
    var results: [Result]?
}

struct Result:Decodable{
    let id:Int?
    let name: String?
    let thumbnailUrl: String?
    let credits: [Brand]?
    let originalVideoUrl: String?
    let videoUrl: String?
    let numServings: Int?
    let instructions: [Instruction]?
    let sections: [Section]?
    let yields: String?
    
    enum CodingKeys: String, CodingKey {
        case originalVideoUrl = "original_video_url"
        case videoUrl = "video_url"
        case numServings = "num_servings"
        case thumbnailUrl = "thumbnail_url"
        case id, name, credits, instructions, sections, yields
    }
}

struct Instruction: Decodable {
    var appliance: String?
    var endTime: Int?
    var temperature: Int?
    var id: Int?
    var position: Int?
    let displayText: String?
    let startTime: Int?
    
    enum CodingKeys: String, CodingKey {
        case startTime = "start_time"
        case endTime = "end_time"
        case displayText = "display_text"
        case appliance, temperature, id, position
    }
}

struct Ingredient: Decodable {
    var createdAt: Int?
    var displayPlural: String?
    var id: Int?
    var displaySingular: String?
    var updatedAt: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case displaySingular = "display_singular"
        case updatedAt = "updated_at"
        case displayPlural = "display_plural"
        case createdAt = "created_at"
        case name, id
    }
}

struct Section: Decodable {
    var components: [Component]?
    var name: String?
    var position: Int?
}

struct Component: Decodable {
    var id:Int?
    var position: Int?
    var measurements: [Measurement]?
    var rawText:String?
    var extraComment: String?
    var ingredient: Ingredient?
    
    enum CodingKeys: String, CodingKey {
        case rawText = "raw_text"
        case extraComment = "extra_comment"
        case id, position, measurements, ingredient
    }
}

struct Measurement: Decodable {
    let id: Int?
    let unit: Unit?
    let quantity: String?
}

struct Unit: Decodable {
    var system: String?
    var name: String?
    var displayPlural: String?
    var displaySingular:String?
    var abbreviation: String?
    
    enum CodingKeys: String, CodingKey {
        case displaySingular = "display_singular"
        case displayPlural = "display_plural"
        case name, system, abbreviation
    }
}

struct Brand: Decodable {
    let imageUrl: String?
    let name: String?
    let id: Int?
    let slug: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case name, slug, id, type
    }
}
