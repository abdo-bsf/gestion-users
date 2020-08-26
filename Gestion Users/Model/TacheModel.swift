//
//  TacheModel.swift
//  Gestion Users
//
//  Created by basafou on 8/25/20.
//  Copyright © 2020 basafou. All rights reserved.
//

import Foundation

class TacheModel {
    
    func get_taches_by_user(id_user:Int,completion: @escaping ([Tache]) -> ()){
        var ListTache = [Tache]()
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        let session = URLSession(configuration: configuration)
        
        let urlstring:String = "https://jsonplaceholder.typicode.com/todos?userId=\(id_user)"
        let url_confirmation = URL(string: urlstring)
            
            let task = session.dataTask(with: url_confirmation!) {
                (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    return
                }
                
                guard let data = data else{
                    print(error.debugDescription)
                    return
                }
                
                
            if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? {
                if let data = result.data(using: .utf8) {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    for dictionary in (json as? [[String:AnyObject]])!{
        
                        let id = dictionary["id"] as! Int
                        let title = dictionary["title"] as! String
                        let completed = dictionary["completed"] as! Bool
                        let tache = Tache(id: id, title: title, completed: completed)
                                                                                        
                        ListTache.append(tache)
                    }
                    DispatchQueue.main.async {
                            completion(ListTache)
                    }
                    }catch{
                        print(error.localizedDescription)
                    }
                    }
                }
                

            }
            task.resume()
        }
    }

