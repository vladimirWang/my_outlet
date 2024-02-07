@Component
struct Block1 {
  aboutToAppear() {
    console.log('test: Block1 aboutToAppear')
  }

  aboutToDisappear() {
    console.log('test: Block1 aboutToDisappear')
  }
  onPageShow() {
    console.log('test: Block1 onPageShow')
  }
  build() {
    Column() {
      Text("block1").fontSize(30).fontWeight(FontWeight.Bold)
    }
  }
}

@Entry
@Component
struct MyComponent {
  aboutToAppear() {
    console.log('test: MyComponent aboutToAppear')
  }
  aboutToDisappear() {
    console.log('test: MyComponent aboutToDisappear')
  }
  onPageShow() {
    console.log('test: MyComponent MyComponent')
  }

  @State show: boolean = true;

  build() {
    Column() {
      Text(`show: ${this.show}`)
      Toggle({
        type: ToggleType.Checkbox,
        isOn: this.show
      }).onChange(isOn => {
        this.show = isOn;
      })
      if (this.show) {
        Block1().onAppear(() => {
          console.log('test: MyComponent Block1 onAppear')
        })
      }
    }
  }
}