interface IHeaderCallbacksParams {
  navigateBack?: () => void;
}

export class HeaderCallbacks implements IHeaderCallbacksParams {
  navigateBack?: () => void;

  constructor(params: IHeaderCallbacksParams) {
    this.navigateBack = params.navigateBack;
  }
}
