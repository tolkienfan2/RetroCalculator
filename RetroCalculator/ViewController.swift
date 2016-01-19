//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Minni K Ang on 2016-01-16.
//  Copyright © 2016 CreativeIce. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	enum Operation: String {
		case Divide = "/"
		case Multiply = "*"
		case Subtract = "-"
		case Add = "+"
		case Empty = ""
	}

	@IBOutlet weak var outputLabel: UILabel!
	
	var buttonSound: AVAudioPlayer!
	var runningNumber = ""
	var leftValStr = ""
	var rightValStr = ""
	var currentOperation: Operation = Operation.Empty
	var result: String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
		
		let soundURL = NSURL(fileURLWithPath: path!)
		
		do {
			try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
			buttonSound.prepareToPlay()
		} catch let error as NSError {
			print(error.debugDescription)
		}
	}

	@IBAction func numberPressed(button: UIButton!) {
		playSound()
		runningNumber += "\(button.tag)"
		outputLabel.text = runningNumber
	}
	
	@IBAction func onDividePressed(sender: AnyObject) {
		processOperation(Operation.Divide)
	}

	@IBAction func onMultiplyPressed(sender: AnyObject) {
		processOperation(Operation.Multiply)
	}

	@IBAction func onSubtractPressed(sender: AnyObject) {
		processOperation(Operation.Subtract)
	}

	@IBAction func onAddPressed(sender: AnyObject) {
		processOperation(Operation.Add)
	}

	@IBAction func onEqualPressed(sender: AnyObject) {

		if currentOperation != Operation.Empty {
		processOperation(currentOperation)
		} else {
			return
		}
	}
	
	@IBAction func onClearPressed(sender: AnyObject)
	{
		playSound()
		runningNumber = ""
		leftValStr = ""
		rightValStr = ""
		currentOperation = Operation.Empty
		outputLabel.text = runningNumber
	}
	
	func processOperation(operation: Operation) {
		playSound()
		
		if currentOperation != Operation.Empty {

			if runningNumber != "" {
				
				rightValStr = runningNumber
				runningNumber = ""
				
				if leftValStr == "" {
					leftValStr = "0"
				}
				
				if currentOperation == Operation.Multiply {
					result = "\(Double(leftValStr)! * Double(rightValStr)!)"
					
				} else if currentOperation == Operation.Divide {
					result = "\(Double(leftValStr)! / Double(rightValStr)!)"
					
				} else if currentOperation == Operation.Add {
					result = "\(Double(leftValStr)! + Double(rightValStr)!)"
					
				} else if currentOperation == Operation.Subtract {
					result = "\(Double(leftValStr)! - Double(rightValStr)!)"

				}
				
				leftValStr = result
				outputLabel.text = result
					
			}
			
			currentOperation = operation
			
		} else {
				
		leftValStr = runningNumber
		runningNumber = ""
		currentOperation = operation
			
		}
	}
	
	func playSound() {
		buttonSound.volume = 0.10
		if buttonSound.playing {
			buttonSound.stop()
		}
		buttonSound.play()
	}
}
