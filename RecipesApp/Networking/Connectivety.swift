//
//  Connectivety.swift
//  RecipesApp
//
//  Created by Khalid hassan on 8/10/21.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    
}
