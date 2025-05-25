// 跳转页面入口函数
@Builder
export function StartBuilder() {
  Start();
}

@Component
struct Start {
  // 控制跳转的对象
  pageStack: NavPathStack = new NavPathStack();

  // 计时自动跳转 页面打开开始计时
  aboutToAppear(): void {
    // 生命周期 居然在这里遇到了吗（
    setTimeout(() => {
      this.pageStack.replacePathByName("LayOut", null, false) // 跳转之后无法返回到该页面
    }, 3000) // 以毫秒为单位
  }

  build() {
    // 子页内容
    NavDestination() {
      Stack() {
        Image($r('app.media.AD'))
          .width('100%')
          .height('100%')
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
        Button('跳过')
          .margin(15)
          .backgroundColor(Color.Grey)
          .onClick(() => {
            this.pageStack.replacePathByName("LayOut", null, false) // 跳转之后无法返回到该页面
          })
      }.alignContent(Alignment.TopEnd)
    }
    // .title('广告')
    .onReady((context: NavDestinationContext) => {
      this.pageStack = context.pathStack;
    })
  }
}
