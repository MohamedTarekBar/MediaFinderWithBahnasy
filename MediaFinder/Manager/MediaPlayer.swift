
import UIKit
import AVKit
import AVFoundation


enum MediaType {
    case song
    case movie
}

struct mediaPlayer {
 
    static var media = mediaPlayer()
    
    var songPlayer :AVQueuePlayer?
    var videosPlayer :AVPlayer?
    var isplaying :Bool = false
    var lastUrl:String?
    
    func playVideo(stringUrl: String?,_ view: UIViewController) {
        guard let stringUrl = stringUrl else {return}
        mediaPlayer.media.songPlayer?.pause()
        let videoURL = URL(string: stringUrl)
        let playing = AVPlayer(url: videoURL!)
        let vc = AVPlayerViewController()
            vc.player = playing
            view.present(vc, animated: true)
            vc.player?.play()
    }
    
    func musicPlayer(stringUrl: String?) {
               do {
                   try AVAudioSession.sharedInstance().setMode(.default)
                   try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

                   guard let urlString = stringUrl else {
                       print("urlstring is nil")
                       return
                   }
                
                mediaPlayer.media.songPlayer = AVQueuePlayer(url: URL(string: urlString)!)
                mediaPlayer.media.lastUrl = stringUrl
               }
               catch {
                   print("error occurred")
               }
       }
    func PlayMedia(type:MediaType) {
        mediaPlayer.media.isplaying = true
        
        if type == MediaType.song {
            songPlayer?.play()
            videosPlayer?.pause()
        } else if type == MediaType.movie {
            videosPlayer?.play()
            songPlayer?.pause()
        }
    }
    
    func pauseMedia(type:MediaType) {
        mediaPlayer.media.isplaying = false

        if type == MediaType.song {
            songPlayer?.pause()

        } else if type == MediaType.movie {
            videosPlayer?.pause()
            
        }
    }
}
