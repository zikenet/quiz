import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/features/trivia/presentation/business_logic/cubit/difficulty/difficulty_cubit.dart';
import 'package:quiz/features/trivia/presentation/widgets/difficulty_dialog.dart';
import '../../../../config/category.dart';
import '../../../../core/widgets/modal_bottom_sheet.dart';
import '../../../../core/widgets/simple_text.dart';
import '../../../auth/presentation/business_logic/bloc/auth_bloc.dart';
import '../widgets/category_card.dart';
import '../widgets/status_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SliverAppBar(
                elevation: 5,
                shadowColor: Theme.of(context).colorScheme.shadow,
                backgroundColor: Theme.of(context).colorScheme.background,
                surfaceTintColor: Colors.transparent,
                toolbarHeight: 65,
                pinned: true,
                automaticallyImplyLeading: false,
                centerTitle: false,
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleText(
                      'Hi, ${state.user.name?.split(' ').first}',
                      textStyle: TextStyleEnum.headlineSmall,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      fontSize: 24,
                    ),
                    const SimpleText(
                      "Let's make this day productive",
                      fontSize: 14,
                      textStyle: TextStyleEnum.bodyMedium,
                      color: Colors.grey,
                    )
                  ],
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            title: const SimpleText(
                              'Logout',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            content: const SimpleText(
                              'This action will log you out of the app, Would you like to continue ?',
                              textAlign: TextAlign.center,
                            ),
                            contentPadding: const EdgeInsets.all(8.0),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: SimpleText(
                                  "Cancel",
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(const AuthLogoutRequested());
                                },
                                child: SimpleText(
                                  "Continue",
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: state.user.photo != null
                            ? NetworkImage(state.user.photo!)
                            : null,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            sliver: SliverToBoxAdapter(
              child: StatusCard(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            sliver: SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: const SimpleText(
                  "Let's play",
                  textStyle: TextStyleEnum.headlineSmall,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 17,
                mainAxisSpacing: 29,
              ),
              /* gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ), */
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Transform.translate(
                    offset: Offset(
                      0.0,
                      index.isOdd ? 50 : 10.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<DifficultyCubit>(context).setCategory(
                          Category.categories[index].id,
                          Category.categories[index].questions,
                        );
                        ModalBottomSheet(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(14),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.shadow,
                                  offset: const Offset(1.0, 1.0), //(x,y)
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                            child: const DifficultyDialog(),
                          ),
                        ).showBottomDialog(context);
                      },
                      child: CategoryCard(
                        name: Category.categories[index].name,
                        id: Category.categories[index].id,
                        url: Category.categories[index].url,
                        amount: Category.categories[index].questions,
                      ),
                    ),
                  );
                },
                childCount: Category.categories.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          )
        ],
      ),
    );
  }
}
