import UIKit

import AVFoundation

class BingoViewController: UIViewController {
    
    
    @IBOutlet weak var labelView: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    //ドラムのフラグ
    var drumRollActive = false
    
    //ドラムロール用のインスタンス
    var drumPlay: AVAudioPlayer?
    
    //音楽ファイル再生用のインスタンス
    var musicPlayer: AVAudioPlayer?
    
    var timerNum = Array(1...99)
    
    var currentIndex = 0
    
    var timer: Timer?

    var slideShowActive = false

    var shouldGenerateValues = true

    var randomValues = [Int]()
    
    var randomNumbers = Array(1...75)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkButton.layer.cornerRadius = 10.0
        
        resetButton.layer.cornerRadius = 10.0
    }
    
    //start
    func startSlideShow() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateSlide), userInfo: nil, repeats: true)
        
        currentIndex = 0 // Reset the currentIndex
        
        updateSlide() // Display initial value
    }
    
    //stop
    func stopSlideShow() {
        
        stopDrum()
        
        musicPlayer = nil
        
        timer?.invalidate()
        
        timer = nil
        
        slideShowActive = false
    }

    func resetFlag() {
        
        shouldGenerateValues = true
    }

    //ランダムに値を生成する
    func randomGenerator() {
        
        if !shouldGenerateValues {
                return
            }
        
        if randomNumbers.isEmpty {
            
            labelView.text = "終了！"
                        
        } else {
            let randomIndex = Int.random(in: 0..<randomNumbers.count)
            
            let randomValue = randomNumbers[randomIndex]
            
            randomNumbers.remove(at: randomIndex)
            
            randomValues.append(randomValue)
            
            print("残り\(randomNumbers.count)です！")
            
            labelView.text = "\(randomValue)"
        }
    }
    
    //ドラム再生用
    func drumPlayer() {
        
        if let drumPath = Bundle.main.url(forResource: "ドラムロール", withExtension: "mp3") {
            
            playSound(player: &drumPlay, path: drumPath, count: drumRollActive ? -1 : 0, startTime: 0.5, duration: 8)
        } else {
            
            print("ドラムロールの音楽ファイルが見つかりませんでした")
        }
    }
    
    //ドラムSTOP
    func stopDrum() {
        
        drumPlay?.stop()
        
        drumPlay = nil
    }
    
    func playSound(player: inout AVAudioPlayer?, path: URL, count: Int, startTime: TimeInterval, duration: TimeInterval, completion: (() -> Void)? = nil) {
        
        guard player == nil else {
            
            return
        }
        do {
            
            let audioPlayer = try AVAudioPlayer(contentsOf: path)
            
                audioPlayer.numberOfLoops = count
    
                //再生開始位置
                audioPlayer.currentTime = startTime
    
                audioPlayer.enableRate = true
    
                audioPlayer.rate = 1.0
    
                audioPlayer.play()
            
                player = audioPlayer
            
            if count == -1 {
                
                var capturedPlayer = player
                
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    
                    self.playSound(player: &capturedPlayer, path: path, count: -1, startTime: startTime, duration: duration, completion: completion)
                }
                
            } else {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    
                    audioPlayer.stop()
                    
                    completion?()
                }
            }
        } catch {
            
            print("再生中にエラーが発生しました！")
        }
    }

    @IBAction func tapAction(_ sender: Any) {
        
        if !slideShowActive {
            
            drumRollActive = true
            
            drumPlayer()
                        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                
                self.slideShowActive = true
                
                self.startSlideShow()
            }
               
            } else if shouldGenerateValues && !randomNumbers.isEmpty {

                //シンバルの音
                let symbalPath = Bundle.main.url(forResource: "シンバル", withExtension: "mp3")!
                
                randomGenerator()
                
                playSound(player: &musicPlayer, path: symbalPath, count: 1, startTime: 0, duration: 3.0)
                
                labelView.text = "\(randomValues.last ?? 0)"
                
                drumRollActive = false
                
                stopDrum()
                
                stopSlideShow()
            }
    }
    
    @IBAction func checkButton(_ sender: Any) {
        
        print("タップは無効です")
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        
            randomValues = []
        
            randomNumbers = Array(1...75)
        
            resetFlag()
        
            labelView.text = "最初から！"
        
        print("リセットしました！")
        
    }
    
    @objc func updateSlide() {
        currentIndex += 1
        
        if currentIndex >= timerNum.count {
            currentIndex = 0 // Reset the currentIndex to start over
        }
        
        let currentValue = timerNum[currentIndex]
        labelView.text = "\(currentValue)"
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //segueのIDの確認
        if segue.identifier == "checkNum" {
            
            //遷移先のViewContorollerのインスタンス化
            if let checkNumVC = segue.destination as? CheckNumberViewController {
                
                    checkNumVC.checkValue = randomValues.map { String($0) }
                
                }
            }
        }
//
}
