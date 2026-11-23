
import 'package:flutter/material.dart';

import '../models/favorite_show.dart';
import '../services/favorite_service.dart';
import 'detail_tiket.dart'; 

const _kGreen = Color(0xFF1A3C34);
const _kGold = Color(0xFFB8862B);
const _kBg = Color(0xFFFDF8F0);
const _kMuted = Color(0xFF6B7A75);

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kBg,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: _kGreen),
        title: const Text(
          'Favorit Saya',
          style: TextStyle(
            color: _kGreen,
            fontWeight: FontWeight.bold,
            fontFamily: 'serif',
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: FavoriteService.listenable(),
        builder: (context, box, child) {
          final favorites = FavoriteService.getAll();

          if (favorites.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final show = favorites[index];

              return _buildFavoriteCard(
                context,
                show,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 75,
              color: _kGold.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 20),
            const Text(
              'Belum Ada Favorit',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _kGreen,
                fontFamily: 'serif',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Acara pementasan yang kamu sukai '
              'akan muncul di halaman ini',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: _kMuted,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildFavoriteCard(
    BuildContext context,
    FavoriteShow show,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowDetailScreen(
              title: show.title,
              day: show.day,
              image: show.image,
              description: show.description,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEADFCB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: Image.asset(
                show.image,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: 160,
                    color: const Color(0xFFE8EFEC),
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                        color: _kMuted,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          show.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _kGreen,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 15,
                              color: _kGold,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Setiap ${show.day}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: _kMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Hapus dari favorit',
                    onPressed: () async {
                      final konfirmasi = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: const Text('Hapus Favorit?'),
                            content: Text(
                              'Apakah kamu yakin ingin menghapus '
                              '${show.title} dari daftar favorit?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext, false);
                                },
                                child: const Text(
                                  'Batal',
                                  style: TextStyle(color: _kMuted),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext, true);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Hapus'),
                              ),
                            ],
                          );
                        },
                      );

                      if (konfirmasi != true) return;

                      await FavoriteService.remove(show);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Acara berhasil dihapus dari favorit',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red, 
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } 
}