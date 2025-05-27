// // 初始代码
// import { router } from '@kit.ArkUI'
//
// @Entry
// @Component
// struct HomePage {
//   @State content: string = ''
//
//   onPageShow(): void {
//     const params = router.getParams() as Record<string, string>
//     this.content = params['content']
//   }
//
//   build() {
//     Column() {
//       Button("Home Page")
//         .fontSize(30)
//         .padding(20)
//         .onClick(() => {
//           this.invokeDetailPage()
//         })
//     }
//     .width('100%')
//     .height('100%')
//     .backgroundColor(Color.Yellow)
//     .justifyContent(FlexAlign.Center)
//   }
//
//   private invokeDetailPage(): void {
//     router.pushUrl({
//       url: 'pages/DetailPage'
//     }, router.RouterMode.Standard, (err) => {
//       if (err) {
//         console.error(`Invoke replaceUrl failed, code is ${err.code}, message is ${err.message}`)
//         return;
//       }
//       console.log('Invoke replaceUrl succeeded')
//     })
//   }
//
//   private invokeDetailPageWithParma(): void {
//     router.pushUrl({
//       url: 'pages/DetailPage',
//       params: { content: 'content from HonePage' }
//     }, router.RouterMode.Standard, (err) => {
//       if (err) {
//         console.error(`Invoke replaceUrl failed, code is ${err.code}, message is ${err.message}`)
//         return;
//       }
//       console.log('Invoke replaceUrl succeeded')
//     })
//
//   }
// }
import { AppStorageV2 } from '@kit.ArkUI';


// import { router } from '@kit.ArkUI'
//
// @Entry
// @Component
// struct HomePage {
//   @State content: string = ''
//
//   onPageShow(): void {
//     const params = router.getParams() as Record<string, string>
//     this.content = params['content']
//   }
//
//   build() {
//     Column() {
//       Text('Detail Page')
//         .fontSize(30)
//       Text(this.content)
//         .fontSize(30)
//     }
//     .width('100%')
//     .height('100%')
//     .backgroundColor(Color.Transparent)
//     .justifyContent(FlexAlign.Center)
//   }
// }

// @Entry
// @Component
// struct Index {
//   @State message: string = 'Hello World'
//
//   build() {
//     Column() {
//       Row() {
//         Text(this.message)
//           .fontSize(30)// .fontWeight(FontWeight.Bold)
//           .border({
//             width: 3,
//             color: Color.Gray,
//             style: BorderStyle.Dashed,
//             radius: 10
//           })
//       }.height('100%')
//     }.width('100%')
//
//     // Column() {
//     //   Text('+ 状态')
//     //     .fontSize(30)// .fontWeight(FontWeight.Bold)
//     //     .border({
//     //       width: 3,
//     //       color: Color.Gray,
//     //       style: BorderStyle.Dashed,
//     //       radius: 10
//     //     })
//
//
//   }
// }

@Entry
@Component
struct Index {
  // pageStack: NavPathStack = new NavPathStack();
  pageStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navStack', () => new NavPathStack())!

  build() {
    Navigation(this.pageStack) {
    }.onAppear(() => {
      // 跳转 使用 route_map 中的 name
      this.pageStack.pushPathByName("Start", null, false);
    })
    .hideNavBar(true) // 不会把自己放到控制跳转的对象当中 也就是不会返回到这个导航页
  }
}
