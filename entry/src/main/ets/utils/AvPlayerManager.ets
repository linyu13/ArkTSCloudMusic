import { media } from '@kit.MediaKit'
import { GlobalMusic } from '../models/globalMusic'
import { SongItemType } from '../models/music'
import { AppStorageV2 } from '@kit.ArkUI'

class AvPlayerManager {
  // 播放器
  player: media.AVPlayer | null = null
  currentSong: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!

  singPlay(song: SongItemType) {
    this.player!.url = song.url
    this.currentSong.img = song.img
    this.currentSong.name = song.name
  }

  //定义方法创建播放器，监听状态变化
  async init() {
    if (!this.player) {
      this.player = await media.createAVPlayer()
    }

    this.player.on('stateChange', (state) => {
      if (state === 'initialized') {
        this.player?.prepare()
      } else if (state === 'prepared') {
        this.player?.play()
      }
    })
  }
}

export const playerManager: AvPlayerManager = new AvPlayerManager()