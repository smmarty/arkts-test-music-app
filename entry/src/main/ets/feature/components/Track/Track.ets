import { ITrack } from "../../models/Track";
import { SelectedTheme } from "../../shared/theme";
import { TrackCallbacks } from "./Track.types";

@Component
export struct TrackItem {
  @StorageLink('SelectedTheme') selectedTheme: SelectedTheme = SelectedTheme.Light;
  @Consume('activeTheme') activeTheme: CustomTheme;
  @Prop track: ITrack;
  @Prop isCurrent: boolean = false;
  @Prop isPlaying: boolean = false;
  @Prop trackCallbacks: TrackCallbacks = new TrackCallbacks({});

  build() {
    Row() {
      Column() {
        Text(this.track.title)
          .fontSize(16)
          .fontColor(this.activeTheme.colors?.fontPrimary)
          .margin({ bottom: 8 })
        Text(`${this.track.artist} • ${this.track.duration}`)
          .fontSize(12)
          .fontColor('#757575')
      }.flexGrow(1)
      Button() {
        Image($r(this.isCurrent && this.isPlaying ? 'app.media.pause' : 'app.media.play'))
          .width(24)
          .height(24)
          .onClick(() => {
            this.trackCallbacks.onTrackSelected?.(this.track);
          })
      }
      .type(ButtonType.Circle)
      .width(32)
      .height(32)
      .padding(4)
      .backgroundColor(this.selectedTheme === SelectedTheme.Light ? this.activeTheme.colors?.brand : "transparent")
      .onClick(() => {
        this.trackCallbacks.onTrackSelected?.(this.track);
      })
    }
    .width("100%")
    .padding(12)
    .margin({ top: 12, bottom: 12 })
    .backgroundColor(this.activeTheme.colors?.backgroundSecondary)
    .onClick(() => {
      this.trackCallbacks.onTrackSelected?.(this.track);
    })
  }
}