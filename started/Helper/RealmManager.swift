//
//  RealmManager.swift
//  Helper
//
//  Created by Gabriel Pino on 9/26/21.
//

import UIKit
import RealmSwift

class RealmManager {
    
    static let `default` = RealmManager()
    
    var realm: Realm!

    private init(){
        do{
            realm = try Realm()
        }
        catch{
            print("error on creating Realm")
        }
    }
    
}
