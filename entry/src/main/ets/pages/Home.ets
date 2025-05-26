interface recommendDailyType {
  img: string // 图片地址
  title: string // 简介
  type: string // 标题
  top: string // 标题背景色
  bottom: string // 简介背景色
}

interface recommendListType {
  img: string // 图片地址
  title: string // 简介
  count: string // 播放量
}

@Component
export struct Home {
  SwiperList: string[] = [
    "https://i.ibb.co/TM58YDf2/59778fdfb1ed1430567683b1972cac40.jpg",
    "https://i.ibb.co/r2k0Q8Qz/5bee85e33c837d399f0c3059bc37c331.jpg",
    "https://i.ibb.co/84x3j2hq/b60556d0296549ba831b0a01c6afa417.jpg",
    "https://i.ibb.co/sk6Z3bV/702e19b5a1b3b3845b6e608d5b30d9fe.jpg",
    "https://i.ibb.co/Gfvb2cRT/7f3a1c742d5f2cd5d2ebde421651cf6e.jpg"
  ]
  dailyRecommend: recommendDailyType[] = [
    {
      img: 'https://i.ibb.co/3yF52MMX/c2dde645c4036bdbdd8c8a0f22298e85.png',
      title: '哈基米叮咚鸡胖宝宝踩踩背搞核酸袋鼠鸡一带一段',
      type: '哈基米',
      top: '#660000',
      bottom: '#382E2F'
    }, {
    img: 'https://i.ibb.co/nK71bt9/a9539faab19ad1e2dbe361c6877aa558.png',
    title: '栗老师小豌豆蹲芳魂原上咪龙抗狼好好汉盖伦发发',
    type: '曼波',
    top: '#ff6e1313',
    bottom: '#ff6d4d50'
  }, {
    img: 'https://i.ibb.co/5hF8Dk33/41aa4e38cda1577ee8487945b9a27205.jpg',
    title: '在美国叫超人在中国叫电棍老爷爷动起来我给你踩踩背',
    type: '叮咚鸡',
    top: '#ff74cbc4',
    bottom: '#ff95883c'
  }, {
    img: 'https://i.ibb.co/FL4wT6cP/27a38df10b69c1d1c381bb57ad6bacbb.jpg',
    title: '哈哈哈哈哈基米下下来搞搞核酸',
    type: '月半猫',
    top: '#ff337d60',
    bottom: '#ff96494e'
  }, {
    img: 'https://i.ibb.co/wZ8DRJTt/591cca150f93c06afa305d43319269aa.jpg',
    title: '叮你看你爹操作ok前十是谁呢圆头耄耋和老财',
    type: '类深山',
    top: '#ffb55025',
    bottom: '#ff2ca173'
  }
  ]
  ListRecommend: recommendListType[] = [
    {
      img: 'https://i.ibb.co/xKzvqKyR/28995a6264c37625d2978ee95cf30a6f.jpg',
      title: '胖宝宝呦好可爱呦小白手套',
      count: "114514"
    },
    {
      img: 'https://i.ibb.co/fVzstnZ2/795ee7a3251386ee5b843565f7fd449f.jpg',
      title: '韭菜盒子吃两个',
      count: "1919810"
    },
    {
      img: 'https://i.ibb.co/HTC77mxX/57bb07eac59b66ed87eb39519692ba79.jpg',
      title: '缺的营养谁给我补啊',
      count: "193705"
    },
    {
      img: 'https://i.ibb.co/5WVgPJP0/4a92dd15c2c77a3392e7fae9533202c9.jpg',
      title: '别吃别吃啊米诺斯曼波曼波我错啦',
      count: "79431"
    },
    {
      img: 'https://i.ibb.co/HDqQTkhZ/da1d439115e0fa148c58ad5d4f5b22b1.jpg',
      title: '扣1复活',
      count: "11111111"
    }
  ]

  // 标题界面
  @Builder
  titleBuilder(title: string) {
    Row() {
      Text(title)
        .fontColor('#ff000000')
        .fontWeight(700)
        .layoutWeight(1)
      Image($r('app.media.ic_more'))
        .width(22)
        .fillColor('#fff')
    }
  }

