import 'package:flutter/material.dart';

enum MenuOption { Usuario, Pais, Estado, Genero }

class PopOptionMenu extends StatelessWidget {
  const PopOptionMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
      icon: Icon(Icons.arrow_back_outlined),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<MenuOption>>[
          PopupMenuItem(
            child: Row(
              children: [
                TextButton(
                    child: Text('sort for  User'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/getUser');
                    }),
              ],
            ),
            value: MenuOption.Usuario,
          ),
          PopupMenuItem(
            child: Row(
              children: [
                TextButton(
                    child: Text('sort for Country'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/getCountry');
                    }),
              ],
            ),
            value: MenuOption.Pais,
          ),
          PopupMenuItem(
            child: Row(
              children: [
                TextButton(
                    child: Text('sort for State'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/getState');
                    }),
              ],
            ),
            value: MenuOption.Estado,
          ),
          PopupMenuItem(
            child: Row(
              children: [
                TextButton(
                    child: Text('sort for gener'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/getGener');
                    }),
              ],
            ),
            value: MenuOption.Genero,
          ),
        ];
      },
    );
  }
}
