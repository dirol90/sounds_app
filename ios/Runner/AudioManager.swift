
import Foundation
import AVFoundation
import MediaPlayer
import RxRelay

class AudioManager{
    static let sharedInstance = AudioManager()
    var player: AVAudioPlayer?
    var isPlaying = BehaviorRelay<Bool>(value: true)
    
    init(){
//        setupAVAudioSession()
        setupCommandCenter()        
    }
    
    func play(soundName:String){
        player?.stop()
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: "Dream Sounds - \(soundName)"]
        do{
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint:  AVFileType.mp3.rawValue)
            self.player?.numberOfLoops = -1
            play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func play(){
        if let player = player {
            player.play()
            self.isPlaying.accept(true)
        }
    }
    
    func stop(){
        if let player = player {
            player.stop()
            self.isPlaying.accept(false)
        }
    }
    
    func setupAVAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            UIApplication.shared.beginReceivingRemoteControlEvents()
        } catch {
            debugPrint("Error: \(error)")
        }
    }
    
    private func setupCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.play()
            return .success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.stop()
            return .success
        }
    }
    
    
    
}
