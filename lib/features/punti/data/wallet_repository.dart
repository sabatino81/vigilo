import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/punti/domain/models/elmetto_wallet.dart';
import 'package:vigilo/features/punti/domain/models/points_stats.dart';
import 'package:vigilo/features/punti/domain/models/reward.dart';
import 'package:vigilo/features/punti/domain/models/wheel_prize.dart';

/// Repository per wallet, punti, premi e ruota della fortuna.
class WalletRepository extends BaseRepository {
  const WalletRepository(super.client);

  /// Carica wallet con saldo e transazioni recenti.
  Future<ElmettoWallet> getMyWallet({int limit = 20}) async {
    final json = await rpc<Map<String, dynamic>>(
      'get_my_wallet',
      params: {'p_limit': limit},
    );
    return ElmettoWallet.fromJson(json);
  }

  /// Statistiche punti 7gg/30gg.
  Future<PointsStats> getMyPointsStats() async {
    final json = await rpc<Map<String, dynamic>>('get_my_points_stats');
    return PointsStats.fromJson(json);
  }

  /// Catalogo premi, opzionalmente filtrato per categoria.
  Future<List<Reward>> getRewards({String? category}) async {
    final json = await rpc<List<dynamic>>(
      'get_rewards',
      params: {if (category != null) 'p_category': category},
    );
    return json
        .whereType<Map<String, dynamic>>()
        .map(Reward.fromJson)
        .toList();
  }

  /// Riscatta un premio. Ritorna risultato con successo/errore.
  Future<Map<String, dynamic>> redeemReward(String rewardId) async {
    return await rpc<Map<String, dynamic>>(
      'redeem_reward',
      params: {'p_reward_id': rewardId},
    );
  }

  /// Configurazione premi sulla ruota.
  Future<List<WheelPrize>> getWheelPrizes() async {
    final json = await rpc<List<dynamic>>('get_wheel_prizes');
    return json
        .whereType<Map<String, dynamic>>()
        .map(WheelPrize.fromJson)
        .toList();
  }

  /// Controlla se ha già girato oggi.
  Future<Map<String, dynamic>> getTodaySpin() async {
    return await rpc<Map<String, dynamic>>('get_today_spin');
  }

  /// Gira la ruota. Ritorna premio + nuovo saldo.
  Future<Map<String, dynamic>> spinWheel() async {
    return await rpc<Map<String, dynamic>>('spin_wheel');
  }
}
