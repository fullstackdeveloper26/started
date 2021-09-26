//
//  STImage.swift
//  started
//
//  Created by Gabriel Pino on 9/26/21.
//
import UIKit
import SwiftyJSON
import RealmSwift

class STImage: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var albumId = 0
    @objc dynamic var title : String?
    @objc dynamic var url : String?
    @objc dynamic var thumbnailUrl : String?
    
    required override init() {
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    init(_ item : JSON){
        self.id                     = item["id"].intValue
        self.albumId                = item["albumId"].intValue
        self.title                  = item["title"].stringValue
        self.url                    = item["url"].stringValue
        self.thumbnailUrl           = item["thumbnailUrl"].stringValue
        
        super.init()

        try! RealmManager.default.realm.write {
            RealmManager.default.realm.add(self, update: .modified)
        }
    }
    
    class func getPhotos() -> Results<STImage> {
        return RealmManager.default.realm.objects(STImage.self)
    }
    
}

