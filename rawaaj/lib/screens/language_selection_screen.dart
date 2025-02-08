import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';
import '../cubit/language_cubit.dart';


class LanguageSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LanguageCubit()..loadInitialLanguage(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const SubScreenAppBar(name: "Settings"),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Language",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<LanguageCubit, LanguageState>(
                  builder: (context, state) {
                    final cubit = context.read<LanguageCubit>();
                    String selectedLanguage = 'English';

                    if (state is LanguageLoaded || state is LanguageUpdated) {
                      selectedLanguage =
                      state is LanguageLoaded ? state.selectedLanguage : (state as LanguageUpdated).selectedLanguage;
                    }

                    return ListView.builder(
                      itemCount: cubit.languages.length,
                      itemBuilder: (context, index) {
                        final language = cubit.languages[index];
                        return GestureDetector(
                          onTap: () {
                            cubit.updateLanguage(language);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: selectedLanguage == language
                                  ? const Color(0xFFEAF1FE)
                                  : const Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  language,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: selectedLanguage == language
                                      ? Colors.blue
                                      : Colors.red.shade100,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
