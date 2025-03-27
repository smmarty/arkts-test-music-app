import { media } from '@kit.MediaKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { audio } from '@kit.AudioKit';

@Component
export struct MusicPlayer {
  private count: number = 0;
  private isSeek: boolean = true;
  private fileSize: number = -1;
  private fd: number = 0;

  async aboutToAppear(): Promise<void> {
    const avPlayer: media.AVPlayer = await media.createAVPlayer();
    this.setAVPlayerCallback(avPlayer);
    this.isSeek = false;
    avPlayer.url = 'http://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8';
  }

  setAVPlayerCallback(avPlayer: media.AVPlayer) {
    avPlayer.on('seekDone', (seekDoneTime: number) => {
      console.info(`AVPlayer seek succeeded, seek time is ${seekDoneTime}`);
    });

    avPlayer.on('error', (err: BusinessError) => {
      console.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
      avPlayer.reset();
    });

    avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
      switch (state) {
        case 'idle':
          console.info('AVPlayer state idle called.');
          avPlayer.release();
          break;
        case 'initialized':
          console.info('AVPlayer state initialized called.');
          avPlayer.audioRendererInfo = {
            usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
            rendererFlags: 0
          };

          avPlayer.prepare();
          break;
        case 'prepared':
          console.info('AVPlayer state prepared called.');
          avPlayer.play();
          break;
        case 'playing':
          console.info('AVPlayer state playing called.');
          if (this.count !== 0) {
            if (this.isSeek) {
              console.info('AVPlayer start to seek.');
              avPlayer.seek(avPlayer.duration);
            } else {
              console.info('AVPlayer wait to play end.');
            }
          } else {
            setTimeout(() => {
              console.info('AVPlayer is playing wait to pause');
              avPlayer.pause();
            }, 3000);
          }

          this.count++;
          break;
        case 'paused':
          console.info('AVPlayer state paused called.');
          setTimeout(() => {
            console.info('AVPlayer paused wait to play again');
            avPlayer.play();
          }, 3000);
          break;
        case 'completed':
          console.info('AVPlayer state completed called.');
          avPlayer.stop();
          break;
        case 'stopped':
          console.info('AVPlayer state stopped called.');
          avPlayer.reset();
          break;
        case 'released':
          console.info('AVPlayer state released called.');
          break;
        default:
          console.info('AVPlayer state unknown called.');
          break;
      }
    });
  }

  build() {
    Column() {
      Button("Start playback")
        .margin({ top: 24 })
    }
  }
}