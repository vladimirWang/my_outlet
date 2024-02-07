import TabBar from './components/tabBar'
import router from '@ohos.router';

@Entry
@Component
struct ShopHome1 {
  @State message: string = 'Hello World'

  @State tabIndexNum: number = 0;
  @State currentIndex: number = 0;

  aboutToAppear(){
      let currentIndex = (router.getParams() as any).currentIndex;
      this.currentIndex = currentIndex;
  }

  build() {
    Row() {
      Column() {
        TabBar({tabIndexNum: $tabIndexNum, currentIndex: $currentIndex})
      }
      .width('100%')
    }
    .height('100%')
  }
}