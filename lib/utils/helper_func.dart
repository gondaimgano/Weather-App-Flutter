import 'package:flutter/material.dart';

Future<void> buildShowHelperDialog(BuildContext context) {
  return showGeneralDialog<void>(
    context: context,
    barrierColor: Colors.black54.withValues(alpha: 0.4),
    barrierDismissible: true,
    barrierLabel: 'Information',
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return Material(
        color: Colors.transparent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Align(
                alignment: Alignment.topCenter.add(const Alignment(0, 0.1)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.refresh, color: Colors.white, size: 30),
                    const SizedBox(height: 12),
                    Text(
                      '1. Pull down from this top edge to refresh forecast',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.face,
                      color: Colors.white,
                      size: 35,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Hi !',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Some important things for you to know.',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(-0.9, 0.6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(Icons.redo_rounded, size: 30),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '2. Tap on a forecast to view more details',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
