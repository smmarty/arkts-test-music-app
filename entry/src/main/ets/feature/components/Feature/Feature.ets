import { SelectedTheme } from "../../shared/theme";

@Component
export struct Feature {
  @StorageLink('SelectedTheme') selectedTheme: SelectedTheme = SelectedTheme.Light;
  @Consume('activeTheme') activeTheme: CustomTheme;
  @Prop assetIconPath: string;
  @Prop text: string;

  build() {
    Row() {
      Image($r(this.assetIconPath)).width(24).height(24).margin({ right: 15 })
      Text(this.text).fontSize(16).fontWeight(FontWeight.Medium)
    }
      .alignItems(VerticalAlign.Center)
      .padding(15)
      .borderRadius(10)
      .border({
        width: {
          left: 4,
        },
        color: this.activeTheme.colors?.brand,
      })
      .backgroundColor(this.activeTheme.colors?.backgroundSecondary)
      .width(300)
  }
}
