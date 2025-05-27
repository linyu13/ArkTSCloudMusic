import { SongItemType } from '../models/music'
import { AppStorageV2 } from '@kit.ArkUI'
import { playerManager } from '../utils/AvPlayerManager'

@Component
export struct Find {
  songs: SongItemType[] = [
    {
      img: 'https://i.ibb.co/ynb1JJgg/b6e07678df0397a1db3f864bdc6edacf.jpg',
      name: '出哈',
      author: '哈基米',
      url: 'https://files.catbox.moe/6vzgx2.m4a',
      id: '000'
    },
    {
      img: 'https://i.ibb.co/7dXDHj3V/109951170981773297.jpg',
      name: '珠玉',
      author: '单依纯',
      url: 'https://files.catbox.moe/mpz2qp.m4a',
      id: '001'
    },
    {
      img: 'https://i.ibb.co/dsVL2Wz5/109951167435823724.png',
      name: '富士山下',
      author: '陈奕迅',
      url: 'https://files.catbox.moe/pea2vg.m4a',
      id: '002'
    },
    {
      img: 'https://i.ibb.co/Q7mrbWF7/109951166191908812.png',
      name: '眼泪成诗',
      author: '孙燕姿',
      url: 'https://files.catbox.moe/c6uvvn.m4a',
      id: '003'
    },
    {
      img: 'https://i.ibb.co/whDVS3gn/109951169829283327.png',
      name: '逆光',
      author: '孙燕姿',
      url: 'https://files.catbox.moe/atnm6s.m4a',
      id: '004'
    },
    {
      img: 'https://i.ibb.co/NgcgdV6X/34084860473122.png',
      name: '庐州月',
      author: '许嵩',
      url: 'https://files.catbox.moe/gbvkjk.mp3',
      id: '005'
    },
    {
      img: 'https://i.ibb.co/Xrj24NDy/5859297464524710.jpg',
      name: '锦鲤抄',
      author: '银临/云之泣',
      url: 'https://files.catbox.moe/8ax0vh.m4a',
      id: '006'
    }

  ]
  pageStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navStack', () => new NavPathStack())!

  build() {
    // Text('发现')
    // .fontColor('#fff')
    Column() {
      Text('猜你喜欢')
        .fontColor(Color.Black)
        .width('100%')
        .margin({ bottom: 10 })
      List() {
        ForEach(this.songs, (item: SongItemType, index: number) => {
          ListItem() {
            Row() {
              Stack() {
                Image(item.img)
                  .width(80)
                  .border({ radius: 8 })
                  .margin({ right: 10 })
                // Image($r('app.media.wave'))
                //   .width(24)
              }

              Column() {
                Text(item.name)
                  .fontColor('#ff000000')
                  .width('100%')
                  .fontWeight(700)
                  .margin({ bottom: 15 })
                Text(item.author)
                  .width('100%')
                  .fontColor('#131313')
              }.layoutWeight(1)

              Image($r('app.media.ic_more'))
                .width(22)
                .fillColor('#ff000000')
            }
          }.width('100%')
          .height(80)
          .margin({ bottom: 10 })
          .onClick(() => {
            this.pageStack.pushPathByName('Play', null, false)
            playerManager.singPlay(item)
          })
        })
      }
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({ left: 10, right: 10 })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

  }
}