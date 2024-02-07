import dataRdb from '@ohos.data.relationalStore';
import { CommonConstants as Const } from '../../constants/CommonConstants';
import RdbUtils from '../Rdb/RdbUtils';
import Logger from '../../utils/Logger';

const mock = [
  {
    id: 1,
    title: '优惠助手',
    desc: '点击即领还款券，最高得620元，信用卡还款0手续费',
    type: 0,
  }
];

interface IPaginationData {
  list: any[];
  count: number;
}

class TaskInfoApi {
  insert(params) {
    return RdbUtils.insert('messageInfo', params)
  }
  update() {}
  query(): Promise<IPaginationData> {
    return RdbUtils.queryAll("messageInfo").then(resultSet => {
      const count = resultSet.rowCount;
      resultSet.goToFirstRow();
      const result = []
      for (let i = 0; i < count; i++) {
        let tmp: any = {};
        tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
        tmp.title = resultSet.getString(resultSet.getColumnIndex('title'));
        tmp.desc = resultSet.getString(resultSet.getColumnIndex('desc'));
        tmp.type = resultSet.getDouble(resultSet.getColumnIndex('type'));
        result[i] = tmp;
        resultSet.goToNextRow();
      }
      return {list: result, count}
    })
  }
}

export default new TaskInfoApi();