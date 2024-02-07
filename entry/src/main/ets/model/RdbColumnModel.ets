import ColumnInfo from '../viewmodel/ColumnInfo';

export const columnMessageInfoList: Array<ColumnInfo> = [
  new ColumnInfo('id', 'integer', -1, true, true, false),
  new ColumnInfo('type', 'integer', -1, true, false, false),
  new ColumnInfo('title', 'text', -1, true, false, false),
  new ColumnInfo('desc', 'text', -1, false, false, false)
]

export const columnCardInfoList: Array<ColumnInfo> = [
  new ColumnInfo('id', 'integer', -1, true, true, false),
  new ColumnInfo('cardNo', 'text', -1, true, false, false),
  new ColumnInfo('bankName', 'text', -1, true, false, false),
  // new ColumnInfo('desc', 'text', -1, false, false, false)
]
