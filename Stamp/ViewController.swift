//
//  ViewController.swift
//  Stamp
//
//  Created by 早川雅人 on 2019/02/02.
//  Copyright © 2019 早川雅人. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var imageNameArray:[String] = ["hana","hoshi","onpu","shitumon"]
    var imageIndex:Int = 0
    @IBOutlet weak var haikeiImageView: UIImageView!
    var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func selectedFirst(_ sender: Any) {
        imageIndex = 1
    }
    @IBAction func selectedSecond(_ sender: Any) {
        imageIndex = 2
    }
    @IBAction func selectedThird(_ sender: Any) {
        imageIndex = 3
    }
    @IBAction func selectedFourth(_ sender: Any) {
        imageIndex = 4
    }
    @IBAction func back(){
        self.imageView.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let location:CGPoint = touch.location(in: self.view)
        
        if imageIndex != 0{
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            let image:UIImage = UIImage(named: imageNameArray[imageIndex - 1])!
            imageView.image = image
            imageView.center = CGPoint(x: location.x, y: location.y)
            self.view.addSubview(imageView)
        }
    }
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch:UITouch = touches.first!
//        let maex = touch.previousLocation(in: self.view).x
//        let maey = touch.previousLocation(in: self.view).y
//        let atox = touch.location(in: self.view).x
//        let atoy = touch.location(in: self.view).y
//
//        let dx = atox - maex
//        let dy = atoy - maey
//
//        _ = touch.view as? UIImage
//
//
//    }
    @IBAction func selectBackground(_ sender: Any) {
        let imagePickerController:UIImagePickerController = UIImagePickerController()
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        haikeiImageView.image = image
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func save(_ sender: Any) {
        //範囲の指定
        let rect:CGRect = CGRect(x: 0, y: 30, width: 320, height: 380)
        //範囲をimagecontextに変更,bitmap-based graphicsを作成
        UIGraphicsBeginImageContext(rect.size)
        //画像作成作業，imagecontextを計算している
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        //計算したimagecontextをimageに変更，,bitmap-basedをもとにimageを作成
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        //imagecontextを終了，bitmap-basedを破棄
        UIGraphicsEndImageContext()

        UIImageWriteToSavedPhotosAlbum(capture!, nil, nil, nil)
    }
    
}

