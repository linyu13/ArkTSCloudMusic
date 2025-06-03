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
        this.changeSong(song)
      }
    } else {
      // 不在列表
      this.currentSong.playList.unshift(song)
      this.currentSong.playIndex = 0
      this.changeSong(song)
    }
  }

  // 切歌
  async changeSong(song: SongItemType) {
    await this.player?.reset()
    this.currentSong.duration = 0
    this.currentSong.time = 0
    this.currentSong.img = this.currentSong.playList[this.currentSong.playIndex].img
    this.currentSong.name = this.currentSong.playList[this.currentSong.playIndex].name
    this.currentSong.author = this.currentSong.playList[this.currentSong.playIndex].author
    this.currentSong.url = this.currentSong.playList[this.currentSong.playIndex].url
    // this.player!.url = this.currentSong.url!
    const context = getContext(this)
    const fdObj = await context.resourceManager.getRawFd('chuHa.m4a') // 不要加路径
    this.currentSong.fd = fdObj.fd
    this.player!.url = `fd://${fdObj.fd}`

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
      } else if (state === 'completed') {
        this.nextPlay(true)
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
    if (this.currentSong.playMode === 'random') {
      this.currentSong.playIndex = Math.floor(Math.random() * this.currentSong.playList.length)
    } else {
      this.currentSong.playIndex--
      if (this.currentSong.playIndex < 0) {
        this.currentSong.playIndex = this.currentSong.playList.length - 1
      }

    }

    this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
  }

  nextPlay(autoNextPlay?: boolean) {
    // 真重复
    if (this.currentSong.playMode === 'repeat' && autoNextPlay) {
      this.currentSong.playIndex = this.currentSong.playIndex
    } else if (this.currentSong.playMode === 'random') {
      // 随机
      this.currentSong.playIndex = Math.floor(Math.random() * this.currentSong.playList.length)
    } else {
      // 列表
      this.currentSong.playIndex++
      if (this.currentSong.playIndex >= this.currentSong.playList.length) {
        this.currentSong.playIndex = 0
      }
    }
    this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
  }

  // 列表移除歌曲
  removeSong(index: number) {
    // 删除了正在播放的
    if (index === this.currentSong.playIndex) {
      // 删除歌曲时列表有至少两首
      if (this.currentSong.playList.length > 1) {
        // 删除的是当前播放的歌曲且不是位于列表最后一位的歌曲
        this.currentSong.playList.splice(index, 1)

        // 删除的是当前播放歌曲且是当前列表的位于最后一位的歌曲
        if (this.currentSong.playIndex >= this.currentSong.playList.length) {
          this.currentSong.playIndex = 0
        }
        this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
      } else {
        this.currentSong.playList.splice(index, 1)
        this.player?.reset()
        this.currentSong.reset()
      }
    } else {
      if (index < this.currentSong.playIndex) {
        this.currentSong.playIndex--
      }
      this.currentSong.playList.splice(index, 1)
    }
  }
}

export const playerManager: AvPlayerManager = new AvPlayerManager()