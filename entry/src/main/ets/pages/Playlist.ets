import { Header } from "../feature/components/Header";
import { SelectedTheme } from "../feature/shared/theme";

PersistentStorage.persistProp('SelectedTheme', SelectedTheme.Light);

@Component
struct PlaylistPage {
  @StorageProp('SelectedTheme') selectedTheme: SelectedTheme = SelectedTheme.Light;
  @Consume('activeTheme') activeTheme: CustomTheme;
  private _pathStack: NavPathStack = new NavPathStack()

  private _navigateBack() {
    this._pathStack.pop();
  }

  build() {
    NavDestination() {
      Column() {
        Header()

      }
      .height('100%')
      .backgroundColor(this.activeTheme.colors?.backgroundPrimary)
      .expandSafeArea([SafeAreaType.SYSTEM],
        [SafeAreaEdge.TOP, SafeAreaEdge.END, SafeAreaEdge.BOTTOM, SafeAreaEdge.START])
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this._pathStack = context.pathStack;
    })
  }
}

@Component
struct Playlist {
  @Builder _buildPage() {
    PlaylistPage()
  }

  build() {
    this._buildPage()
  }
}

@Builder
export function PlaylistBuilder() {
  Playlist()
}
