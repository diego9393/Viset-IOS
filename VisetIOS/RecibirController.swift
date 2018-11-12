//
//  RecibirController.swift
//  VisetIOS
//
//  Created by Diego on 27/1/17.
//  Copyright © 2017 Diego. All rights reserved.
//

import Foundation
import UIKit


class RecibirController: UIViewController {

    @IBOutlet weak var Recibir: UIButton!
    @IBOutlet weak var Token: UITextField!
    @IBOutlet weak var Texto: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0);
        Token.layer.borderWidth = 0.5;
        Token.layer.borderColor = borderColor.cgColor;
        Token.layer.cornerRadius = 5.0;
        
        Texto.layer.borderWidth = 0.5;
        Texto.layer.borderColor = borderColor.cgColor;
        Texto.layer.cornerRadius = 5.0;
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RecibirTexto(_ sender: Any) {
        let token = Token.text;
        if let url = URL(string: "https://viset.vivarsoft.es/archivos/" + token! + ".txt") {
            do {
                let contents = try String(contentsOf: url)
                let textoFinal = contents.replacingOccurrences(of: "<br>", with: "\n", options: .literal, range: nil)
                Texto.text = textoFinal;
            } catch {
                Texto.text = "Token incorrecto";
            }
        } else {
            Texto.text = "Error";
        }
    }
}

