//
//  GameViewController.swift
//  GameCollector
//
//  Created by Luis Medinelli on 2/27/17.
//  Copyright © 2017 iBeacon Solutions. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var game : Game? = nil
    @IBOutlet weak var addUpdateButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if game != nil {
            print("For editing game")
            gameImageView.image = UIImage(data: game!.image as! Data)
            titleTextField.text = game!.title
            addUpdateButton.setTitle("Update", for: .normal)
        }else{
            deleteButton.isHidden = true
        }
        
    }

    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        gameImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func addTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if game != nil {
            game!.title = titleTextField.text
            game!.image = UIImagePNGRepresentation(gameImageView.image!) as NSData?
        }else{
            let game = Game(context: context)
            
            game.title = titleTextField.text
            game.image = UIImagePNGRepresentation(gameImageView.image!) as NSData?
        }
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteGame(_ sender: Any) {
        
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(game!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
}
