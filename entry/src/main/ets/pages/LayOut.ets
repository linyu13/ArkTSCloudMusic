import { Find } from './Find';
import { Home } from './Home';
import { Mine } from './Mine';
import { Moment } from './Moment';

// 跳转页面入口函数
interface TabClass {
  text: string
  icon: ResourceStr
}

@Builder
export function LayOutBuilder() {
  LayOut();
}

@ComponentV2
struct LayOut {
  @Local currentIndex: number = 0
  // 控制跳转的对象
  pageStack: NavPathStack = new NavPathStack();
  tabData: TabClass[] = [
    { text: '首页', icon: $r('app.media.ic_home') },
    { text: '发现', icon: $r('app.media.ic_find') },
    { text: '动态', icon: $r('app.media.ic_moment') },
    { text: '我的', icon: $r('app.media.ic_mine') }
  ]

  @Builder
  TabBuilder(item: TabClass, index: number) {
    Column({ space: 5 }) {
      Image(item.icon)
        .width(24)
        .fillColor(this.currentIndex === index ? '#E85A88' : '#63AAAA')
      Text(item.text)
        .fontSize(14)
        .fontColor(this.currentIndex === index ? '#E85A88' : '#63AAAA')
    }
  }

  build() {
    // 子页内容
    NavDestination() {
      Tabs() {
        ForEach(this.tabData, (item: TabClass, index: number) => {
          TabContent() {
            if (this.currentIndex === 0) {
              Home()
            } else if (this.currentIndex === 1) {
              Find()
            } else if (this.currentIndex === 2) {
              Moment()
            } else {
              Mine()
            }
          }.tabBar(this.TabBuilder(item, index))
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
        })
      }
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .barPosition(BarPosition.End)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

    }
    // .title('布局页')
    .onReady((context: NavDestinationContext) => {
      this.pageStack = context.pathStack;
    })
  }
}
