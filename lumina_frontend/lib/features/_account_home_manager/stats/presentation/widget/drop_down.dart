import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/_account_home_manager/stats/presentation/widget/name_box.dart';

class DropDown extends StatelessWidget {
  final VoidCallback onToggleDropDown;
  final ScrollController _scrollController = ScrollController();

  DropDown({super.key, required this.onToggleDropDown});

  @override
  Widget build(BuildContext context) {

    return FractionallySizedBox(
      widthFactor: 0.9,
      heightFactor: 0.9,
      child: Container(
        padding: const EdgeInsets.all(36.0),
        decoration: BoxDecoration(
          color: Colors.white
              .withValues(alpha: 10), // Use withOpacity instead of withValues
          borderRadius: BorderRadius.circular(10), // Rounded edges
        ),
        child: Row(
          children: [
            Expanded(
              flex: 85, // Take up 85% of the space
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Your Homes',
                          style: MainTheme.h1Black,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      trackVisibility: true,
                      thickness: 8.0,
                      radius: const Radius.circular(10),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NameBox(
                                          name: '1 Lumina Care',
                                          onToggleDropDown: onToggleDropDown),
                                    ),
                                    const SizedBox(
                                        width:
                                            16), // Add space between NameBox and scrollbar
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NameBox(
                                          name: '2 Lumina Care',
                                          onToggleDropDown: onToggleDropDown),
                                    ),
                                    const SizedBox(
                                        width:
                                            16), // Add space between NameBox and scrollbar
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NameBox(
                                          name: '3 Lumina Care',
                                          onToggleDropDown: onToggleDropDown),
                                    ),
                                    const SizedBox(
                                        width:
                                            16), // Add space between NameBox and scrollbar
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NameBox(
                                          name: '4 Lumina Care',
                                          onToggleDropDown: onToggleDropDown),
                                    ),
                                    const SizedBox(
                                        width:
                                            16), // Add space between NameBox and scrollbar
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NameBox(
                                          name: '5 Lumina Care',
                                          onToggleDropDown: onToggleDropDown),
                                    ),
                                    const SizedBox(
                                        width:
                                            16), // Add space between NameBox and scrollbar
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NameBox(
                                          name: '6 Lumina Care',
                                          onToggleDropDown: onToggleDropDown),
                                    ),
                                    const SizedBox(
                                        width:
                                            16), // Add space between NameBox and scrollbar
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NameBox(
                                          name: '7 Lumina Care',
                                          onToggleDropDown: onToggleDropDown),
                                    ),
                                    const SizedBox(
                                        width:
                                            16), // Add space between NameBox and scrollbar
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NameBox(
                                          name: '8 Lumina Care',
                                          onToggleDropDown: onToggleDropDown),
                                    ),
                                    const SizedBox(
                                        width:
                                            16), // Add space between NameBox and scrollbar
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NameBox(
                                          name: '9 Lumina Care',
                                          onToggleDropDown: onToggleDropDown),
                                    ),
                                    const SizedBox(
                                        width:
                                            16), // Add space between NameBox and scrollbar
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NameBox(
                                          name: '10 Lumina Care',
                                          onToggleDropDown: onToggleDropDown),
                                    ),
                                    const SizedBox(
                                        width:
                                            16), // Add space between NameBox and scrollbar
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
