import { ITrack } from "../../models/Track";

interface ITrackCallbacks {
  onTrackSelected?: (track: ITrack) => void;
  onPlayPause?: () => void;
}

export class TrackCallbacks implements ITrackCallbacks {
  onTrackSelected?: (track: ITrack) => void;
  onPlayPause?: () => void;

  constructor(params: ITrackCallbacks) {
    this.onTrackSelected = params.onTrackSelected;
    this.onPlayPause = params.onPlayPause;
  }
}
