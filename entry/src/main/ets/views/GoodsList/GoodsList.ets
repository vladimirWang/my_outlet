import { RefreshConst } from '../../pages/shop/components/refresh/RefreshConst';
import PageTitle from '../../components/PageTitle';
import router from '@ohos.router';
import {shopCartData2} from '../../pages/shop/mockData'
import DisplayGoodsItemStruct from './components/DisplayGoodsItemStruct'
import promptAction from '@ohos.promptAction';

@Component
@Preview
export default struct GoodsList {

  @State popularRecommendationsList: any = []
  private listController: Scroller = null;

  private itemWidthArray: number[] = []
  private itemHeightArray: number[] = []
  @State maxSize: number = 100
  @State minSize: number = 50


  // 计算flow item宽/高
  getSize() {
    let ret = Math.floor(Math.random() * this.maxSize)
    return (ret > this.minSize ? ret : this.minSize)
  }

  // 保存flow item宽/高
  getItemSizeArray() {
    for (let i = 0; i < 100; i++) {
      this.itemWidthArray.push(this.getSize())
      this.itemHeightArray.push(this.getSize())
    }
  }

  aboutToAppear() {
    this.popularRecommendationsList = shopCartData2;
    // this.getItemSizeArray()
  }

  buildScroller(): Scroller {
    if (this.listController != null) {
      return this.listController
    }
    // new Scroller();
    this.listController = new Scroller();
    return this.listController;
  }

  build() {
    Column() {
      PageTitle({ title: '云闪付商城' })
      WaterFlow() {
        ForEach(this.popularRecommendationsList, (item, index) => {
          FlowItem() {
            DisplayGoodsItemStruct({item})
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/GoodsDetail',
                  params: {
                    param: JSON.stringify(item),
                    id: item.id
                  }
                })
              })
          }
          .width(this.itemWidthArray[index])
          .height(this.itemHeightArray[index])
          .backgroundColor(Color.White)
        }, item => JSON.stringify(item))
      }
      .columnsTemplate("1fr 1fr")
      .itemConstraintSize({
        minWidth: 0,
        maxWidth: '100%',
        minHeight: 0,
        maxHeight: '100%'
      })
      .columnsGap(10)
      .rowsGap(5)
      .onReachStart(() => {
        console.info("onReachStart")
      })
      .onReachEnd(() => {
        // setTimeout(() => {
        //   this.popularRecommendationsList.push(
        //     {
        //       id: '1',
        //       icon: 'ic_home_6_1.png',
        //       name: '华为（HUAWEI）Mate60 Pro 旗舰手机 12GB+512GB 雅丹黑',
        //       price: 7000.00,
        //       sold: '已售:100+',
        //       specifications: '12G+256G',
        //       address: '上海市徐汇区',
        //       business: '珀莱雅官方旗舰店',
        //       businessId: '1',
        //       count: 2,
        //       // selected: false,
        //     },
        //     {
        //       id: '2',
        //       icon: 'ic_home_6_2.png',
        //       name: '汾酒 红盖玻汾 清香型白酒 42度 475mL 6瓶 整箱装',
        //       price: 200.10,
        //       sold: '已售:200+',
        //       specifications: '6瓶',
        //       address: '上海市徐汇区',
        //       business: '山西汾酒官方旗舰店',
        //       businessId: '2',
        //       count: 1,
        //       // selected: false,
        //     },
        //     {
        //       id: '3',
        //       icon: 'ic_home_6_3.png',
        //       name: 'Appleipadpro 2022款苹果平板电脑 未使用 海外版 22款ipad pro11寸 灰色 256G WiFi版 未使用 店保一年',
        //       price: 400.00,
        //       sold: '已售:300+',
        //       specifications: '22款ipad pro 11寸 灰色',
        //       address: '上海市徐汇区',
        //       business: '珀莱雅官方旗舰店',
        //       businessId: '1',
        //       count: 1,
        //       // selected: false,
        //     },
        //     {
        //       id: "4",
        //       icon: 'ic_home_6_4.png',
        //       name: '三星（SAMSUNG）110英寸 Micro LED自发光全倒装 COB封装大屏无边框智能显示屏 家用巨幕 MNA110MS1ACXXZ 一价无忧',
        //       price: 1049.00,
        //       sold: '已售:400+',
        //       specifications: '110英寸Micro LED显示屏',
        //       address: '上海市徐汇区',
        //       business: '珀莱雅官方旗舰店',
        //       businessId: '1',
        //       count: 1,
        //     },
        //     {
        //       id: "5",
        //       icon: 'ic_home_6_5.png',
        //       name: '三星 SAMSUNG 心系天下 W24 16GB+1TB 纳多灰 附S Pen 超闭合折叠 尊奢铰链 轻型化陶瓷 5G折叠屏手机',
        //       price: 159.00,
        //       sold: '已售:500+',
        //       specifications: '享24期免息',
        //       address: '上海市徐汇区',
        //       business: '珀莱雅官方旗舰店',
        //       businessId: '1',
        //       count: 1,
        //     },
        //     {
        //       id: "6",
        //       icon: 'ic_home_6_6.png',
        //       name: '光明纯牛奶250mL*24盒 家庭量贩装 浓醇营养早餐伴侣',
        //       price: 67.80,
        //       sold: '已售:600+',
        //       specifications: '[经典纯奶] 纯牛奶250ml*24',
        //       address: '上海市徐汇区',
        //       business: '珀莱雅官方旗舰店',
        //       businessId: '1',
        //       count: 1,
        //     }
        //   )
        // }, 2000)
      })
      .backgroundColor(0xFAEEE0)
      .width('100%')
      .height('90%')
      .layoutDirection(FlexDirection.Column)
    }
    .width('100%')
    .height('100%')
    .onTouch((event: TouchEvent | undefined) => {
      if (event) {
        // listTouchEvent(event);
      }
    })
  }
}