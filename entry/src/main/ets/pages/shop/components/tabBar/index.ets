import { CommonConstants as Const } from '../../../../common/constants/CommonConstants';
import TabBarModel, { TabBean } from '../../model/TabBarModel';
import ShopHome from '../home';
import PageTitle from '../../../../components/PageTitle';

@Component
@Preview
export default struct TabBar {
  @State tabBarArray: TabBean[] = TabBarModel.getTabList();
  @Link currentIndex: number;
  @State currentPage: number = 1;
  @Link tabIndexNum: number;
  @Provide('isBig') isBig: boolean = false;
  controller: TabsController = new TabsController()

  @Builder
  TabBuilder(index: number, tabBean: TabBean) {
    Column() {
      Image(tabBean.icon).height(20).width(20).margin({ bottom: 4 })
        .fillColor(this.currentIndex === index ? 'red' : '#999')
      Text(this.tabBarArray[index].name)
        .fontColor(this.currentIndex === index ? 'red' : '#999')
        .fontSize(14)
        .margin({ bottom: 2 })
    }
  }

  aboutToAppear() {
  }

  build() {
    Tabs({ controller: this.controller }) {
      ForEach(this.tabBarArray, (tabsItem: TabBean, index) => {
        TabContent() {
          Column() {
            if (this.currentIndex === 0) {
              // ShopHome({ currentIndex: $currentIndex })
              ShopHome()
            } else if (this.currentIndex === 1) {
              Column() {
                PageTitle({ title: '钱币博物馆' })
              }
              .width('100%')
              .height('100%')
              // Life({ currentIndex: $currentIndex })
            } else if (this.currentIndex === 2) {
              Column() {
                PageTitle({ title: '神券神价' })
              }
              .width('100%')
              .height('100%')
              // Msg({ currentIndex: $currentIndex })
            } else if (this.currentIndex === 3) {
              Column() {
                PageTitle({ title: '聚优惠专区' })
              }
              .width('100%')
              .height('100%')
              // Finance({ currentIndex: $currentIndex })
            } else if (this.currentIndex === 4) {
              Column() {
                PageTitle({ title: '我的' })
              }
              .width('100%')
              .height('100%')
              // Mine({ currentIndex: $currentIndex })
            } else {
              Text(tabsItem.name)
                .onClick(() => {
                  this.isBig = !this.isBig
                })
                .backgroundColor('#00ff00')
                .height(this.isBig ? 400 : 200)
                .animation({
                  duration: 1000,
                  tempo: 3.0,
                  delay: 0,
                  curve: Curve.Linear,
                  playMode: PlayMode.Normal,
                  iterations: 1
                })

            }
          }

          .backgroundColor('#f2f2f2')
        }
        .tabBar(this.TabBuilder(index, tabsItem))
      }, (item: TabBean) => JSON.stringify(item)
      );
    }
    .barHeight(50)
    .barPosition(BarPosition.End)
    .barMode(BarMode.Fixed)
    .barWidth(Const.THOUSANDTH_1000)
    .onChange((index: number) => {
      this.currentIndex = index;
      this.currentPage = 1;
      this.tabIndexNum = index
    })
    .vertical(false)
  }
}