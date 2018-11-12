//
//  ViewController.swift
//  VisetIOS
//
//  Created by Diego on 26/1/17.
//  Copyright © 2017 Diego. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {

    @IBOutlet weak var Enviar: UIButton!
    @IBOutlet weak var Texto: UITextView!
    @IBOutlet weak var Datos: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0);
        Texto.layer.borderWidth = 0.5;
        Texto.layer.borderColor = borderColor.cgColor;
        Texto.layer.cornerRadius = 5.0;
        
        Datos.layer.borderWidth = 0.5;
        Datos.layer.borderColor = borderColor.cgColor;
        Datos.layer.cornerRadius = 5.0;    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EnviarTexto(_ sender: Any) {
        let texto = Texto.text;
        let textoFinal = texto?.replacingOccurrences(of: " ", with: "%20");
        if let url = URL(string: "https://viset.vivarsoft.es/viset-mobile.php?msg=" + textoFinal!) {
            do {
                let contents = try String(contentsOf: url)
                let textoForm = contents.replacingOccurrences(of: "<br>", with: "\n", options: .literal, range: nil)
                Datos.text = textoForm;
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
       
    }
    
}

