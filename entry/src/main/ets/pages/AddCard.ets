import {Bank} from '../common/types'
import PageTitle from '../components/PageTitle'
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import CardInfoApi from '../common/database/tables/CardInfoApi'
import {sleep} from '../common/utils/helper'

@Styles function pagePadding() {
  .padding(10)
}

@Extend(Text) function boldText() {
  .fontWeight(FontWeight.Bold)
    .fontSize(18)
}

@Extend(Text) function grayText() {
  .fontColor("#999")
  .fontSize(12)
}

const banks = [
  { logo: $r('app.media.huaqi'), name: '招商银行', id: 1, tip: '首绑信用卡限量得5元券'},
  { logo: $r('app.media.huaqi'), name: '花旗银行', id: 2},
  { logo: $r('app.media.huaqi'), name: '农业银行', id: 3},
  { logo: $r('app.media.icbc'), name: '工商银行', id: 4},
  { logo: $r('app.media.pingan'), name: '平安银行', id: 5},
  { logo: $r('app.media.huaqi'), name: '百信银行', id: 6, tip: '首绑借记卡限量得刷卡金'},
  { logo: $r('app.media.huaqi'), name: '天津银行', id: 7},
  { logo: $r('app.media.shanghai'), name: '上海银行', id: 8},
  { logo: $r('app.media.huaqi'), name: '四川银行', id: 9},
  { logo: $r('app.media.huaqi'), name: '黑龙江银行', id: 10},
  { logo: $r('app.media.huaqi'), name: '北京银行', id: 11},
]


@Entry
@Component
struct AddCard {
  // 111112222233333
  @State btnDisabled: boolean = false;
  @State isSubmiting: boolean = false;
  @State cardNo: string = '';
  @State bankList: Bank[] = banks;

  isValid(): boolean {
    const regCardNo = /^[1-9]\d{12,18}$/
    if (this.cardNo.trim() === '') {
      promptAction.showToast({message: '银行卡号不能为空'})
      return false;
    } else if (!regCardNo.test(this.cardNo)) {
      promptAction.showToast({message: '银行卡号格式不正确'})
      return false;
    }
    return true;
  }
  async submit() {
    if (!this.isValid()) return;
    try {
      const rnd = Math.floor(Math.random() * 2000)

      const params = {
        id: rnd,
        bankName: banks[rnd % banks.length].name,
        cardNo: this.cardNo
      }
      this.isSubmiting = true;
      await CardInfoApi.insert(params)
      await sleep();
      this.isSubmiting = false;
      promptAction.showToast({message: '保存成功'})
      await sleep(400)
      router.pushUrl({url: "pages/Card"})
    } catch (e) {
      promptAction.showToast({message: e.message})
    }
  }

  build() {
    // Column() {
    //   PageTitle("添加银行卡")
    // }

    // PageTitle('添加银行卡')
    Column() {
      PageTitle({title: '添加银行卡'})
      Column() {
        // ABuilder("hhhh")
        Row() {
          Column() {
            Text("免输卡号，一键绑卡")
              .margin({bottom: 5})
              .boldText()
            Text('已和一下380家银行合作，可快速绑定')
              .grayText()
          }.flexGrow(1)
          .alignItems(HorizontalAlign.Start)
        Row() {
          Text('查看全部支持银行')
            .fontColor('#4477ff')
            .fontSize(12)
          Image($r('app.media.right'))
            .width(16)
        }.onClick(() => {
          promptAction.showToast({message: '敬请期待', bottom: 400})
        })
            // .width(200)
        }.justifyContent(FlexAlign.SpaceBetween)
        // .backgroundColor("green")
        .width('100%')

        // 银行列表
        Column() {
          ForEach(this.bankList, (bank) => {
            Row() {
              Image(bank.logo)
                .width(20).height(20)
                .margin({right: 15})
              Text(bank.name)
                .fontWeight(FontWeight.Bold)
                .flexGrow(1)
              Text(bank.tip)
                .fontColor($r('app.color.dark_red'))
              Image($r('app.media.right'))
                .width(15)
            }.justifyContent(FlexAlign.Start)
            .width('100%')
            .border({color: '#efefef', width: {
              bottom: 1
            }, style: BorderStyle.Solid})
            .padding(8)
          }, bank => bank.id)
        }.margin({top: 15, bottom: 15})
        // .backgroundColor('green')
        .flexGrow(1)

        Column() {
          Row() {
            Text("输入卡号绑卡")
              .boldText()
              .margin({right: 5})
            Text("支持近2000家银行")
              .fontColor("#999")
          }.justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Bottom)
          .width('100%')
          TextInput({placeholder: '点击输入本人的银行卡号', text: this.cardNo})
            .margin({top: 10, bottom: 5})
            .onChange(value => {
              this.cardNo = value;
            })
          Text('请添加您本人的银行卡,享受更便捷的银联服务')
            .grayText()
            .width('100%')
            .margin({bottom: 20})
          Button({type: ButtonType.Normal}){
            Row() {
              if (this.isSubmiting) {
                Image($r('app.media.loading')).width(20)
                  .margin({right: 10})
              }

              Text("下一步").fontColor('white')

            }.padding({top: 10, bottom: 10})

          }.backgroundColor(this.cardNo === '' ? $r('app.color.shallow_red') : $r('app.color.dark_red'))
            .width('100%')
            .onClick(() => {
              this.submit();
            })
        }.constraintSize({
          minHeight: 200
        })

      }
      .width('100%')
      .height('100%')
      // .backgroundColor('red')
      .pagePadding()
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}