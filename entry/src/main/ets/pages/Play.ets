import { GlobalMusic } from '../models/globalMusic'
import { SongItemType } from '../models/music'
import { AppStorageV2 } from '@kit.ArkUI'
import { playerManager } from '../utils/AvPlayerManager'

@Builder
export function PlayBuilder() {
  Play()
}

@ComponentV2
struct Play {
  @Local panelHeight: string = '0%'
  @Local panelOpacity: number = 0
  pathStack: NavPathStack = new NavPathStack()
  songs: SongItemType[] = [
    {
      img: 'https://i.ibb.co/ynb1JJgg/b6e07678df0397a1db3f864bdc6edacf.jpg',
      name: '出哈',
      author: '哈基米',
      url: 'chuHa.m4a',
      id: '000'
    },
    {
      img: 'https://i.ibb.co/7dXDHj3V/109951170981773297.jpg',
      name: '珠玉',
      author: '单依纯',
      url: 'zhuYu.m4a',
      id: '001'
    },
    {
      img: 'https://i.ibb.co/dsVL2Wz5/109951167435823724.png',
      name: '富士山下',
      author: '陈奕迅',
      url: 'fuShiShanXia.m4a',
      id: '002'
    },
    {
      img: 'https://i.ibb.co/Q7mrbWF7/109951166191908812.png',
      name: '眼泪成诗',
      author: '孙燕姿',
      url: 'yanLeiChengShi.m4a',
      id: '003'
    },
    {
      img: 'https://i.ibb.co/whDVS3gn/109951169829283327.png',
      name: '逆光',
      author: '孙燕姿',
      url: 'niGuang.m4a',
      id: '004'
    },
    {
      img: 'https://i.ibb.co/NgcgdV6X/34084860473122.png',
      name: '庐州月',
      author: '许嵩',
      url: 'luZhouYue.m4a',
      id: '005'
    },
    {
      img: 'https://i.ibb.co/Xrj24NDy/5859297464524710.jpg',
      name: '锦鲤抄',
      author: '银临/云之泣',
      url: 'jinLiChao.mp3',
      id: '006'
    }

  ]
  // AppStorageV2 共享播放数据
  @Local
  playState: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!

  // playState: SongItemType = this.songs[0]


  @Builder
  deleteButton(index: number) {
    Button('删除')
      .backgroundColor('#ffdd1c78')
      .fontColor(Color.Black)
      .width(80)
      .height('100%')
      .type(ButtonType.Normal)
  }

  number2tme(number: number) {
    if (number > 60 * 1000) {
      const s = Math.floor(number / 1000 % 60)
      const m = Math.floor(number / 1000 / 60)
      const second = s.toString().padStart(2, '0')
      const minute = m.toString().padStart(2, '0')
      return minute + ":" + second
    } else {
      const s = Math.floor(number / 1000 % 60)
      const second = s.toString().padStart(2, '0')
      return "00:" + second
    }
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Bottom }) {
        // 播放
        Stack() {
          // 变色背景
          Image(this.playState.img)
            .width('100%')
            .height('100%')
            .blur(1000)
            .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

          Column() {
            // 播放界面
            Column() {
              // 图片
              Stack({ alignContent: Alignment.Bottom }) {
                Row() {
                  Row() {
                    Image(this.playState.img)
                      .width('70%')
                      .borderColor(400)
                  }
                  .backgroundImage($r('app.media.ic_cd'))
                  .backgroundImageSize(ImageSize.Cover)
                  .justifyContent(FlexAlign.Center)
                  .width('100%')
                  .borderRadius(400)
                  .clip(true)
                  .aspectRatio(1)
                }
                .margin({ top: 50 })
                .width('90%')
                .aspectRatio(1)
                .justifyContent(FlexAlign.Center)
                .padding(24)

                // 指针
                // Image($r('app.media.ic_stylus'))
                //   .width(200)
                //   .aspectRatio(1)
                //   .rotate({ angle: -55, centerX: 100, centerY: 30 })
                //   .animation({ duration: 500 })
              }

              // 歌曲信息
              Stack() {
                // 第一个
                Column({ space: 8 }) {
                  Text(this.playState.name)
                    .fontSize(28)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#4BB0C4')
                  Text(this.playState.author)
                    .fontSize(18)
                    .fontColor('#4BB0C4')
                }
                .layoutWeight(1)
                .justifyContent(FlexAlign.Center)
                .zIndex(1)

                // 第二个
                Column({ space: 8 }) {
                  Text(this.playState.name)
                    .fontSize(28)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#EC5C87')
                  Text(this.playState.author)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#EC5C87')
                }
                .layoutWeight(1)
                .justifyContent(FlexAlign.Center)
                .zIndex(2)

                // 第三个
                Column({ space: 8 }) {
                  Text(this.playState.name)
                    .fontSize(28)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                  Text(this.playState.author)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                }
                .layoutWeight(1)
                .justifyContent(FlexAlign.Center)
                .zIndex(3)
              }
              .layoutWeight(1)

              // 操作
              Row() {
                Badge({ value: '99+', style: { badgeSize: 12, badgeColor: Color.Gray } }) {
                  Image($r('app.media.ic_like'))
                    .fillColor(Color.White)
                    .width(24)
                }

                Badge({ value: '10w', style: { badgeSize: 12, badgeColor: Color.Gray } }) {
                  Image($r('app.media.ic_comment_o'))
                    .fillColor(Color.White)
                    .width(18)
                }

                Badge({ value: 'hot', style: { badgeSize: 12, badgeColor: Color.Gray } }) {
                  Image($r('app.media.ic_bells_o'))
                    .fillColor(Color.White)
                    .width(24)
                }

                Badge({ value: '99+', style: { badgeSize: 12, badgeColor: Color.Gray } }) {
                  Image($r('app.media.ic_download_o'))
                    .fillColor(Color.White)
                    .width(24)
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceAround)

              // 播放
              Column() {
                // 进度条
                Row({ space: 4 }) {
                  Text(this.number2tme(this.playState.time))
                    .fontSize(12)
                    .fontColor(Color.White)
                  Slider({
                    value: this.playState.time,
                    min: 0,
                    max: this.playState.duration
                  })
                    .onChange((value) => {
                      playerManager.seekPlay(value)
                    })
                    .layoutWeight(1)
                    .blockColor(Color.White)
                    .selectedColor(Color.White)
                    .trackColor('#CCC5C5C5')
                    .trackThickness(2)
                  Text(this.number2tme(this.playState.duration))
                    .fontSize(12)
                    .fontColor(Color.White)
                }
                .width('100%')
                .padding(24)

                // 切换
                Row() {
                  Image($r('app.media.ic_auto'))
                    .fillColor(Color.White)
                    .width(30)
                  Image($r('app.media.ic_prev'))
                    .fillColor(Color.White)
                    .width(30)
                    .onClick(() => {
                      playerManager.prevPlay()
                    })

                  // 播放按钮
                  Image(this.playState.isPlay ? $r('app.media.ic_pause') : $r('app.media.ic_play'))
                    .fillColor(Color.White)
                    .width(50)
                    .onClick(() => {
                      this.playState.isPlay ? playerManager.paused() :
                      playerManager.singPlay(this.playState.playList[this.playState.playIndex])
                    })
                  Image($r('app.media.ic_after'))
                    .fillColor(Color.White)
                    .width(30)
                    .onClick(() => {
                      playerManager.nextPlay()
                    })
                  Image($r('app.media.ic_songList'))
                    .fillColor(Color.White)
                    .width(30)

                }
                .width('100%')
                .padding({})
              }
            }
          }
        }
      }
    }
  }
}