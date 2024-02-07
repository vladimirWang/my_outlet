import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import RdbUtils from '../common/database/rdb/RdbUtils';
import Logger from '../common/utils/Logger';
import {columnMessageInfoList, columnCardInfoList} from '../model/RdbColumnModel';
import {columnShopCarInfoList} from '../model/ShopCarModel';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    RdbUtils.initDb(this.context, 'database');
    await RdbUtils.createDb();

    RdbUtils.createTable('cardInfo', columnCardInfoList).then(() => {
      Logger.info(`RdbHelper createTable dayInfo success`);
    }).catch((err: Error) => {
      Logger.error(`RdbHelper dayInfo err : ${JSON.stringify(err)}`);
    });

    RdbUtils.createTable('messageInfo', columnMessageInfoList).then(() => {
      Logger.info(`RdbHelper createTable dayInfo success`);
    }).catch((err: Error) => {
      Logger.error(`RdbHelper dayInfo err : ${JSON.stringify(err)}`);
    });

    RdbUtils.createTable('shopCarInfo', columnShopCarInfoList).then(() => {
      Logger.info(`RdbHelper createTable shopCarInfo success`);
    }).catch((err: Error) => {
      Logger.error(`RdbHelper dayInfo err : ${JSON.stringify(err)}`);
    });

    // pages/shop/components/page/ShopCartDetail GoodsDetail/GoodsDetailPage
    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
