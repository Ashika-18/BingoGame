import UIKit
//これが残る
class BingoViewController: UIViewController {
    
    
    @IBOutlet weak var labelView: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    var randomValues = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkButton.layer.cornerRadius = 10.0
        
        resetButton.layer.cornerRadius = 10.0
        
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
        
            randomNumber = RandomNumber()
        
            labelView.text = "\(randomNumber?.randomNum ?? 0)"
        
        randomValues.append(randomNumber!.randomNum)
        
        print("\(randomValues)を渡しました")
        
    }
    
    @IBAction func checkButton(_ sender: Any) {
        
        print("タップは無効です")
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        
        randomNumber?.randomNumbers = Array(1...75)
        
            labelView.text = "最初から！"
        
        print("リセットしました！")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //segueのIDの確認
        if segue.identifier == "checkNum" {
            
            //遷移先のViewContorollerのインスタンス化
            if let checkNumVC = segue.destination as? CheckNumberViewController {
                
                //遷移先の変数に値を代入する
                if let randomNumber = randomNumber {
                    
                    checkNumVC.checkValue = randomValues.map { String($0) }
                    
                    checkNumVC.receivedRandomNumber = randomNumber

                   
                }
            }
        }
    }
//
}
