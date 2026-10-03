import 'package:bellylog/backup_hive.dart';
import 'package:bellylog/data/bellylog_database.dart';
import 'package:bellylog/restore_hive.dart';
import 'package:bellylog/utilities/bellylog/belly_summary_card.dart';
import 'package:bellylog/utilities/homepage_card.dart';
import 'package:bellylog/utilities/bellylog/insights_card.dart';
import 'package:bellylog/utilities/uniform_appbar.dart';
import 'package:flutter/material.dart';

class HomepageBellylog extends StatefulWidget {
  const HomepageBellylog({super.key});

  @override
  State<HomepageBellylog> createState() => _HomepageBellylogState();
}

class _HomepageBellylogState extends State<HomepageBellylog> {
  late BellyLogDatabase db;

  @override
  void initState() {
    super.initState();

    db = BellyLogDatabase();
    //db.loadData();
  }

  Future<void> _openPage(BuildContext context, String route) async {
    await Navigator.pushNamed(context, route);

    db.loadData();

    if (mounted) {
      setState(() {});
    }
  }

  int _countEntriesToday(Map<String, dynamic> log) {
    final now = DateTime.now();

    return log.keys.where((key) {
      final entryDate = DateTime.tryParse(key);
      if (entryDate == null) return false;

      return entryDate.year == now.year &&
          entryDate.month == now.month &&
          entryDate.day == now.day;
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    final db = BellyLogDatabase()..loadData();

    final mealsToday = _countEntriesToday(db.mealLog);
    final symptomsToday = _countEntriesToday(db.symptomLog);
    final bathroomVisitsToday = _countEntriesToday(db.bowelLog);

    return Scaffold(
      appBar: UniformAppbar(
        leadIcon: Icon(Icons.logout_rounded),
        titleText: "Bellylog",
        //onPress: () => Navigator.pop(context),
        onPress: () {},
      ),

      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  BellySummaryCard(
                    mealsToday: mealsToday,
                    symptomsToday: symptomsToday,
                    bathroomVisitsToday: bathroomVisitsToday,
                  ),

                  const SizedBox(height: 24),
                ]),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
              sliver: SliverGrid(
                delegate: SliverChildListDelegate([
                  HomepageCard(
                    icon: Icons.restaurant_rounded,
                    title: "Log Meal",
                    onTap: () => _openPage(context, '/log_meal'),
                  ),

                  HomepageCard(
                    icon: Icons.menu_book_rounded,
                    title: "View Meals",

                    onTap: () => _openPage(context, '/view_meals'),
                  ),

                  HomepageCard(
                    icon: Icons.monitor_heart_outlined,
                    title: "Log Symptoms",

                    onTap: () => _openPage(context, '/log_symptom'),
                  ),

                  HomepageCard(
                    icon: Icons.analytics_outlined,
                    title: "View Symptoms",

                    onTap: () => _openPage(context, '/view_symptoms'),
                  ),

                  HomepageCard(
                    icon: Icons.wc_rounded,
                    title: "Log Bathroom Visits",

                    onTap: () => _openPage(context, '/log_bowel_movement'),
                  ),

                  HomepageCard(
                    icon: Icons.list_alt_rounded,
                    title: "View Bathroom Visits",

                    onTap: () => _openPage(context, '/view_bowel_movements'),
                  ),

                  HomepageCard(
                    icon: Icons.today_rounded,
                    title: "Daily Check-in",

                    onTap: () => _openPage(context, '/log_daily_checkin'),
                  ),

                  HomepageCard(
                    icon: Icons.calendar_month_rounded,
                    title: "View Check-ins",

                    onTap: () => _openPage(context, '/view_daily_checkins'),
                  ),
                ]),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.18,
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              sliver: SliverToBoxAdapter(
                child: InsightsCard(
                  onTap: () {
                    Navigator.pushNamed(context, "/weekly_bellylog_insight");
                  },
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilledButton(
                      style: FilledButton.styleFrom(
                        // Uses dark surface tones derived from your theme
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onSurface,
                        // Modern styling tweaks
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => backupHiveDatabase(context),
                      child: const Text('Backup Data'),
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onSurface,
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => restoreHiveDatabase(context),
                      child: const Text('Restore Data'),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'Discover the patterns that define your gut issues',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
