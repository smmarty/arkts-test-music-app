import { Feature } from "../feature/components/Feature";
import { Header } from "../feature/components/Header";
import { ThemeContext } from "../feature/context/ThemeContext";
import { SelectedTheme } from "../feature/shared/theme";

PersistentStorage.persistProp('SelectedTheme', SelectedTheme.Light);

@Component
struct IndexPage {
  @StorageProp('SelectedTheme') selectedTheme: SelectedTheme = SelectedTheme.Light;
  @Consume('activeTheme') activeTheme: CustomTheme;
  private _pathStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this._pathStack) {
      Column() {
        Header()
        Column() {
          Text("Welcome to Harmony")
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .margin({ bottom: 12 })
          Text("Your personal music companion")
            .fontSize(18)
            .textAlign(TextAlign.Center)
            .margin({ bottom: 40 })
          Column({ space: 20 }) {
            Feature({
              assetIconPath: "app.media.note",
              text: "Discover new music",
            })
            Feature({
              assetIconPath: "app.media.sync",
              text: "Sync across all your devices",
            })
            Feature({
              assetIconPath: "app.media.palette",
              text: "Customizable interface",
            })
          }
          .width("100%")
          .margin({ bottom: 40 })

          Button('Next')
            .fontSize(30)
            .type(ButtonType.Capsule)
            .width('33%')
            .height('7.5%')
            .onClick(() => {
              this._pathStack.pushPathByName("Playlist", null);
            })
        }
        .width('100%')
        .height("100%")
        .justifyContent(FlexAlign.Center)
        .padding({ bottom: 56 })
      }
      .height('100%')
      .backgroundColor(this.activeTheme.colors?.backgroundPrimary)
      .expandSafeArea([SafeAreaType.SYSTEM],
        [SafeAreaEdge.TOP, SafeAreaEdge.END, SafeAreaEdge.BOTTOM, SafeAreaEdge.START])
    }
    .mode(NavigationMode.Stack)
    .hideToolBar(true)
  }
}

@Entry
@Component
struct Index {
  @Builder _buildPage() {
    IndexPage()
  }

  build() {
    Column() {
      ThemeContext({
        content: this._buildPage,
      })
    }
  }
}
