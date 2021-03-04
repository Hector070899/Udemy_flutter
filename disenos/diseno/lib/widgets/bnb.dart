import 'package:flutter/material.dart';

class BNB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        //A traves del theme, logramos cambiar el fondo del bottomNavigationbar sin cambiar el tema de
        //toda la app
        data: Theme.of(context).copyWith(
            canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
            primaryColor: Colors.pinkAccent,
            //De esta manera se cambia el color de los items no usados
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.grey))),
        child: BottomNavigationBar(items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'botones'),
              child: Icon(
                Icons.calendar_today,
                size: 30.0,
              ),
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'scroll'),
              child: Icon(
                Icons.bubble_chart,
                size: 30.0,
              ),
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'basico'),
              child: Icon(
                Icons.supervised_user_circle,
                size: 30.0,
              ),
            ),
            title: Container(),
          )
        ]));
  }
}

// Widget _bottomNavigatioBar(BuildContext context) {
//     return Theme(
//         //A traves del theme, logramos cambiar el fondo del bottomNavigationbar sin cambiar el tema de
//         //toda la app
//         data: Theme.of(context).copyWith(
//             canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
//             primaryColor: Colors.pinkAccent,
//             //De esta manera se cambia el color de los items no usados
//             textTheme: Theme.of(context)
//                 .textTheme
//                 .copyWith(caption: TextStyle(color: Colors.grey))),
//         child: BottomNavigationBar(items: [
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//               onTap: () => Navigator.pushNamed(context, 'scroll'),
//               child: Icon(
//                 Icons.calendar_today,
//                 size: 30.0,
//               ),
//             ),
//             title: Container(),
//           ),
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//               onTap: () => Navigator.pushNamed(context, 'botones'),
//               child: Icon(
//                 Icons.bubble_chart,
//                 size: 30.0,
//               ),
//             ),
//             title: Container(),
//           ),
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//               onTap: () => Navigator.pushNamed(context, 'basico'),
//               child: Icon(
//                 Icons.supervised_user_circle,
//                 size: 30.0,

//               ),
//             ),
//             title: Container(),
//           )
//         ]));
//   }
