import ShopCart from '../views/ShopCart'

@Entry
@Component
struct ShopCartPage {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        ShopCart()
      }
      .width('100%')
    }
    .height('100%')
  }
}