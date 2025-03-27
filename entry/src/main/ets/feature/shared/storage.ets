import { SelectedTheme } from "./theme";

@ObservedV2
export class Storage {
  @Trace selectedTheme: SelectedTheme = SelectedTheme.Light;
}
