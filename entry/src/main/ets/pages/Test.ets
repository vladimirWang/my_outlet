@Observed
class StringArray extends Array<String> {
}

@Component
struct ItemPage {
  @ObjectLink itemArr: StringArray;

  build() {
    Row() {
      Text('ItemPage')
        .width(100).height(100)

      ForEach(this.itemArr,
        item => {
          Text(item)
            .width(100).height(100)
        },
        item => item
      )
    }
  }
}


@Observed
class Shop {
  constructor(public businessId: string, public business: string) {
  }
}

@Observed
class ShopArr extends Array<Shop> {

}

@Entry
@Component
struct Test {
  @State shops: Array<ShopArr> = [
    [
      new Shop('1', 'nike'),
      new Shop('2', 'puma'),
      new Shop('3', 'lulumon'),
    ],
    [
      new Shop('4', 'nike'),
      new Shop('5', 'puma'),
      new Shop('6', 'lulumon'),
    ],
  ]
  build() {
    Column() {
      Button("update").onClick(() => {
        // this.shops[0].business = "jd"
        this.shops[0].push(new Shop('4', 'adidas'))
      })
      ForEach(this.shops, (item: ShopArr) => {
        ForEach(item, (item2: Shop) => {
          Row() {
            Text(`id: ${item2.businessId}`).margin({right: 20})
            Text(`品牌: ${item2.business}`)
          }
        })
        Text('-----------')
      }, (item, index) => index + '')
    }
  }
}


@Component
struct IndexPage {
  @State arr: Array<StringArray> = [new StringArray(), new StringArray(), new StringArray()];

  build() {
    Column() {
      ItemPage({ itemArr: this.arr[0] })
      ItemPage({ itemArr: this.arr[1] })
      ItemPage({ itemArr: this.arr[2] })

      Divider()

      ForEach(this.arr,
        itemArr => {
          ItemPage({ itemArr: itemArr as StringArray })
        },
        itemArr => itemArr[0]
      )

      Divider()

      Button('update')
        .onClick(() => {
          console.error('Update all items in arr');
          if (this.arr[0][0] !== undefined) {
            // 正常情况下需要有一个真实的ID来与ForEach一起使用，但此处没有
            // 因此需要确保推送的字符串是唯一的。
            this.arr[0].push(`${this.arr[0].slice(-1).pop()}${this.arr[0].slice(-1).pop()}`);
            this.arr[1].push(`${this.arr[1].slice(-1).pop()}${this.arr[1].slice(-1).pop()}`);
            this.arr[2].push(`${this.arr[2].slice(-1).pop()}${this.arr[2].slice(-1).pop()}`);
          } else {
            this.arr[0].push('Hello');
            this.arr[1].push('World');
            this.arr[2].push('!');
          }
        })
    }
  }
}