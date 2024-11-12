import 'package:flutter/material.dart';

BottomNavigationBar appBottomNav(currentindex, onItemTapped) {
  return BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'New'),
      BottomNavigationBarItem(
          icon: Icon(Icons.access_time_rounded), label: 'Progress'),
      BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline), label: 'Completed'),
      BottomNavigationBarItem(
          icon: Icon(Icons.cancel_outlined), label: 'Canceled'),
    ],
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey,
    currentIndex: currentindex,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    onTap: onItemTapped,
    type: BottomNavigationBarType.fixed,
  );
}
