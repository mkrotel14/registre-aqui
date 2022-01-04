//
//  RegistryFormViewController.swift
//  RegistreAqui
//
//  Created by Gian Carlo Mantuan on 03/01/22.
//

import UIKit

class RegistryFormViewController: UIViewController {

    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var imageViewRegistry: UIImageView!
    @IBOutlet weak var buttonAddEdit: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var registry: Registry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let registry = registry {
            title = "Edit Registry"
            textFieldTitle.text = registry.title
            textFieldAddress.text = registry.address
            textViewDescription.text = registry.registryDescription
            if let image = registry.image {
                imageViewRegistry.image = UIImage(data: image)
            }
            buttonAddEdit.setTitle("Edit Registry", for: .normal)
        }
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        
        let keyboardFrameHeight = keyboardFrame.size.height - view.safeAreaInsets.bottom
        
        scrollView.contentInset.bottom = keyboardFrameHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrameHeight
    }
    
    @objc func keyboardWillHide() {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func selectRegistryPhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select registry photo", message: "Pick an action to select the photo", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Library", style: .default, handler: { _ in
            self.selectPhoto(sourceType: .photoLibrary)
        })
        let albumAction = UIAlertAction(title: "Saved Album", style: .default, handler: { _ in
            self.selectPhoto(sourceType: .savedPhotosAlbum)
        })
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.selectPhoto(sourceType: .camera)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(libraryAction)
        alert.addAction(albumAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func selectPhoto(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        let date = Date()
        
        if registry == nil {
            registry = Registry(context: context)
        }
        
        registry?.title = textFieldTitle.text
        registry?.address = textFieldAddress.text
        registry?.registryDescription = textViewDescription.text
        registry?.image = imageViewRegistry.image?.jpegData(compressionQuality: 0.9)
        registry?.createdAt = date
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
    }
}

extension RegistryFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageViewRegistry.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
    }
}
