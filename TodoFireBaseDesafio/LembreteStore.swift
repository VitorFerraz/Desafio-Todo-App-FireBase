//
//  LembreteStore.swift
//  TodoFireBaseDesafio
//
//  Created by Vitor Ferraz on 28/07/17.
//  Copyright © 2017 Vitor. All rights reserved.
//

import UIKit

class LembreteStore{
  var lembretes:[Lembrete] = []
  var selectIndex = 0
  
  func addLembrete(titulo:String){
    
     let lembrete = Lembrete(titulo: titulo)
    lembretes.append(lembrete)
    firebaseManager.addItem(lembrete: lembrete)
    orderArray()

  }
  
  
  

  func orderArray(){
    let  array = lembretes.sorted{ $0.date! < $1.date! }
    lembretes.removeAll()
    lembretes = array
    print(lembretes)
  }
  
  
}
