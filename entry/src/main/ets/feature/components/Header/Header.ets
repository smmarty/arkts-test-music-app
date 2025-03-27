import { oppositeThemes, SelectedTheme } from "../../shared/theme";
import { HeaderCallbacks } from "./Header.types";

const iconThemeButtons: Record<SelectedTheme, string> = {
  [SelectedTheme.Light]: "app.media.dark_mode",
  [SelectedTheme.Dark]: "app.media.light_mode",
};

@Component
export struct Header {
  @StorageLink('SelectedTheme') selectedTheme: SelectedTheme = SelectedTheme.Light;
  @Consume('activeTheme') activeTheme: CustomTheme;
  @Prop headerCallbacks: HeaderCallbacks = new HeaderCallbacks({});

  private _toggleTheme() {
    this.selectedTheme = oppositeThemes[this.selectedTheme];
  }

  build() {
    Row() {
      if (this.headerCallbacks.navigateBack) {
        Button() {
          Image($r("app.media.back_arrow"))
            .width(24)
            .height(24)
            .margin({ right: 8 })
        }
        .type(ButtonType.Circle)
        .width(32)
        .height(32)
        .padding(4)
        .backgroundColor(this.selectedTheme === SelectedTheme.Light ? this.activeTheme.colors?.brand : "transparent")
        .onClick(() => {
          this.headerCallbacks.navigateBack?.();
        })
      }
      Text("Harmony").fontSize(20).fontWeight(FontWeight.Bold)
      Button() {
        Image($r(iconThemeButtons[this.selectedTheme])).width(24).height(24)
      }
      .type(ButtonType.Circle)
      .width(32)
      .height(32)
      .backgroundColor(this.selectedTheme === SelectedTheme.Light ? this.activeTheme.colors?.brand : "transparent")
      .onClick(() => {
        this._toggleTheme();
      })
    }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 10, left: 20, bottom: 15, right: 20 })
      .border({
        width: {
          bottom: 1,
        },
        color: `${this.activeTheme.colors?.fontPrimary}${this.selectedTheme === SelectedTheme.Light ? "CC" : ""}`,
        style: BorderStyle.Solid,
      })
      .shadow({ radius: 10, color: Color.Gray })
  }
}
