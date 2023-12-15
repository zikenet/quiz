import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz/features/trivia/presentation/business_logic/bloc/leader_board/leader_board_bloc.dart';

import '../../../../core/widgets/simple_text.dart';

class StatusIndicator extends StatelessWidget {
  final String title;
  final dynamic value;
  final String url;
  const StatusIndicator({
    super.key,
    required this.title,
    required this.value,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/leaderBoard');
        BlocProvider.of<LeaderBoardBloc>(context).add(GetAllScoresEvent());
      },
      child: Row(
        children: [
          SvgPicture.asset(url),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleText(
                title,
                fontSize: 12,
                textStyle: TextStyleEnum.titleSmall,
              ),
              SimpleText(
                value.toString(),
                fontSize: 18,
                textStyle: TextStyleEnum.titleSmall,
                fontWeight: FontWeight.bold,
                height: 1.4,
              )
            ],
          ),
        ],
      ),
    );
  }
}
