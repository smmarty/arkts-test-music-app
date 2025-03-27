import { window } from "@kit.ArkUI";

import { SelectedTheme, themesRecord } from "../../shared/theme";

@Component
export struct ThemeContext {
  @BuilderParam content: () => void
  @StorageLink('SelectedTheme') @Watch('updateTheme') _selectedTheme: SelectedTheme = SelectedTheme.Light;
  @Provide activeTheme: CustomTheme = themesRecord[this._selectedTheme];

  aboutToAppear(): void {
    this._updateStatusBarColors();
  }

  updateTheme(_propName: string): void {
    this.activeTheme = themesRecord[this._selectedTheme];
    this._updateStatusBarColors();
  }

  private _updateStatusBarColors() {
    const windowClass = AppStorage.get<window.Window>('windowClass') as window.Window;
    windowClass.setWindowSystemBarProperties({
      statusBarColor: this.activeTheme.colors?.backgroundPrimary?.toString(),
      statusBarContentColor: this.activeTheme.colors?.fontPrimary?.toString(),
    });
  }

  build() {
    WithTheme({ theme: this.activeTheme }) {
      this.content()
    }
  }
}
