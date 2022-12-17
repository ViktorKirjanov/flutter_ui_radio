import 'package:flutter_ui_radio/models/links_model.dart';
import 'package:flutter_ui_radio/models/station_model.dart';
import 'package:flutter_ui_radio/models/stations_response_model.dart';

const stations = [
  Station(
    id: 'ps.106614797',
    href: 'https://api.napster.com/v2.2/stations/ps.106614797',
    name: 'EDM Central',
    description:
        'Electro-house, trance, dubstep and more\nThe biggest tunes from the biggest festivals\nTracks for rocking the big tent\nClub peaktime comes to your living room\nEDM nonstop',
    summary: 'The hottest in EDM and crossover dance music.',
    artists: 'Avicii, Swedish House Mafia, Deadmau5',
    links: Links(
      mediumImage: Link(
        href: 'http://static.rhap.com/img/150x100/7/8/2/6/4126287_150x100.jpg',
      ),
      largeImage: Link(
        href: 'http://static.rhap.com/img/356x237/7/8/2/6/4126287_356x237.jpg',
      ),
    ),
  )
];

const stationsResponse = StationsResponse(
  stations: stations,
  meta: Meta(
    totalCount: 2,
    returnedCount: 1,
  ),
);
