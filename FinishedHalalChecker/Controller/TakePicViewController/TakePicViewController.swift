//
//  TakePicViewController.swift
//  FinishedHalalChecker
//
//  Created by Mac on 12/01/23.
//

import UIKit
import SnapKit
import Vision

class TakePicViewController: UIViewController {
    
    let textLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        view.backgroundColor = .white
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        //picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func initView() {
        
        view.addSubview(textLabel)
        textLabel.textAlignment = .center
        textLabel.font = .boldSystemFont(ofSize: 20)
        textLabel.text = "This is the words whitch starts with letter A/a:"
        textLabel.numberOfLines = .max
        textLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.2)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
        }
    }
    
    //MARK: - recognizeText -
    private func recognizeText(image: UIImage?) {
        
        guard let cgImage = image?.cgImage else {
            fatalError("Could not get cgImage!")
        }
        
        let hendler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                return
            }
            
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: ", ")
            
            DispatchQueue.main.async {
                self?.textLabel.text = text
                self?.getTheData(text: text)
            }
        }
        
        do {
            try hendler.perform([request])
        }
        catch {
            textLabel.text = "\(error)"
        }
        
    }
    
    //MARK: - Get the data from text -
    func getTheData( text: String ) {
        
        let mainArr = text.components(separatedBy: " ")
        let firstIndexArr = mainArr.map({ String($0.prefix(1))})
        
        var result = [String]()
        
        var cout = 0
        
        for firstIndex in firstIndexArr {
            
            if firstIndex == "A" || firstIndex == "a"{
                
                result.append(mainArr[cout])
            }
            
            cout += 1
        }
        print(result)
        textLabel.text = "This is the words whitch starts with letter A/a: \(result)"
    }
}

extension TakePicViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: - Get the image from camera -
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        else {
            return
        }
        
        recognizeText(image: image)
    }
}

