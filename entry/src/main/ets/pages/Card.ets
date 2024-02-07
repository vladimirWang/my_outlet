// import CardListItem from '../components/CardListItem'
import CardInfoApi from '../common/database/tables/CardInfoApi'
import PageTitle from '../components/PageTitle'
import router from'@ohos.router'
import {cardStars} from '../common/utils/helper'
import promptAction from '@ohos.promptAction'

@Styles function pagePadding() {
  .padding(10)
}

interface ICard {
  no: string;
  bankId?: number;
}

class MyDataSource {
  private list: Resource[] = []
  private listener: DataChangeListener

  constructor(list: Resource[]) {
    this.list = list
    this.listener = null;
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): any {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener
  }

  unregisterDataChangeListener() {
    this.listener = null;
  }
}



@Entry
@Component
export struct Card {
  private swiperController: SwiperController = new SwiperController();
  @State cardLength: number = 0;
  @State cards: any[] = [
    // {
    //   cardNo: '6512000011112222',
    //   id: 1,
    //   bankName: '招商银行'
    // },
    // {
    //   no: '6512000011112223',
    //   bankId: 2
    // },
    // {
    //   no: '6512000011112224',
    //   bankId: 2
    // },
    // {
    //   no: '6512000011112225',
    //   bankId: 1
    // },
  ]
  private data: MyDataSource = new MyDataSource([])

  loadSwiper() {
    const list = [
      $r('app.media.dessert'),
      $r('app.media.mickey'),
      $r('app.media.singapore')
    ]
    this.data = new MyDataSource(list)
  }

  async loadCards() {
    try {
      const {list, count} = await CardInfoApi.query();
      this.cards = list;
      this.cardLength = count;
      // promptAction.showToast({message: '123123'})
    } catch (e) {
      promptAction.showToast({message: e.message})
    }
  }
  aboutToAppear(): void {
    this.loadSwiper();
    this.loadCards();
  }

  @Builder MySwiper() {
    Swiper(this.swiperController) {
      LazyForEach(this.data, (item: Resource) => {
        Row(){
          Image(item).objectFit(ImageFit.Contain)
        }.width('100%').height(200)
      }, (item, idx) => idx.toString())
    }
    .margin({bottom: 10})
    .cachedCount(2)
    .index(1)
    .autoPlay(true)
    .interval(4000)
    .indicator(true)
    .loop(true)
    .duration(1000)
    .itemSpace(0)
    .curve(Curve.Linear)
    .onChange((index: number) => {
      console.info(index.toString())
    })
  }

  @Builder CardListItem(item) {
    Row() {
      Image($r('app.media.bankCard'))
        .width(120)
        .height(80)
        .margin({right: 20})
      Column() {
        Text(item.bankName)
          .fontWeight(FontWeight.Bold)
        Text(cardStars(item.cardNo))
      }.alignItems(HorizontalAlign.Start)
    }.justifyContent(FlexAlign.Start)
    .padding({left: 10, right: 10, top: 5, bottom: 5})
    .backgroundColor("#efdcde")
    .margin({bottom: 8})
    // .backgroundColor("blue")
    .width("100%")
  }

  build() {
    Column() {
      PageTitle({title: '卡包'})
      // 银行卡
      Column() {
        this.MySwiper()

        Row() {
          Text(`银行卡 (${this.cardLength})`)
            .width(200)
            .fontWeight(FontWeight.Bold)
            .fontSize(20)
            // .backgroundColor("green")
          Image($r('app.media.plus'))
            .width(20)
            .height(20)
            .onClick(() => {
              router.pushUrl({url: 'pages/AddCard'})
            })
        }.justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .padding({top: 10, bottom: 10})
        ForEach(this.cards, (item) => {
          this.CardListItem(item)
        }, (item) => item.id)
        Button({type: ButtonType.Normal}){
          Row() {
            Image($r('app.media.add_btn'))
              .margin({right: 10})
              .width(16).height(16)
            Text('添加银行卡').fontColor($r('app.color.dark_red')).fontWeight(FontWeight.Bold)
          }.padding({top: 10, bottom: 10}).backgroundColor($r('app.color.btn_bg_color'))
          .width('100%').justifyContent(FlexAlign.Center)

        }
          .width('100%')
          .onClick(() => {
            router.pushUrl({url: 'pages/AddCard'})
          })
        Button('去首页', {type: ButtonType.Normal}).width('100%')
          .backgroundColor($r('app.color.btn_bg_color')).margin({top: 10}).fontColor('white').onClick(() => {
          router.pushUrl({url: 'pages/Index'})
        })
      }.pagePadding()
      .width('100%')
      .height('100%')
    }
  }
}