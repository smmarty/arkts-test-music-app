import { CustomColors, CustomTheme } from '@kit.ArkUI'

export class AppDarkColors implements CustomColors {
  backgroundPrimary: ResourceColor = '#121212';
  backgroundSecondary: ResourceColor = '#1e1e1e';
  brand: ResourceColor = '#7b2cbf';
  fontPrimary: ResourceColor = '#ffffff';
  fontSecondary: ResourceColor = '#b3b3b3';
  fontOnTertiary: ResourceColor = '#282828';
}

export class AppLightColors implements CustomColors {
  backgroundPrimary: ResourceColor = '#f5f5f5';
  backgroundSecondary: ResourceColor = '#ffffff';
  brand: ResourceColor = '#7b2cbf';
  fontPrimary: ResourceColor = '#121212';
  fontSecondary: ResourceColor = '#4a4a4a';
  fontOnTertiary: ResourceColor = '#f0f0f0';
}

export class AppDarkTheme implements CustomTheme {
  public colors: AppDarkColors = new AppDarkColors()
}

export class AppLightTheme implements CustomTheme {
  public colors: AppLightColors = new AppLightColors()
}

export enum SelectedTheme {
  Light = "Light",
  Dark = "Dark",
}

export const themesRecord: Record<SelectedTheme, CustomTheme> = {
  [SelectedTheme.Light]: new AppLightTheme(),
  [SelectedTheme.Dark]: new AppDarkTheme(),
};

export const oppositeThemes: Record<SelectedTheme, SelectedTheme> = {
  [SelectedTheme.Light]: SelectedTheme.Dark,
  [SelectedTheme.Dark]: SelectedTheme.Light,
};