  build() {
    // Text('首页')
    // .fontColor('#fff')
    List({ space: 10 }) {
      ListItem() {
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
      }

      ListItem() {
        // 轮播图
        Swiper() {
          ForEach(this.SwiperList, (item: string) => {
            // 开通网络权限
            Image(item)
              .width('100%')
              .border({ radius: 10 })
          })
          // Image("https://i.ibb.co/Pvk24CzB/A4-BCF2-DDC7830-D19-DA576-F6-DDEE5-CE0-A.jpg")
          // .width('100%')
        }
        .height(200)
        .autoPlay(true) // 自动播放
      }

      // 标题
      ListItem() {
        this.titleBuilder('每日推荐')
      }

      ListItem() {
        List() {
          ForEach(this.dailyRecommend, (item: recommendDailyType) => {
            ListItem() {
              Column() {
                Text(item.type)
                  .width('100%')
                  .height(40)
                  .backgroundColor(item.top)
                  .padding({ left: 5 })
                  .fontSize(14)
                  .fontColor(Color.White)
                Image(item.img)
                  .width('100%')
                  .height(200)
                Text(item.title)
                  .width('100%')
                  .backgroundColor(item.bottom)
                  .padding(5)
                  .fontSize(14)
                  .fontColor(Color.White)
                  .maxLines(2)// 最大显示行数
                  .textOverflow({ overflow: TextOverflow.Ellipsis }) // 超出显示范围的显示方式
              }
              .width('40%')
              // .height(200)
              .border({ radius: 10 })
              .margin({ right: 10 })
              // 裁剪图片以符合圆角
              .clip(true)
            }
          })
        }
        // 更改列表方向
        .listDirection(Axis.Horizontal)
        .height(290)
        .scrollBar(BarState.Off)
      }

      ListItem() {
        this.titleBuilder('推荐歌单')
      }

      ListItem() {
        List() {
          ForEach(this.ListRecommend, (item: recommendListType) => {
            ListItem() {
              Column() {
                // 左上重叠
                Stack({ alignContent: Alignment.TopStart }) {
                  Image(item.img)
                    .width('100%')
                    .height(100)
                    .border({ radius: 8 })
                  Text(item.count)
                    .fontColor(Color.White)
                    .fontSize(12)
                    .fontWeight(700)
                    .margin(5)
                }

                Text(item.title)
                  .width('100%')
                  .padding(5)
                  .fontSize(14)
                  .fontColor(Color.Black)
                  .maxLines(2)// 最大显示行数
                  .textOverflow({ overflow: TextOverflow.Ellipsis }) // 超出显示范围的显示方式

              }
              .width('30%')
              .margin(10)
            }
          })
        } // 更改列表方向
        .listDirection(Axis.Horizontal)
        .scrollBar(BarState.Off)
      }
    }.height('100%')
    .width('100%')
    .padding({
      left: 10,
      right: 10,
      top: 5,
      bottom: 5
    })
    .scrollBar(BarState.Off)

    // Column({ space: 10 }) {
    //   Row() {
    //     // 搜索栏放大镜样例
    //     Image($r("app.media.ic_search"))
    //       .width(22)
    //       .fillColor('#fff')
    //       .padding({ top: 5, bottom: 5, left: 5 })
    //     // 搜索框显示字样
    //     TextInput({ placeholder: '爱情转移' })
    //       .placeholderColor('#817D83')
    //       .padding({ left: 5 })
    //       .fontColor('#999')// 除使用之外
    //       .layoutWeight(1)
    //     // 扫描二维码之类
    //     Image($r('app.media.ic_code'))
    //       .width(20)
    //       .fillColor('#fff')
    //   }.width('100%')
    //   .border({ radius: 20 })
    //   .backgroundColor('#2D2B29')
    //   .padding({ left: 8, right: 8 })
    //
    //   // 轮播图
    //   Swiper() {
    //     ForEach(this.SwiperList, (item: string) => {
    //       // 开通网络权限
    //       Image(item)
    //         .width('100%')
    //         .border({ radius: 10 })
    //     })
    //     // Image("https://i.ibb.co/Pvk24CzB/A4-BCF2-DDC7830-D19-DA576-F6-DDEE5-CE0-A.jpg")
    //     // .width('100%')
    //   }
    //   .height(200)
    //   .autoPlay(true) // 自动播放
    //
    //   // 标题
    //   this.titleBuilder('每日推荐')
    //   List() {
    //     ForEach(this.dailyRecommend, (item: recommendDailyType) => {
    //       ListItem() {
    //         Column() {
    //           Text(item.type)
    //             .width('100%')
    //             .height(40)
    //             .backgroundColor(item.top)
    //             .padding({ left: 5 })
    //             .fontSize(14)
    //             .fontColor(Color.White)
    //           Image(item.img)
    //             .width('100%')
    //             .height(200)
    //           Text(item.title)
    //             .width('100%')
    //             .backgroundColor(item.bottom)
    //             .padding(5)
    //             .fontSize(14)
    //             .fontColor(Color.White)
    //             .maxLines(2)// 最大显示行数
    //             .textOverflow({ overflow: TextOverflow.Ellipsis }) // 超出显示范围的显示方式
    //         }
    //         .width('40%')
    //         // .height(200)
    //         .border({ radius: 10 })
    //         .margin({ right: 10 })
    //         // 裁剪图片以符合圆角
    //         .clip(true)
    //       }
    //     })
    //   }
    //   // 更改列表方向
    //   .listDirection(Axis.Horizontal)
    //   .height(290)
    //   .scrollBar(BarState.Off)
    //
    //   this.titleBuilder('推荐歌单')
    //   List() {
    //     ForEach(this.ListRecommend, (item: recommendListType) => {
    //       ListItem() {
    //         Column() {
    //           Stack() {
    //             Image(item.img)
    //               .width('100%')
    //               .height(100)
    //               .border({ radius: 8 })
    //             Text(item.count)
    //               .fontColor(Color.White)
    //               .fontSize(12)
    //               .fontWeight(700)
    //           }
    //         }
    //         .width('30%')
    //         .margin(10)
    //       }
    //     })
    //   }
    // }.height('100%')
    // .width('100%')
    // .padding({
    //   left: 10,
    //   right: 10,
    //   top: 5,
    //   bottom: 5
    // })
  }
}