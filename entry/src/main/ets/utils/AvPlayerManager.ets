import { media } from '@kit.MediaKit'
import { GlobalMusic } from '../models/globalMusic'
import { SongItemType } from '../models/music'
import { AppStorageV2 } from '@kit.ArkUI'

class AvPlayerManager {
  // 播放器
  player: media.AVPlayer | null = null
  currentSong: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!

  // singPlay(song: SongItemType) {
  //   this.player!.url = song.url
  //   this.currentSong.img = song.img
  //   this.currentSong.name = song.name
  // }

  singPlay(song: SongItemType) {
    // 判断是否在列表
    const inList = this.currentSong.playList.some(item => item.id === song.id)
    if (inList) {
      // 在列表当中
      if (this.currentSong.url === song.url) {
        this.player?.play()
        this.currentSong.isPlay = true
      } else {
        // 设置新索引切歌
        this.currentSong.playIndex = this.currentSong.playList.findIndex(item => item.id === song.id)
        this.changeSong()
      }
    } else {
      // 不在列表
      this.currentSong.playList.unshift(song)
      this.currentSong.playIndex = 0
      this.changeSong()
    }
  }

  // 切歌
  async changeSong() {
    await this.player?.reset()
    this.currentSong.duration = 0
    this.currentSong.time = 0
    this.currentSong.img = this.currentSong.playList[this.currentSong.playIndex].img
    this.currentSong.name = this.currentSong.playList[this.currentSong.playIndex].name
    this.currentSong.author = this.currentSong.playList[this.currentSong.playIndex].author
    this.currentSong.url = this.currentSong.playList[this.currentSong.playIndex].url
    this.player!.url = this.currentSong.url!
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
        this.currentSong.isPlay = true
      }
    })

    // 时间变化
    this.player.on('durationUpdate', (duration) => {
      this.currentSong.duration = duration
    })
    this.player.on('timeUpdate', (time) => {
      this.currentSong.time = time
    })
  }

  seekPlay(value: number) {
    this.player?.seek(value)
  }

  paused() {
    this.player?.pause()
    this.currentSong.isPlay = false
  }

  prevPlay() {
    this.currentSong.playIndex--
    if (this.currentSong.playIndex < 0) {
      this.currentSong.playIndex = this.currentSong.playList.length - 1
    }
    this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
  }

  nextPlay() {
    this.currentSong.playIndex++
    if (this.currentSong.playIndex >= this.currentSong.playList.length) {
      this.currentSong.playIndex = 0
    }
    this.singPlay(this.currentSong.playList[this.currentSong.playIndex])

  }
}

export const playerManager: AvPlayerManager = new AvPlayerManager()