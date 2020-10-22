import 'package:flutter/material.dart';
import 'package:sound_on_fire/components/track_tile.dart';
import 'package:sound_on_fire/models/Track.dart';

const appTitle = "SoundOnFire";

var customTheme = ThemeData(
  primarySwatch: primaryMaterialColor,
  sliderTheme: SliderThemeData(
    disabledThumbColor: primaryOrange,
    disabledActiveTrackColor: primaryOrange,
    disabledInactiveTrackColor: primaryOrange.withOpacity(0.24),
  ),
);

const MaterialColor primaryMaterialColor = const MaterialColor(
  0xffff5500,
  const <int, Color>{
    50: const Color(0xffff5500),
    100: const Color(0xffff5500),
    200: const Color(0xffff5500),
    300: const Color(0xffff5500),
    400: const Color(0xffff5500),
    500: const Color(0xffff5500),
    600: const Color(0xffff5500),
    700: const Color(0xffff5500),
    800: const Color(0xffff5500),
    900: const Color(0xffff5500),
  },
);
const primaryOrange = Color(0xffff5500);
var lightGrey = Colors.grey[200];
var lighterGrey = Colors.grey[100];
const soundCloudHost = "https://soundcloud.com";
const soundCloudApiHost = "https://api-v2.soundcloud.com";

List<TrackTile> shimmerTrackTiles = [
  TrackTile(
    isLoading: true,
    track: null,
    onClick: null,
  ),
  TrackTile(
    isLoading: true,
    track: null,
    onClick: null,
  ),
  TrackTile(
    isLoading: true,
    track: null,
    onClick: null,
  ),
  TrackTile(
    isLoading: true,
    track: null,
    onClick: null,
  ),
  TrackTile(
    isLoading: true,
    track: null,
    onClick: null,
  ),
  TrackTile(
    isLoading: true,
    track: null,
    onClick: null,
  ),
];
