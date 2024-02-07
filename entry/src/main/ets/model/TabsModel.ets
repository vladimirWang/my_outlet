export class TabsBean {
  icon: Resource;
  iconSelected: Resource
  name: string;
}

export class TabsModel {
  getTabList(): TabsBean[] {
    return [
      {
        icon: $r("app.media.Iconly_Bold_Home_3_2x"),
        iconSelected: $r("app.media.Iconly_Bold_Home2x"),
        name: '首页'
      },
      {
        icon: $r("app.media.Iconly_Stroke_life2x"),iconSelected: $r("app.media.Iconly_Bold_life2x"), name: '生活'
      },
      {
        icon: $r("app.media.Iconly_Stroke_Chat2x"),iconSelected: $r("app.media.Iconly_Bold_Chat2x"), name: '消息'
      },
      {
        icon: $r("app.media.Iconly_Stroke_finance2x"),iconSelected: $r("app.media.Iconly_Bold_finance2x"), name: '金融'
      },
      {
        icon: $r("app.media.Iconly_Stroke_Profile2x"),iconSelected: $r("app.media.Iconly_Bold_My2x"), name: '我的'
      }
    ];
  }
}

let mainViewModel = new TabsModel();

export default mainViewModel as TabsModel;