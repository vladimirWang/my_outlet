import common from '@ohos.app.ability.common';
import dataPreferences from '@ohos.data.preferences';
import { CommonConstants as Const } from '../common/constants/CommonConstants';
import Notification from '@ohos.notificationManager';
import Logger from '../common/utils/Logger';
import router from '@ohos.router';
import {sleep} from '../common/utils/helper'

function hidePhoneNumber(phoneNumber) {
  // 检查手机号是否合法
  if (/^\d{11}$/.test(phoneNumber)) {
    // 将手机号中间四位替换为星号
    return phoneNumber.replace(/(\d{3})\d{4}(\d{4})/, '$1****$2');
  } else {
    // 手机号格式不正确，返回原手机号
    return phoneNumber;
  }
}

@Component
export default struct My {
  @State account: string = '';
  private context = getContext(this) as common.UIAbilityContext;
  private preferences: dataPreferences.Preferences = null;
  private swiperColumnController: SwiperController = new SwiperController()

  @State hyList : String[] = [
    '专享特权',
    '超值兑换',
    '月月领',
    '我的积点',
    '我的特权',
    '1元微信券',
    '6元回本券',
    '12'
  ]

  @State newsList : String[] = [
    '开通62VIP年省3874元',
    '工行、移动积分兑换现金红包，笔笔抵扣'
  ]

  @State iconList: any = [
    { icon: $r('app.media.kgl2x'), name: '管家' ,rui:''},
    { icon: $r('app.media.zz2x'), name: '账单' ,rui:''},
    { icon: $r('app.media.Frame2x'), name: '借款' ,rui:''},
    { icon: $r('app.media.kgl2x'), name: '信用报告' ,uri:''},
    { icon: $r('app.media.lkh2'), name: '奖励' ,uri:''},
    { icon: $r('app.media.sc2x'), name: '积分' ,uri:''}
  ]

  aboutToAppear() {
    try {
      dataPreferences.getPreferences(this.context, Const.H_STORE, (err, preferences) => {
        if (!err) {
          this.preferences = preferences;

          this.preferences.get(Const.USER_ACCOUNT_KEY, '', (err, val) => {
            if (err) {
              // AlertDialog.show({ message: "读取失败：" });
              return;
            }
            this.account = hidePhoneNumber(val);
          });
        }
      })
    } catch (err) {
      Logger.error(`Failed to get preferences. Code:${err.code},message:${err.message}`);
    }
  }

  loginOut(): void {
    // 退出登录后将用户信息从首选项中删除
    try {
      dataPreferences.getPreferences(this.context, Const.H_STORE, (err, preferences) => {
        if (!err) {
          this.preferences = preferences;

          this.preferences.delete(Const.USER_ACCOUNT_KEY, (err) => {
            if (err) {
              Logger.error("Failed to delete the key '%s'. code =" + err.code + ", message =" + err.message, Const.USER_ACCOUNT_KEY);
              return;
            }
            this.preferences.flush();
            Logger.info("Succeeded in deleting the key '%s'.", Const.USER_ACCOUNT_KEY);
            Notification.cancelAll();
            // this.context.terminateSelf();
            router.clear();
            setTimeout(() => {
              router.replaceUrl({
                url: 'pages/Login'
              })
            }, 1500)
          })
        }
      })
    } catch (err) {
      Logger.error(`Failed to put preferences. Code:${err.code},message:${err.message}`);
    }
  }

