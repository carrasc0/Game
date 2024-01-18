import 'package:flutter/material.dart';
import 'package:game/game_screen.dart';

import 'model/question.dart';

class ResultScreen extends StatelessWidget {
  final List<Team> teams;
  const ResultScreen({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('And the winner is:'),
            ),
            teams.length == 1
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TeamItem(
                      team: teams[0],
                      inTurn: false,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TeamItem(
                        team: teams[0],
                        inTurn: false,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      TeamItem(
                        team: teams[1],
                        inTurn: false,
                      )
                    ],
                  ),
            teams.length > 1
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('EVEN!'),
                  )
                : const SizedBox(),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ));
                },
                child: const Text('Play again')),
          ],
        ),
      ),
    );
  }
}
