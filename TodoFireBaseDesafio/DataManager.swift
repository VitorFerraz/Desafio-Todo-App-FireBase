//
//  DataManager.swift
//  
//
//  Created by Vitor Ferraz on 28/07/17.
//
//

import UIKit
import Firebase
import Alamofire

typealias DownloadComplete = () -> ()


class DataManager{
  let ref = Database.database().reference(withPath: "todo-list")
  var handle:DatabaseHandle?

  
  
  func addItem(lembrete:Lembrete){
    let r = firebaseManager.ref.child(lembrete.id!).child("lembrete")
    r.child("id").setValue(lembrete.id)
    
    r.child("titulo").setValue(lembrete.titulo)
    
    r.child("data").setValue(lembrete.getData())
    
    r.child("concluida").setValue(lembrete.concluida)
     lembreteStore.orderArray()

  }
  
  
  func updateItem(lembrete:Lembrete){
    let r = firebaseManager.ref.childByAutoId().child("lembrete")
    //ref.child("yourKey").child("yourKey").updateChildValues(["cardAmount": yourNewCardAmount])
    

    r.child("id").setValue(lembrete.id)
    
    
    r.child("titulo").setValue(lembrete.titulo)
    
    r.child("data").setValue(lembrete.getData())
    
    r.child("concluida").setValue(lembrete.concluida)
    
  }
  
  func updateList(completed: @escaping DownloadComplete){
    handle = ref.observe(.childAdded, with: { (snapshot) in
      let dataChange = snapshot.value as? [String:AnyObject]
      if let lembrete = dataChange!["lembrete"]{
        print(lembrete)
        if let titulo = lembrete["titulo"] as? String,let id = lembrete["id"] as? String, let data = lembrete["data"] as? String, let concluida = lembrete["concluida"]{
          print("tastando fire")
          print(titulo)
          print(id)
          print(concluida!)
          print(data)
          let l = Lembrete(titulo: titulo, id: id, data: data, concluida: concluida as! Bool)
          dump(l)
          lembreteStore.lembretes.append(l)
          lembreteStore.orderArray()
          print("adicionou")
          
        completed()
        }
      }
      
    })
  }
}
