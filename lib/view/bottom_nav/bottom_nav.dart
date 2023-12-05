import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelo_test_app/utils/colors.dart';
import 'package:travelo_test_app/view/auth/sign_in/sign_in_page.dart';
import 'package:travelo_test_app/view/user/home_page.dart';

class BottomNavController extends HookWidget {
  const BottomNavController({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const SignInPage(),
      const HomePage(),
      const SignInPage(),
    ];

    final PageStorageBucket bucket = PageStorageBucket();
    final currentTab = useState(0);
    final keyboardOpen = useState(false);
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 300), () async {
        var keyboardVisibilityController = KeyboardVisibilityController();

        keyboardVisibilityController.onChange.listen((bool visible) {
          keyboardOpen.value = visible;
        });
      });
      return null;
    }, []);

    return Scaffold(
      extendBody: true,
      body: PageStorage(bucket: bucket, child: pages[currentTab.value]),
      floatingActionButton: keyboardOpen.value
          ? const SizedBox.shrink()
          : FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () {
                currentTab.value = 3;
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    const AssetImage(
                      'assets/icons/magicoon.png',
                    ),
                    color: currentTab.value == 3 ? Colors.amber : Colors.white,
                  ),
                ],
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: currentTab.value == 0
                            ? kPrimaryColor
                            : Colors.white),
                    onPressed: () {
                      currentTab.value = 0;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab.value == 0
                              ? Colors.white
                              : Colors.grey,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        const Text(
                          "Home",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      currentTab.value = 1;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: currentTab.value == 1
                              ? kPrimaryColor
                              : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      currentTab.value = 2;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab.value == 2
                              ? kPrimaryColor
                              : Colors.grey,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
