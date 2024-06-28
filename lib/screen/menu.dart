import 'package:easystate/easystate.dart';
import 'package:flutter/material.dart';
import 'package:puzzle/etc/appstate.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return EasyStateBuilder<Appstate>(
      builder: (_, state) => Container(
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(200),
        height: MediaQuery.of(context).size.height * .10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: onPressed,
              icon: const Icon(
                Icons.restore,
              ),
              label: Text(
                'Reset',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            _text(context: context, text: "Move: ${state.move}"),
            _text(context: context, text: 'Time: ${state.time}'),
          ],
        ),
      ),
    );
  }

  _text({
    required BuildContext context,
    required String text,
  }) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
