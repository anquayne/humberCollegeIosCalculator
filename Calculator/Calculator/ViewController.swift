//
//  ViewController.swift
//  Calculator
//
//  Created by Campbell Tajwane J. on 2018-10-19.
//  Copyright © 2018 Campbell Tajwane J. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numberOnScreen:Double = 0
    var expression1:String = "0"
    var expression2:String = "0"
    var resultExpression:String = "0";
    var operation = ""
    
    var operatorActive:Bool = false
    
    @IBOutlet weak var queryLabel: UILabel!
    @IBOutlet weak var resultLable: UILabel!
    
    
    //accepts all number clicks then validates and updates label
    @IBAction func numbers(_ sender: UIButton) {
        
        if(!operatorActive){ //store query in expression 1
            //ensure 0 is not first number
            if(expression1 == "0"){
                expression1 = String(sender.tag-1)
            }
            else{
                expression1 = expression1 + String(sender.tag-1)
            }
             updateQuery(query: expression1)
        }
        
        else if(operatorActive){ //store query in expression 2
            if(expression2 == "0"){
                expression2 = String(sender.tag-1)
            }
            else{
                expression2 = expression2 + String(sender.tag-1)
            }
             updateQuery(query: expression1 + operation + expression2)
        
        }
        
       
    }
    
    
    @IBAction func decimal(_ sender: UIButton) {
     //   if(queryLabel)
        if(operatorActive){
            if(!expression2.contains(".")){
                expression2.append(".")
            }
            updateQuery(query: expression1 + operation + expression2)
        }
        else{
            if(!expression1.contains(".")){
                expression1.append(".")
            }
            updateQuery(query: expression1)
        }
    }
    
    
    //accepts all operator clicks then validates and perfom operation to update result label
    @IBAction func operators(_ sender: UIButton) {
        
        if(operation != ""){//an operation has already been selected
          
                resultExpression=String(getResults(expression1: Double(expression1)!, operation: operation, expression2: Double(expression2)!))
                expression1 = resultExpression
                expression2 = "0"
                showResults(results: resultExpression)
                operation = getOperation(tag: sender.tag)
                operatorActive = true
           
                if(sender.tag == 13){//equal button clicked
                    updateQuery(query: expression1)
                    expression1="0"
                    operatorActive = false
                }
                else{
                    updateQuery(query: expression1 + operation)
                }
            
        }
        else{
            operatorActive = true
            if(sender.tag == 13){//equal button clicked
                resultExpression = expression1
                showResults(results: resultExpression)
                operatorActive=false
            }
            else{
            operation = getOperation(tag: sender.tag)
            }
           
            
            updateQuery(query: expression1 + operation)
        }

    }
    
    
    
    //accepts all function clicks and perform operation
    @IBAction func functions(_ sender: UIButton) {
        if(sender.tag == 19){//clear button clicked
            expression1 = "0"
            expression2 = "0"
            resultExpression = "0"
            operation = ""
            operatorActive=false
            updateQuery(query: resultExpression)
            showResults(results: "")
        }
    }
    
    
    //Updates the query label with user input
    private func updateQuery(query:String){
        queryLabel.text = query
    }
    
    //updates the result label
    private func showResults(results:String){
        resultLable.text = results
    }
    
    
    private func getOperation(tag:Int)->String{
        if(tag == 14){//pluss button clicked
            return "+"
        }
        else if(tag == 15){//pluss button clicked
            return "-"
        }
        else if(tag == 16){//multiply button clicked
            return "x"
        }
        else if(tag == 17){//divide button clicked
            return "/"
        }
        return ""
    }
    
    
    //solves the expression by performing the mod oepration passed to it
    private func getResults(expression1:Double, operation:String, expression2:Double) -> Double{
        if(operation == "+"){
            return expression1 + expression2
        }
        else if (operation == "-"){
            return expression1 - expression2
        }
        else if (operation == "x"){
            return expression1 * expression2
        }
        else if (operation == "/"){
            return expression1 / expression2
        }
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

