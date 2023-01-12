

import UIKit

class ChatSenderImage_TableCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIControl!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var starBtn: UIButton!
    @IBOutlet weak var videoView: UIControl!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var fileImage: UIImageView!
    
    var delegate: PlayVideoDelegate?
    
    var index:Int? = nil
    
    var status:Bool? = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.fileImage.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func playPresserd(_ sender: Any) {
        self.delegate?.playVideo(index: index ?? 0, status: true)
    }
}
