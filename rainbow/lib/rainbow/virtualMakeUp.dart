import 'package:flutter/material.dart';

class VirtualMakeUp extends StatefulWidget {
  const VirtualMakeUp({super.key});

  @override
  State<VirtualMakeUp> createState() => _VirtualMakeUp();
}

class _VirtualMakeUp extends State<VirtualMakeUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Text('Virtual Make Up'),
    );
  }
}
