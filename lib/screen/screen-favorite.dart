import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../card/animal_card.dart';
import '../card/ecoss_card.dart';
import '../card/plant_card.dart';
import '../provider/favorite_store.dart';
import '../models/animal.dart';
import '../models/plant.dart';
import '../model/modelo_ecossistema.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteStore = context.watch<FavoriteStore>();
    final favoritesByType = favoriteStore.getFavoritesByType();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 121, 88), // <-- cor personalizada
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 4, 121, 88), 
        elevation: 4,
        title: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.95, end: 1.0),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutBack,
          builder: (context, value, child) => Transform.scale(
            scale: value,
            child: child,
          ),
          child: Text(
            'Favoritos',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.normal,
              color: Colors.white, // <-- cor personalizada
              letterSpacing: 0.5,
            ),
          ),
        ),
        
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCategorySection(
            'Animais',
            favoritesByType['Animais']!,
            Icons.pets_rounded,
            theme,
          ),
          _buildCategorySection(
            'Plantas',
            favoritesByType['Plantas']!,
            Icons.local_florist_rounded,
            theme,
          ),
          _buildCategorySection(
            'Ecossistemas',
            favoritesByType['Ecossistemas']!,
            Icons.forest_rounded,
            theme,
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(
    String title,
    List<dynamic> items,
    IconData icon,
    ThemeData theme,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(131, 255, 255, 255).withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.only(bottom: 16),
          title: Row(
            children: [
              Icon(icon, color: const Color.fromARGB(255, 0, 0, 0),), 
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          iconColor: Colors.white, // <-- cor personalizada
          collapsedIconColor: Colors.white, // <-- cor personalizada
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: items.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Icon(
                            Icons.favorite_border_rounded, 
                            size: 48,
                            color:  const Color.fromARGB(151, 146, 146, 146).withOpacity(0.6), // <-- cor personalizada
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Você ainda não favoritou nenhum item desta categoria.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color:  const Color.fromARGB(151, 135, 135, 135).withOpacity(0.6),  // <-- cor personalizada
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 400),
                            child: _buildItemCard(item),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(dynamic item) {
    if (item is Animal) {
      return Hero(
        tag: item.id,
        child: AnimalCard(animal: item),
      );
    }
    if (item is Plant) {
      return Hero(
        tag: item.id,
        child: PlantCard(plant: item),
      );
    }
    if (item is Ecossistema) {
      return Hero(
        tag: item.id,
        child: EcosystemCard(ecosystem: item),
      );
    }
    return const SizedBox.shrink();
  }
}
