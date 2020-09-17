//
//  ViewController.swift
//  FoodTracker
//
//  Created by Мария Григорьева on 04.08.2020.
//  Copyright © 2020 Мария Григорьева. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    var meal:Meal?
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var mealNameText: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var ratingControl: RatingControll!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let noNilMeal = meal {
            navigationItem.title = noNilMeal.name
            mealNameText.text = noNilMeal.name
            photoImageView.image = noNilMeal.photo
            ratingControl.rating = noNilMeal.rating
        }
        
        mealNameText.delegate = self
        updateSaveButtonState()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    //MARK: Actions
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
       super.prepare(for: segue, sender: sender)
       
       // Configure the destination view controller only when the save button is pressed.
       guard let button = sender as? UIBarButtonItem, button === saveButton else {
           os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
           return
       }
       
       let name = mealNameText.text ?? ""
       let photo = photoImageView.image
       let rating = ratingControl.rating
       
       // Set the meal to be passed to MealTableViewController after the unwind segue.
       meal = Meal(name: name, photo: photo, rating: rating)
   }
  
    @IBAction func didTapCancelButton(_ sender: Any) {
        if self.presentingViewController != nil{
            dismiss(animated: true, completion: nil)
        } else if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = mealNameText.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        print("Image was tapped!")
        mealNameText.resignFirstResponder() //ушла клавиатура, после тапа по фотке
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else {
            fatalError("Something went wrong")
        }
        photoImageView.image = pickedImage
        dismiss(animated: true, completion: nil)
    }
    
    
}

