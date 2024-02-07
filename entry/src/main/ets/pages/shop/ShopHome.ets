import TabBar from './components/tabBar'
import router from '@ohos.router';

@Entry
@Component
struct ShopHome {
  @State message: string = 'Hello World'

  @State tabIndexNum: number = 0;
  @State currentIndex: number = 0;

  aboutToAppear(){
    // if(!router){
    //   let tabIndexNum = (router.getParams() as any).tabIndexNum;
    //   this.tabIndexNum = tabIndexNum;
    // }
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