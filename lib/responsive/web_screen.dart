import '../utils/app_lib.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController;
  final homeScreenItems = [
    FeedScreen(),
    SearchScreen(),
    AddPostScreen(),
    Text('notification'),
    ProfileScreen(
      uid:FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTap(int page) {
     setState(() {
      _page = page;
    });
    pageController.jumpToPage(page);
  }

  void pageChange(int page) {
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        backgroundColor: mobileBackgroundColor,
        actions: [
          IconButton(
            onPressed: () => navigationTap(0),
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () => navigationTap(1),
            icon: Icon(
              Icons.search,
              color: (_page == 1) ? primaryColor : secondaryColor
            ),
          ),
          IconButton(
            onPressed: () => navigationTap(2),
            icon: Icon(
              Icons.add_a_photo,
              color: (_page == 2) ? primaryColor : secondaryColor
            ),
          ),
          IconButton(
            onPressed: () => navigationTap(3),
            icon: Icon(
              Icons.favorite,
              color: (_page == 3) ? primaryColor : secondaryColor
            ),
          ),
          IconButton(
            onPressed: () => navigationTap(4),
            icon: Icon(
              Icons.person,
              color: (_page == 4) ? primaryColor : secondaryColor
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: pageChange,
      ),
    );
  }
}