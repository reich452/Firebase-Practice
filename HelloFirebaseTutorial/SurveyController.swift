//
//  SurveyController.swift
//  HelloFirebaseTutorial
//
//  Created by Nick Reichard on 4/30/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

class SurveyController {
    
    static let baseUrl = URL(string: "https://emojirepeat.firebaseio.com/")
    
    static func fetchResponses(completion: @escaping ([Survey]) -> Void) {
        guard let unwrappedURL = baseUrl else { completion([]); return }
        let url = unwrappedURL.appendingPathComponent("json")
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: nil, body: nil) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            // Returns a json object 
            guard let data = data,
                let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [String:Any]], let emojisDictionary = jsonDictionary["emojis"] as? [String:[String:String]] else { completion([]); return }
            
            let response = emojisDictionary.flatMap({Survey(dictionary: $0.value, identifier: $0.key )})
                completion(response)
        }
    }
    
    static func putResponseIntoAPI(name: String, favoriteEmoji: String) {
        // Create a surve object, Create an instance of survey 
        let survey = Survey(name: name, favoriteEmoji: favoriteEmoji)
        // Get the url
        guard let unwrappedURL = baseUrl else { return }
        let url = unwrappedURL.appendingPathComponent("emojis").appendingPathComponent(survey.uid.uuidString).appendingPathExtension("json")
        NetworkController.performRequest(for: url, httpMethod: .Put, urlParameters: nil, body: survey.jsonData) { (data, error) in
            // All of this is for the developer 
            
            guard let data = data, let responseDataString = String(data: data, encoding: .utf8)
                else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if responseDataString.contains("error") {
                print("Error found in responseDataString. Error: \(String(describing: error?.localizedDescription))")
            } else {
                print("Successfull put data endpoint \nRespons: \(responseDataString)")
            }
        }
    }
}
