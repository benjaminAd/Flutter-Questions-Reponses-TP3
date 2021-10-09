import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:questions_reponses/cubit/question_cubit.dart';
import 'model/triplet.dart';
import 'model/question.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions / Réponses"),
      ),
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: BlocBuilder<QuestionCubit, Triplet<Question, int, int>>(
              builder: (context, pair) => Image.asset(pair.key.path),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: BlocBuilder<QuestionCubit, Triplet<Question, int, int>>(
                  builder: (context, pair) => Text(pair.key.question),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => {
                        context.read<QuestionCubit>().checkAnswer(true, context)
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1)),
                      ),
                      child: Text("Vrai"),
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        context
                            .read<QuestionCubit>()
                            .checkAnswer(false, context)
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1)),
                      ),
                      child: Text("Faux"),
                    ),
                    BlocBuilder<QuestionCubit, Triplet<Question, int, int>>(
                      builder: (context, triplet) => ElevatedButton(
                        onPressed: () => {
                          (triplet.secondValue >=
                                  context
                                      .read<QuestionCubit>()
                                      .questions
                                      .length)
                              ? context.read<QuestionCubit>().resetAll()
                              : context
                                  .read<QuestionCubit>()
                                  .changeQuestion(false, context)
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1)),
                        ),
                        child: (triplet.secondValue >=
                                context.read<QuestionCubit>().questions.length)
                            ? Icon(Icons.restart_alt)
                            : Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                BlocBuilder<QuestionCubit, Triplet<Question, int, int>>(
                  builder: (context, triplet) => Text(
                      '${triplet.value} / ${context.read<QuestionCubit>().questions.length}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
