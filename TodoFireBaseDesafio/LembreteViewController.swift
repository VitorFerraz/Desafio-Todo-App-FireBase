//
//  LembreteViewController.swift
//  
//
//  Created by Vitor Ferraz on 28/07/17.
//
//

import UIKit

class LembreteViewController: UIViewController {

  
  //MARK: -  Outlets
  
  @IBOutlet weak var titulo: UITextField!
  @IBOutlet weak var status: UISwitch!
  
  
  //MARK: -  Propriedades
  var lembrete:Lembrete?
  
  //MARK: -  ViewLifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    update()
    print(lembreteStore.selectIndex)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //MARK: -  Métodos
  func update(){
    titulo.text = lembrete!.titulo
    status.setOn(lembrete!.concluida!, animated: true)
   

    
  }
  //MARK: -  Actions

  @IBAction func saveItem(_ sender: UIButton) {
    
    lembrete?.concluida = status.isOn
    lembrete?.titulo = titulo.text
    
    lembreteStore.lembretes.remove(at: lembreteStore.selectIndex)
   lembreteStore.lembretes.insert(lembrete!, at: lembreteStore.selectIndex)
    
    firebaseManager.ref.child((lembrete?.id)!).child("lembrete").child("titulo").setValue(lembrete?.titulo)
    
    firebaseManager.ref.child((lembrete?.id)!).child("lembrete").child("concluida").setValue(lembrete?.concluida)


    
    print("atuali")
     navigationController!.popViewController(animated: true)
  }
}
