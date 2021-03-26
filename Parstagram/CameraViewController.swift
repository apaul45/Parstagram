//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Ayon Paul on 3/18/21.
//

import UIKit
import AlamofireImage
import Parse
//In order to launch the camera, have to make the class inherit the UIImagePickerControllerDelegate
class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Can create our own schema to use in our server--creating a table tht contains information in a dictionary
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "posts")
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        let imageData = image.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        post["image"] = file
        post.saveInBackground(){
            (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            }else{
                print("error!")
            }
        }
        
    }
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //By embedding a tap gesture recognizer inside the image, the camera can be triggered to take a picture (runs the method below) when the picture is tapped
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        //Brings the user to a different screen where they can edit their pictures, and the delegate above allows for the program to call back the picker once the picture was taken to be used on a function that makes it viewable in the camera view controller
        picker.allowsEditing = true
        //If on a phone, this statement would allow the app to check if the camera is available for use, and if so, will then allow the user to use the camera
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        //If on a simulator or even on a phone, can also choose the sourceType of picker to be a photo library--ie the user clicks on "no" when prompted to use camera
        else{
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    //This function helps return the image from the library by getting it out a dictionary, and resizes it to account for binary size
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagev = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = imagev.af.imageAspectScaled(toFill: size)
        image.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
