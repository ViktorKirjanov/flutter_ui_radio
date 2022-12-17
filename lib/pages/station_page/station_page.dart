import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_radio/blocs/cubit/on_off_cubit.dart';
import 'package:flutter_ui_radio/models/station_model.dart';
import 'package:flutter_ui_radio/pages/_widgets/main_size_box.dart';
import 'package:flutter_ui_radio/pages/station_page/_widgets/blur_bg.dart';
import 'package:flutter_ui_radio/pages/station_page/_widgets/control_buttons.dart';
import 'package:flutter_ui_radio/pages/station_page/_widgets/now_playing.dart';
import 'package:flutter_ui_radio/pages/station_page/_widgets/playing_now.dart';
import 'package:flutter_ui_radio/pages/station_page/_widgets/station_image_animation.dart';

class StationPage extends StatelessWidget {
  const StationPage({super.key, required this.station});

  final Station station;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(station.name)),
        extendBodyBehindAppBar: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            BlurBG(link: station.links.largeImage),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                child: BlocProvider(
                  create: (context) => OnOffCubit(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      StationImageAnimation(link: station.links.largeImage),
                      const MainSizeBox(),
                      const NowPlaying(),
                      const MainSizeBox(),
                      const PlayingNow(),
                      const Spacer(flex: 1),
                      const ControlButtons(),
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
