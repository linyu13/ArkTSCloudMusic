@Component
export struct Home {
  SwiperList: string[] = []

  build() {
    // Text('首页')
    // .fontColor('#fff')
    Column() {
      Row() {
        // 搜索栏放大镜样例
        Image($r("app.media.ic_search"))
          .width(22)
          .fillColor('#fff')
          .padding({ top: 5, bottom: 5, left: 5 })
        // 搜索框显示字样
        TextInput({ placeholder: '爱情转移' })
          .placeholderColor('#817D83')
          .padding({ left: 5 })
          .fontColor('#999')// 除使用之外
          .layoutWeight(1)
        // 扫描二维码之类
        Image($r('app.media.ic_code'))
          .width(20)
          .fillColor('#fff')
      }.width('100%')
      .border({ radius: 20 })
      .backgroundColor('#2D2B29')
      .padding({ left: 8, right: 8 })

      // 轮播图
      Swiper() {
        // ForEach(this.SwiperList, (item: string) => {
        //   Image(item)
        //     .width('100%')
        // })
        Image("")
          .width('100%')
      }
    }.height('100%')
    .width('100%')
    .padding({
      left: 10,
      right: 10,
      top: 5,
      bottom: 5
    })
  }
}