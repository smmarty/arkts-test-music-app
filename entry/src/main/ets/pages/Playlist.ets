import { media } from "@kit.MediaKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { audio } from "@kit.AudioKit";

import { Header, HeaderCallbacks } from "../feature/components/Header";
import { TrackCallbacks, TrackItem } from "../feature/components/Track";
import { ITrack } from "../feature/models/Track";
import { SelectedTheme } from "../feature/shared/theme";

PersistentStorage.persistProp('SelectedTheme', SelectedTheme.Light);

@Component
struct PlaylistPage {
  @StorageProp('SelectedTheme') selectedTheme: SelectedTheme = SelectedTheme.Light;
  @Consume('activeTheme') activeTheme: CustomTheme;
  @State playlist: ITrack[] = [
    {
      "id": "1",
      "title": "Phantom Skating",
      "artist": "The Flex Collective",
      "duration": "3:58",
      "url": "http://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8",
      "albumArt": "app.media.skate_album",
    },
    {
      "id": "2",
      "title": "Adaptive Test Groove",
      "artist": "Longtail Beats",
      "duration": "4:22",
      "url": "http://playertest.longtailvideo.com/adaptive/wowzaid3/playlist.m3u8",
      "albumArt": "app.media.adaptive_album",
    },
    {
      "id": "3",
      "title": "Brazilian Sample Waves",
      "artist": "RBS Sessions",
      "duration": "5:15",
      "url": "http://cdn-fms.rbs.com.br/vod/hls_sample1_manifest.m3u8",
      "albumArt": "app.media.brazil_album",
    }
  ];
  @State currentTrack: ITrack | undefined = undefined;
  @State isPlaying: boolean = false;

  private _pathStack: NavPathStack = new NavPathStack()
  private _headerCallbacks = new HeaderCallbacks({
    navigateBack: () => {
      this._pathStack.pop();
    }
  });

  private _trackCallbacks = new TrackCallbacks({
    onTrackSelected: async (track: ITrack) => {
      if (this._avPlayer) {
        if (this.currentTrack?.id === track.id) {
          this.currentTrack = undefined;
          this.isPlaying = false;
          await this._avPlayer.reset();
        } else {
          this.currentTrack = track;
          this.isPlaying = true;
          this._avPlayer.url = track.url;
          await this._avPlayer.play();
        }
      }
    },
  });

  private _avPlayer?: media.AVPlayer;

  async aboutToAppear(): Promise<void> {
    this._avPlayer = await media.createAVPlayer();
    this.setAVPlayerCallback(this._avPlayer);
  }

  setAVPlayerCallback(avPlayer: media.AVPlayer) {
    avPlayer.on('error', (err: BusinessError) => {
      console.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
      avPlayer.reset();
    });

    avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
      switch (state) {
        case 'initialized':
          avPlayer.audioRendererInfo = {
            usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
            rendererFlags: 0
          };

          avPlayer.prepare();
          break;
        case 'prepared':
          avPlayer.play();
          break;
      }
    });
  }

  build() {
    NavDestination() {
      Column() {
        Header({ headerCallbacks: this._headerCallbacks })
        List({ space: 8 }) {
          ForEach(this.playlist, (item: ITrack) => {
            ListItem() {
              TrackItem({
                track: item,
                isCurrent: this.currentTrack?.id === item.id,
                isPlaying: this.isPlaying && this.currentTrack?.id === item.id,
                trackCallbacks: this._trackCallbacks
              })
            }
          })
        }
        .layoutWeight(1)
        .padding({ top: 24, left: 24, right: 24 })
        .width('100%')
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
