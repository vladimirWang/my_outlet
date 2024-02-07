import PageTitle from '../components/PageTitle'
import {IMessage} from '../common/types'
import {MessageType} from '../common/enum'
import promptAction from '@ohos.promptAction'
import MessageInfoApi from '../common/database/tables/MessageInfoApi'
import {sleep} from '../common/utils/helper'
const mockData = [
  {
    id: 1,
    title: '优惠助手',
    desc: '点击即领还款券，最高得620元，信用卡还款0手续费',
    type: MessageType["discount"]
  },
  {
    id: 2,
    title: '信用卡申请',
    desc: '点击即领还款券，最高得620元，信用卡还款0手续费',
    type: MessageType["service"]
  },
]

@Preview
@Component
export default struct Message {
  @State messages: IMessage[] = []
  @State isLoading: boolean =false;
  @State errMessage: string = ''

  @Builder MyMenu() {
       Menu() {
         MenuItem({ content: "退订" })
         MenuItem({ content: "删除" })
         MenuItem({ content: "投诉" })
       }
  }

  aboutToAppear() {
    this.loadData();
  }

  async loadData() {
    try {
      this.isLoading = true;
      // const tasks = mockData.map(item => MessageInfoApi.insert(item))
      // await Promise.all(tasks)
      // // promptAction.showToast({message: '插入成功'})
      // const { list, count } = await MessageInfoApi.query()
      await sleep(1500)
      this.messages = [
          {
            id: 1,
            title: '优惠助手',
            desc: '点击即领还款券，最高得620元，信用卡还款0手续费',
            type: MessageType["discount"]
          },
          {
            id: 2,
            title: '信用卡申请',
            desc: '点击即领还款券，最高得620元，信用卡还款0手续费',
            type: MessageType["service"]
          },
      ]
      // promptAction.showToast({message: '消息查询成功'})
    } catch (e) {
      promptAction.showToast({message: e.message})
    } finally {
      // await sleep(4000)
      this.isLoading = false;
    }
  }
  @Builder messageItem(item) {
  Column() {
    // 消息卡片的头部
    Row() {
      Row(){
        Image($r('app.media.usercard')).width(26).margin({right: 6})
        Text(item.title).fontColor('#1865ff')
      }
      Image($r('app.media.shenluehao')).width(20).bindMenu(this.MyMenu)
    }.width('100%').justifyContent(FlexAlign.SpaceBetween)
    Column() {
      // Text(item.title).width('100%')
      //   .fontWeight(FontWeight.Medium)
      //   .fontSize(20).padding({bottom: 5})
      Text(item.desc)
    }.width('100%')
    // .backgroundColor('red')
    .padding({left: 5, right: 5, top: 15, bottom: 15})
    Row() {
      Text("奖励名称").fontColor('#ababab').margin({right: 20})
      Text("抽奖资格已到账")
    }.width('100%').padding({left: 5})
    Row() {
      Text("活动名称").fontColor('#ababab').margin({right: 20})
      Text("资询信用卡账单最高得620元还款券")
    }.width('100%').padding({left: 5})
    // 消息卡片底部
    Row(){
      Text("查看详情")
      Image($r('app.media.right')).width(20)
    }.width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({top: 10})
  }.backgroundColor('white').padding(10)
    .margin({bottom: 20})
}

  @Builder
  buildTabContent() {
    Column() {
      ForEach(this.messages, (item: IMessage) => {
        this.messageItem(item)
      }, item => item.id)
    }.height('100%')
  }
  private tabController1 = new TabsController();
  private tabController2 = new TabsController();
  build() {
    Column() {
      PageTitle({title: "消息"})
      Column() {
        Tabs({barPosition: BarPosition.Start, controller: this.tabController1}){
          TabContent() {
            Tabs({barPosition: BarPosition.Start, controller: this.tabController2}){
              TabContent() {
                Column() {
                  ForEach(this.messages, (item: IMessage) => {
                    this.messageItem(item)
                  }, item => item.id)
                }.height('100%')
              }.tabBar("全部消息")
              TabContent() {
                Column() {
                  ForEach(this.messages, (item: IMessage) => {
                    this.messageItem(item)
                  }, item => item.id)
                }.height('100%')
              }.tabBar("优惠资讯")
              TabContent() {
                Column() {
                  ForEach(this.messages, (item: IMessage) => {
                    this.messageItem(item)
                  }, item => item.id)
                }.height('100%')
              }.tabBar("服务通知")
            }.onChange(idx => {
              // promptAction.showToast({message: idx.toString()})
              // this.loadData();
            })
          }.tabBar("最新消息")
          TabContent() {
            Text('关注列表')
          }.tabBar("关注列表")
        }
      }.padding(10).backgroundColor('#efefef')
    }
  }
}