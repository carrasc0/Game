import 'package:flutter/material.dart';
import 'package:game/question_screen.dart';
import 'package:game/result_screen.dart';

import 'model/question.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final teamA = Team(name: 'A', points: 0);
  final teamB = Team(name: 'B', points: 0);

  int currentPage = 0;
  final List<Question> questions = [];
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    questions.addAll(generateQuestions());
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TeamItem(
              team: teamA,
              inTurn: getCurrentTeam() == teamA,
            ),
            TeamItem(
              team: teamB,
              inTurn: getCurrentTeam() == teamB,
            ),
          ],
        ),
      ),
      body: PageView.builder(
          controller: pageController,
          itemCount: questions.length,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int page) {
            setState(() {
              currentPage = page;
            });
          },
          itemBuilder: (context, index) {
            return QuestionScreen(
                question: questions[index],
                onAnswerSelected: (bool correct) {
                  processAnswer(correct);
                });
          }),
    );
  }

  void processAnswer(bool correct) {
    if (correct) {
      setState(() {
        getCurrentTeam().points++;
      });
    }
    if (currentPage == questions.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(teams: getWinnerTeam())),
      );
    } else {
      pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }

  Team getCurrentTeam() => currentPage % 2 == 0 ? teamA : teamB;

  List<Team> getWinnerTeam() => teamA.points > teamB.points
      ? [teamA]
      : teamA.points < teamB.points
          ? [teamB]
          : [teamA, teamB];
}

class TeamItem extends StatelessWidget {
  final Team team;
  final bool inTurn;
  const TeamItem({super.key, required this.team, required this.inTurn});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: inTurn ? Colors.red : null,
      child: CircleAvatar(
        radius: 55,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                team.name,
              ),
              Text('${team.points} points'),
            ],
          ),
        ),
      ),
    );
  }
}
