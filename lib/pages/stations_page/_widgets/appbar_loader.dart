// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_ui_radio/blocs/stations_bloc/stations_bloc.dart';

// class AppBarLoader extends StatelessWidget {
//   const AppBarLoader({super.key});

//   @override
//   Widget build(BuildContext context) =>
//       BlocBuilder<StationsBloc, StationsState>(
//         builder: (context, state) {
//           if (state is LoadingNextStationsState) {
//             return const Padding(
//               padding: EdgeInsets.only(right: 16.0),
//               child: Center(
//                 child: SizedBox(
//                   height: 32.0,
//                   width: 32.0,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2.0,
//                   ),
//                 ),
//               ),
//             );
//           }
//           return Container();
//         },
//       );
// }
