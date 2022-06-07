import UIKit

class MainViewController: UIViewController
{
    
    @IBOutlet weak var displayResultLabel: UILabel!
    var stillTyping = false
    var firstNumber = 0.0
    var secondNumber = 0.0
    var operationSign = ""
    var dotDouble = false
    var outNumber: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        
        set {
            displayResultLabel.text = "\(newValue)"
            stillTyping = false
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton)
    {
        let number = sender.currentTitle!
        if (Int(number) != 0) || dotDouble
        {
            if stillTyping {
                if (displayResultLabel.text?.count)! < 20 {
                    displayResultLabel.text! += number
                }
            }
            else {
                displayResultLabel.text = number
                stillTyping = true
            }
        }
        else if Int(displayResultLabel.text!) != 0 && !dotDouble
        {
            if stillTyping {
                if (displayResultLabel.text?.count)! < 20 {
                    displayResultLabel.text! += number
                }
            }
            else {
                displayResultLabel.text = number
                stillTyping = true
            }
        }
    }
    
    @IBAction func arithmeticExpression(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstNumber = Double(displayResultLabel.text!)!
        stillTyping = false
        dotDouble = false
    }
    
    func result(operation: (Double, Double) -> Double) {
        outNumber = operation(firstNumber, secondNumber)
        stillTyping = false
    }
    
    @IBAction func resultButton(_ sender: UIButton) {
        if stillTyping {
            secondNumber = outNumber
        }
        dotDouble = false
        switch operationSign {
        case "+":
            result{$0 + $1}
        case "-":
            result{$0 - $1}
        case "×":
            result{$0 * $1}
        case "÷":
            if secondNumber == 0 {
                displayResultLabel.text = "ERROR"
                stillTyping = false
            }
            else {
                result{$0 / $1}
            }
        default: break
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        firstNumber = 0
        secondNumber = 0
        outNumber = 0
        displayResultLabel.text = "0"
        stillTyping = false
        operationSign = ""
        dotDouble = false
    }
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
        if outNumber != 0
        {
            outNumber = -outNumber
        }
    }
    
    @IBAction func persentageButton(_ sender: UIButton) {
        if firstNumber == 0 {
            outNumber = outNumber / 100
        }
        else {
            secondNumber = firstNumber * outNumber / 100
        }
    }
    
    @IBAction func sqrtButton(_ sender: UIButton) {
        if (outNumber > 0)
        {
            outNumber = sqrt(outNumber)
        }
        else
        {
            displayResultLabel.text = "ERROR"
            stillTyping = false
        }
    }
    
    @IBAction func dotButton(_ sender: UIButton) {
        if stillTyping && !dotDouble {
            displayResultLabel.text! += "."
            dotDouble = true
        }
        else if !stillTyping && !dotDouble {
            displayResultLabel.text! = "0."
        }
    }
}
