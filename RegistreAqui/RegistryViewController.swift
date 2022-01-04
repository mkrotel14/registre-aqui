//
//  RegistryViewController.swift
//  RegistreAqui
//
//  Created by Gian Carlo Mantuan on 03/01/22.
//

import UIKit

class RegistryViewController: UIViewController {
    
    @IBOutlet weak var imageViewRegistry: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var textViewRegistryDescription: UITextView!
    
    var registry: Registry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let registryFormViewController = segue.destination as? RegistryFormViewController {
            registryFormViewController.registry = registry
        }
    }
    
    func prepareScreen() {
        if let registry = registry {
            if let image = registry.image {
                imageViewRegistry.image = UIImage(data: image)
            }
            labelTitle.text = registry.title
            labelAddress.text = "Address \(registry.address ?? "not Found")"
            textViewRegistryDescription.text = registry.registryDescription
        }
    }
    
}

