//
//  Lembrete.swift
//  TodoFireBaseDesafio
//
//  Created by Vitor Ferraz on 28/07/17.
//  Copyright © 2017 Vitor. All rights reserved.
//

import UIKit
import Firebase

class Lembrete{
  var id:String?
  var titulo:String?
  var date:Date?
  var concluida:Bool?
  
   convenience init(titulo:String) {
     self.init()
    self.id =  UUID().uuidString
    self.titulo = titulo
    self.date = Date()
    self.concluida = false
    
  }
  init() {
    
  }
  
     convenience init(titulo:String,id:String,data:String,concluida:Bool) {
    self.init()
    self.id =  id
    self.titulo = titulo
    self.date = stringToDate(dateString: data)
    self.concluida = concluida
      
    
    
  }
  
  
  
  func getData()->String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let dateString = dateFormatter.string(from:self.date!)
    
    return dateString
  }
  
  func stringToDate(dateString:String)->Date{
    let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
    let DateArray = dateString.components(separatedBy: "/")
    let components = NSDateComponents()
    components.year = Int(DateArray[2])!
    components.month = Int(DateArray[1])!
    components.day = Int(DateArray[0])! + 1
    let date = calendar?.date(from: components as DateComponents)
    return date!
  }

}
