//
//  Extension.swift
//  TodoFireBaseDesafio
//
//  Created by Vitor Ferraz on 28/07/17.
//  Copyright © 2017 Vitor. All rights reserved.
//

//
//  FIRDataObject.swift
//
//  Created by Callam Poynter on 24/06/2016.
//

import Firebase
import UIKit

class FIRDataObject: NSObject {
  
  let snapshot: DataSnapshot
  var key: String { return snapshot.key }
  var ref: DatabaseReference { return snapshot.ref }
  
  required init(snapshot: DataSnapshot) {
    
    self.snapshot = snapshot
    
    super.init()
    
    for child in snapshot.children.allObjects as? [DataSnapshot] ?? [] {
      if responds(to: Selector(child.key)) {
        setValue(child.value, forKey: child.key)
      }
    }
  }
}

protocol FIRDatabaseReferenceable {
  var ref: DatabaseReference { get }
}

extension FIRDatabaseReferenceable {
  var ref: DatabaseReference {
    return Database.database().reference()
  }
  
  

}


