//
//  UserModel.swift
//  Gestion Users
//
//  Created by basafou on 8/25/20.
//  Copyright © 2020 basafou. All rights reserved.
//

import Foundation
import UIKit


class UserModel {
    
    func get_all_users(completion: @escaping ([User]) -> ()){
        var UserList = [User]()

        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        let session = URLSession(configuration: configuration)
        
        let urlstring = "https://jsonplaceholder.typicode.com/users/"
                
        let url_confirmation = URL(string: urlstring)
        
        let task = session.dataTask(with: url_confirmation!) {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                return
            }
            

            if let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as String? {
              //print(result)
              if let data = result.data(using: .utf8) {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        for dictionary in (json as? [[String:AnyObject]])!{
                            
                            let id = dictionary["id"] as! Int
                            let name = dictionary["name"] as! String
                            let username = dictionary["username"] as! String
                            let email = dictionary["email"] as! String

                            let user = User(id: id, name: name, username: username, email: email)
                                                                                        
                            UserList.append(user)
                        }
                        DispatchQueue.main.async {
                            completion(UserList)
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
