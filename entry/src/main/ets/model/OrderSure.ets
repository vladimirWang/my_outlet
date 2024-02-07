import { OrderSureData, CommodityData } from '../viewmodel/OrderSureData'

//地址信息
export const AddressData: OrderSureData =
  new OrderSureData('张', 1888888888, '上海市徐汇区漕河泾开发区科汇大厦')

//商品信息
export const commodityData:Array<CommodityData> =
[
  new CommodityData('ikun官方旗舰店', 'app.media.ic_life_2'
    , '【到手一大盆】ikun可以吃到爆的满满一盆正能量', '60片', '99.00'),
  new CommodityData('ikun官方旗舰店', 'app.media.ic_life_2'
    , '【到手一大盆】ikun可以吃到爆的满满一盆正能量', '60片', '99.00'),
new CommodityData('ikun官方旗舰店', 'app.media.ic_life_2'
  , '【到手一大盆】ikun可以吃到爆的满满一盆正能量', '60片', '99.00')
]

//订单信息