  build() {
    Stack({alignContent: Alignment.Top}) {
      Column() {
        // 首行
        Row() {
          Column() {
            Row() {
              Image($r('app.media.ic_safe'))
                .width(20)
                .height(20)
              Text('消费者权益保护中心')
                .fontSize(15)
                .fontColor(Color.White)
                .margin({ left: 6 })
              Image($r('app.media.ic_right_white'))
                .width(25)
                .height(25)
            }
            .backgroundColor('#ffee5555')
            .borderRadius(15)
            .width(200)
            .height(30)
            .padding(8)
            .margin({ left: 20})
          }
          .justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Center)
          .width('50%')

          Column() {
            Row() {
              Image($r('app.media.ic_customer_service'))
                .width(30)
                .height(30)
                .margin({ left: 50 })
              Image($r('app.media.ic_settings'))
                .width(30)
                .height(30)
                .margin({ left: 15 })
            }
          }
          .width('50%')
          .justifyContent(FlexAlign.Center)
        }
        .margin({ left:10, top: 20})

        // 个人信息
        Row(){
          Column() {
            Image($r('app.media.ic_my'))
              .width(80)
              .height(80)
          }
          .width('15%')
          .margin({ left:10})

          Column() {
            Text(this.account || hidePhoneNumber('19988887777'))
              .fontSize(20)
              .fontWeight(600)
              .margin({ bottom: 6})
            Button('个人中心 ＞')
              .backgroundColor('#fff5f2f2')
              .fontColor(Color.Black)
              .fontSize(12)
              .height(30)
              .width(100)
          }
          .flexGrow(1)
          // .backgroundColor('green')
          .justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Start)
          .width('50%')
          .margin({ left:10})

          Column() {
            Button('签到')
              .fontColor(Color.Red)
              .fontWeight(400)
              .backgroundColor(Color.White)
              .width(80)
              .margin({right:10})
          }
          .justifyContent(FlexAlign.End)
          .width('30%')
        }
        .justifyContent(FlexAlign.Start)
        .height(100)
        .width('100%')
        .margin({ top: 10 })

        // 会员
        Column() {
          Row() {
            Text('升级62VIP会员')
              .fontColor('#ffefc864')
              .fontWeight(900)
              .margin({ left: 10 })
            Text('去开通 ＞')
              .margin({ left: 130 })
              .fontColor('#ffefc864')
          }
          .width('100%')
          .height(20)
          .margin({ top: 15 })

          Row() {
            Grid() {
              ForEach(this.hyList, (str: string) => {
                GridItem() {
                  Text(str)
                    .fontSize(12)
                    .fontColor('#ffefc864')
                    .fontWeight(600)
                    .backgroundColor('#ffee4b4b')
                    .width('100%')
                    .height('100%')
                    .textAlign(TextAlign.Center)
                }
              }, str => str)
            }
            .columnsTemplate('1fr 1fr 1fr 1fr')
            .rowsTemplate('1fr 1fr')
            .columnsGap(1)
            .width('100%')
            .backgroundColor(0xFAEEE0)
          }
          .margin({ top: 10 })
          .width('100%')
          .height(40)
        }
        .height(100)
        .width('100%')
        .backgroundColor('#ffee4b4b')
        .borderRadius(20)

        // 通知消息
        Row() {
          Image($r('app.media.ic_loudspeaker_r'))
            .width(30)
            .height(30)
            .margin({ left: 10 })
          Swiper(this.swiperColumnController) {
            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(this.newsList, (str, index) => {
                Flex({
                  justifyContent: FlexAlign.Start,
                  alignItems: ItemAlign.Center,
                  direction: FlexDirection.Row
                }) {
                  Row() {
                    Text(str)
                      .fontSize(17)
                      .fontColor('#901505')
                      .height(30)
                      .textAlign(TextAlign.Center)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .padding(6)
                  }
                  .height(50)
                  .width('95%')

                }
              }, str => str)
            }
            // .layoutWeight('100%')
            .height(30)
            // .backgroundColor('#fff')
            // .borderRadius(32)
            .width('80%')
            // .borderWidth(1)
            // .borderColor('#eee')
          }
          // 纵向滑动
          .vertical(true)
          // 不启用导航点指示器
          .indicator(false)
          // 开启循环
          .loop(true)
          // 自动播放
          .autoPlay(true)
          .interval(3000)
          .cachedCount(2)
          // .displayCount(1)
          // .curve(Curve.Ease)
          .duration(4000)

          Image($r('app.media.ic_close_r'))
            .width(20)
            .height(20)
            .margin({ right: 10 })
        }
        .height(50)
        .width('100%')
        .borderWidth(1)
        .borderRadius(10)
        .borderColor('#ffefc864')
        .backgroundColor(Color.White)
        .margin({ top: 20 })

        // 列表
        List() {
          ForEach(this.iconList, (item) => {
            ListItem() {
              Row() {
                Row({ space: 12 }) {
                  Image(item.icon)
                    .width(30)
                    .height(30)
                  Text(item.name)
                    .fontSize($r('app.float.normal_text_size'))
                }

                Image($r('app.media.right'))
                  .width($r('app.float.setting_jump_width'))
                  .height($r('app.float.setting_jump_height'))
              }
              .justifyContent(FlexAlign.SpaceBetween)
              .width('100%')
              .height(50)
              .padding({
                left: $r('app.float.setting_settingCell_left'),
                right: $r('app.float.setting_settingCell_right')
              })
            }
          }, item => JSON.stringify(item))
        }
        .backgroundColor(Color.White)
        .width('100%')
        // .height('42%')
        .divider({
          strokeWidth: $r('app.float.setting_list_strokeWidth'),
          color: Color.Grey,
          startMargin: $r('app.float.setting_list_startMargin'),
          endMargin: $r('app.float.setting_list_endMargin')
        })
        .borderRadius($r('app.float.setting_list_borderRadius'))
        .padding({ top: $r('app.float.setting_list_padding'), bottom: $r('app.float.setting_list_padding') })

        Button('退出登录')
          .fontColor(Color.White)
          .fontWeight(600)
          .backgroundColor(Color.Red)
          .width('70%')
          .type(ButtonType.Normal)
          .margin(50)
          .onClick(() => {
            this.loginOut();
          })
      }
      .width('94%')
      .justifyContent(FlexAlign.Start)
      // .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bg_mine_title_all'))
    .backgroundImageSize(ImageSize.Contain)

  }
}