import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
      route: '/',
    ),
    NavigationItem(
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: 'About',
      route: '/about',
    ),
    NavigationItem(
      icon: Icons.work_outline,
      selectedIcon: Icons.work,
      label: 'Projects',
      route: '/projects',
    ),
    NavigationItem(
      icon: Icons.article_outlined,
      selectedIcon: Icons.article,
      label: 'Blog',
      route: '/blog',
    ),
    NavigationItem(
      icon: Icons.contact_mail_outlined,
      selectedIcon: Icons.contact_mail,
      label: 'Contact',
      route: '/contact',
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    final location = GoRouterState.of(context).uri.path;
    for (int i = 0; i < _navigationItems.length; i++) {
      if (location == _navigationItems[i].route ||
          (location.startsWith('/post/') &&
              _navigationItems[i].route == '/blog')) {
        setState(() {
          _selectedIndex = i;
        });
        break;
      }
    }
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      context.go(_navigationItems[index].route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1024;
        final isTablet =
            constraints.maxWidth > 600 && constraints.maxWidth <= 1024;

        if (isDesktop) {
          return _buildDesktopLayout();
        } else if (isTablet) {
          return _buildTabletLayout();
        } else {
          return _buildMobileLayout();
        }
      },
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Blog',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 1,
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor:
            Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        items: _navigationItems.map((item) {
          final isSelected = _navigationItems.indexOf(item) == _selectedIndex;
          return BottomNavigationBarItem(
            icon: Icon(isSelected ? item.selectedIcon : item.icon),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.all,
            backgroundColor: Theme.of(context).colorScheme.surface,
            destinations: _navigationItems.map((item) {
              final isSelected =
                  _navigationItems.indexOf(item) == _selectedIndex;
              return NavigationRailDestination(
                icon: Icon(isSelected ? item.selectedIcon : item.icon),
                label: Text(item.label),
              );
            }).toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: widget.child),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Personal Blog',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _navigationItems.length,
                    itemBuilder: (context, index) {
                      final item = _navigationItems[index];
                      final isSelected = index == _selectedIndex;

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: ListTile(
                          leading: Icon(
                            isSelected ? item.selectedIcon : item.icon,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                          ),
                          title: Text(
                            item.label,
                            style: TextStyle(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurface,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                          selected: isSelected,
                          selectedTileColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onTap: () => _onItemTapped(index),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;

  NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.route,
  });
}
