import 'package:flutter/material.dart';

/// A consistent "back" button for every screen's [AppBar].
///
/// Pops the current route when there is something to pop back to.
/// If there isn't (e.g. a tab screen like Category/Wishlist/Profile
/// reached via [Navigator.pushReplacementNamed] from the bottom nav,
/// which leaves nothing underneath it on the stack), it falls back
/// to sending the user to the Home screen instead of doing nothing.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      tooltip: 'Back',
      onPressed: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
    );
  }
}
