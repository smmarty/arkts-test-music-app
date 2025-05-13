import { ITrack } from "../../models/Track";

interface ITrackCallbacks {
  onTrackSelected?: (track: ITrack) => void;
}

export class TrackCallbacks implements ITrackCallbacks {
  onTrackSelected?: (track: ITrack) => void;

  constructor(params: ITrackCallbacks) {
    this.onTrackSelected = params.onTrackSelected;
  }
}
