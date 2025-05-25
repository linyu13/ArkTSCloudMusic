// 跳转页面入口函数
@Builder
export function StartBuilder() {
  Start();
}

@Component
struct Start {
  // 控制跳转的对象
  pathStack: NavPathStack = new NavPathStack();

  build() {
    // 子页内容
    NavDestination() {
    }
    .title('广告')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}
