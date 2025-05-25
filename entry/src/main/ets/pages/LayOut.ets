// 跳转页面入口函数
@Builder
export function LayOutBuilder() {
  LayOut();
}

@Component
struct LayOut {
  // 控制跳转的对象
  pathStack: NavPathStack = new NavPathStack();

  build() {
    // 子页内容
    NavDestination() {
    }
    .title('布局页')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}
