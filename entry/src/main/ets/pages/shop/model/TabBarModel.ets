export class TabBean {
  icon: Resource;
  name: string;
}

class TabBarModel {
  getTabList(): TabBean[] {
    return [
      {
        icon: $r('app.media.home'), name: '首页'
      },
      {
        icon: $r('app.media.category'), name: '分类'
      },
      {
        icon: $r('app.media.cart_empty_fill'), name: '购物车'
      },
      {
        icon: $r('app.media.customer_fill'), name: '我的'
      }
    ];
  }
}

let mainViewModel = new TabBarModel();

export default mainViewModel as TabBarModel;