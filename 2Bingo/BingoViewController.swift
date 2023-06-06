import UIKit

class BingoViewController: UIViewController {
    
    var isTapGestureEnabled = true
    
    @IBOutlet weak var labelView: UILabel!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            randomNumber = RandomNumber()
        
    }
    
    //ランダムに値を取り出し削除する構造体
    struct RandomNumber {
        
        var randomNumbers: [Int]
        
        var randomNum: Int
        
        init() {
            randomNumbers = Array(1...75)
            
            randomNum = randomNumbers.remove(at: Int.random(in: 0..<randomNumbers.count))
        }
    }

    var randomNumber: RandomNumber?


    @IBAction func tapAction(_ sender: Any) {

        guard isTapGestureEnabled else {
                return
            }
            
            randomNumber = RandomNumber()
        
            labelView.text = "\(randomNumber?.randomNum ?? 0)"
        
    }
    
    @IBAction func checkButton(_ sender: Any) {
        
        guard isTapGestureEnabled else {
                return
            }
            
            isTapGestureEnabled = false
        
        print("タップは無効です")
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        
        randomNumber?.randomNumbers = Array(1...75) // Reset the array to its initial state
            labelView.text = "最初から！"
        
        print("リセットしました！")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "checkNum" {

            if let checkNumVC = segue.destination as? CheckNumberViewController {

                if let randomNumber = randomNumber {

                    checkNumVC.checkValue = [String(randomNumber.randomNum)]
                }
            }
        }
    }
//
}
