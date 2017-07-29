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
  
  func updateItem(lembrete:Lembrete,index:Int){
     lembretes.remove(at: index)
     lembretes.insert(lembrete, at: index)
    firebaseManager.updateItem(lembrete: lembrete)
     orderArray()

  }

  

  func orderArray(){
    let  arrayDate = lembretes.sorted{ $0.date! < $1.date! }
    let arrayConcluida = arrayDate.sorted{!$0.concluida! && $1.concluida!}
    lembretes.removeAll()
    lembretes = arrayConcluida
    print(lembretes)
  }
  
  

  
  
}

