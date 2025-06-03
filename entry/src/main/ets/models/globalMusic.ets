import { SongItemType } from './music'

@ObservedV2
export class GlobalMusic {
  @Trace img: string = "" // 音乐封面
  @Trace name: string = "" // 音乐名称
  @Trace author: string = "" // 音乐作者
  @Trace url?: string | number = 0 // 音频链接
  @Trace time: number = 0 // 当前播放时间
  @Trace duration: number = 0 // 歌曲总时长
  @Trace fd?: number = 0 // 文件描述符

  // 歌曲列表
  @Trace playIndex: number = 0
  @Trace playList: SongItemType[] = []
  // 暂停
  @Trace isPlay: boolean = false
  // 播放模式
  @Trace playMode: 'auto' | 'random' | 'repeat' = 'auto'

  // 重置函数
  reset() {
    this.img = ''
    this.name = ''
    this.author = ''
    this.url = ''
    this.time = 0
    this.duration = 0;
    this.fd = 0
    this.playIndex = 0
    this.playList = []
    this.isPlay = false
    this.playMode = 'auto'
  }
}