//
//  ListLembretesTableViewController.swift
//  TodoFireBaseDesafio
//
//  Created by Vitor Ferraz on 28/07/17.
//  Copyright © 2017 Vitor. All rights reserved.
//

import UIKit

class ListLembretesTableViewController: UITableViewController {

  
  //MARK: -  Outlets
  
  //MARK: -  Propriedades
  
  //MARK: -  ViewLifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    if lembreteStore.lembretes.isEmpty{
      firebaseManager.updateList {
        self.tableView.reloadData()
      }
    }

  }
  
  override func viewWillAppear(_ animated: Bool) {
     lembreteStore.orderArray()
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return lembreteStore.lembretes.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LembreteCell", for: indexPath)
    let lembrete = lembreteStore.lembretes[indexPath.row]
    if lembrete.concluida == true{
      //concluida
      let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: lembrete.titulo!)
      attributeString.addAttribute(NSBaselineOffsetAttributeName, value: 0, range: NSMakeRange(0, attributeString.length))
      attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        cell.textLabel?.attributedText = attributeString
    }else{
       cell.textLabel?.attributedText = nil
    }
    
      cell.textLabel?.text = lembrete.titulo
  
    cell.detailTextLabel?.text = lembrete.getData()
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let lembrete = lembreteStore.lembretes[indexPath.row]
    lembreteStore.selectIndex = indexPath.row
    performSegue(withIdentifier: "editLembrete", sender: lembrete)
    
  }

  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    var itemToMove = lembreteStore.lembretes[sourceIndexPath.row]
    lembreteStore.lembretes.remove(at: destinationIndexPath.row)
    lembreteStore.lembretes.insert(itemToMove, at: sourceIndexPath.row)
    
 
    
    

  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete{
      let item = lembreteStore.lembretes[indexPath.row]
      lembreteStore.lembretes.remove(at: indexPath.row)
      firebaseManager.ref.child((item.id)!).child("lembrete").removeValue { (error, ref) in
        if error != nil {
          print("error \(error)")
        }
      }
      tableView.deleteRows(at: [indexPath], with: .automatic)
      tableView.reloadData()
    }
  }
  
  //MARK: -  Métodos
  func addLembreteAlert(){
    //Cria alert
    let alert = UIAlertController(title: "Adicione um novo lembrete", message: "Desafio Todo List", preferredStyle: .alert)
    
    //Texto do alert
    alert.addTextField { (textField) in
      textField.placeholder = "Novo Lembrete"
    }
    
    //pega valor
    alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
      
      let titulo = alert?.textFields![0].text
      if titulo != ""{
        lembreteStore.addLembrete(titulo: titulo!)
        self.tableView.reloadData()
       
      }
      
     

           print("Text field: \(titulo)")
    }))
    //red cancel
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in }
    
    alert.addAction(cancelAction)

    
    // 4. Present the alert.
    self.present(alert, animated: true, completion: nil)
  }
  //MARK: -  Actions

  @IBAction func AddLembrete(_ sender: UIBarButtonItem) {
    
    addLembreteAlert()
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "editLembrete"{
      if let destination = segue.destination as? LembreteViewController{
        if let lembrete = sender as? Lembrete{
          destination.lembrete = lembrete
          
        }
      }
    }
  }
  
  @IBAction func startEdit(_ sender: UIBarButtonItem) {
    self.isEditing = !self.isEditing
  }
  
}
