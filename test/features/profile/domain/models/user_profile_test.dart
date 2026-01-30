import 'package:flutter_test/flutter_test.dart';
import 'package:vigilo/features/profile/domain/models/user_profile.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  group('UserProfile.fromJson', () {
    test('parses complete JSON', () {
      final json = <String, dynamic>{
        'id': 'u1',
        'name': 'Luca Bianchi',
        'email': 'luca@example.com',
        'category': 'caposquadra',
        'trust_level': 'trusted',
        'safety_score': 92,
        'streak_days': 21,
        'reports_count': 5,
        'punti_elmetto': 2400,
        'welfare_active': true,
        'company_name': 'ACME S.r.l.',
        'avatar_url': 'https://example.com/avatar.png',
      };

      final profile = UserProfile.fromJson(json);
      expect(profile.id, 'u1');
      expect(profile.name, 'Luca Bianchi');
      expect(profile.email, 'luca@example.com');
      expect(profile.category, WorkerCategory.caposquadra);
      expect(profile.trustLevel, TrustLevel.trusted);
      expect(profile.safetyScore, 92);
      expect(profile.streakDays, 21);
      expect(profile.reportsCount, 5);
      expect(profile.puntiElmetto, 2400);
      expect(profile.welfareActive, true);
      expect(profile.companyName, 'ACME S.r.l.');
      expect(profile.avatarUrl, 'https://example.com/avatar.png');
    });

    test('defaults category to operaio for unknown value', () {
      final json = <String, dynamic>{
        'id': 'u2',
        'category': 'unknown_cat',
      };
      final profile = UserProfile.fromJson(json);
      expect(profile.category, WorkerCategory.operaio);
    });

    test('defaults category to operaio for null', () {
      final json = <String, dynamic>{
        'id': 'u3',
        'category': null,
      };
      final profile = UserProfile.fromJson(json);
      expect(profile.category, WorkerCategory.operaio);
    });

    test('defaults trustLevel to base for unknown value', () {
      final json = <String, dynamic>{
        'id': 'u4',
        'trust_level': 'super_mega',
      };
      final profile = UserProfile.fromJson(json);
      expect(profile.trustLevel, TrustLevel.base);
    });

    test('defaults trustLevel to base for null', () {
      final json = <String, dynamic>{
        'id': 'u5',
        'trust_level': null,
      };
      final profile = UserProfile.fromJson(json);
      expect(profile.trustLevel, TrustLevel.base);
    });

    test('handles null optional fields with defaults', () {
      final json = <String, dynamic>{
        'id': 'u6',
        'name': null,
        'email': null,
        'safety_score': null,
        'streak_days': null,
        'reports_count': null,
        'punti_elmetto': null,
        'welfare_active': null,
        'company_name': null,
        'avatar_url': null,
      };
      final profile = UserProfile.fromJson(json);
      expect(profile.name, '');
      expect(profile.email, '');
      expect(profile.safetyScore, 0);
      expect(profile.streakDays, 0);
      expect(profile.reportsCount, 0);
      expect(profile.puntiElmetto, 0);
      expect(profile.welfareActive, false);
      expect(profile.companyName, '');
      expect(profile.avatarUrl, isNull);
    });
  });

  group('UserProfile.toJson', () {
    test('serializes all fields correctly', () {
      final profile = makeProfile(
        id: 'u10',
        name: 'Test',
        email: 'test@test.com',
        category: WorkerCategory.preposto,
        trustLevel: TrustLevel.expert,
        safetyScore: 95,
        streakDays: 30,
        reportsCount: 12,
        puntiElmetto: 3000,
        welfareActive: true,
        companyName: 'TestCo',
        avatarUrl: 'https://img.test/a.png',
      );
      final json = profile.toJson();
      expect(json['id'], 'u10');
      expect(json['name'], 'Test');
      expect(json['email'], 'test@test.com');
      expect(json['category'], 'preposto');
      expect(json['trust_level'], 'expert');
      expect(json['safety_score'], 95);
      expect(json['streak_days'], 30);
      expect(json['reports_count'], 12);
      expect(json['punti_elmetto'], 3000);
      expect(json['welfare_active'], true);
      expect(json['company_name'], 'TestCo');
      expect(json['avatar_url'], 'https://img.test/a.png');
    });

    test('round-trips fromJson(toJson(profile)) correctly', () {
      final original = makeProfile(
        id: 'round_trip',
        name: 'Maria',
        email: 'maria@co.it',
        category: WorkerCategory.rspp,
        trustLevel: TrustLevel.verified,
        safetyScore: 55,
        streakDays: 7,
        reportsCount: 2,
        puntiElmetto: 900,
        welfareActive: false,
        companyName: 'RoundTrip S.r.l.',
        avatarUrl: null,
      );
      final restored = UserProfile.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.name, original.name);
      expect(restored.email, original.email);
      expect(restored.category, original.category);
      expect(restored.trustLevel, original.trustLevel);
      expect(restored.safetyScore, original.safetyScore);
      expect(restored.streakDays, original.streakDays);
      expect(restored.reportsCount, original.reportsCount);
      expect(restored.puntiElmetto, original.puntiElmetto);
      expect(restored.welfareActive, original.welfareActive);
      expect(restored.companyName, original.companyName);
      expect(restored.avatarUrl, original.avatarUrl);
    });
  });

  group('UserProfile.copyWith', () {
    test('changes name only', () {
      final original = makeProfile(name: 'Old Name');
      final updated = original.copyWith(name: 'New Name');
      expect(updated.name, 'New Name');
      expect(updated.email, original.email);
      expect(updated.category, original.category);
      expect(updated.puntiElmetto, original.puntiElmetto);
    });

    test('changes multiple fields', () {
      final original = makeProfile();
      final updated = original.copyWith(
        name: 'Updated',
        category: WorkerCategory.rspp,
        puntiElmetto: 9999,
        trustLevel: TrustLevel.expert,
        welfareActive: true,
      );
      expect(updated.name, 'Updated');
      expect(updated.category, WorkerCategory.rspp);
      expect(updated.puntiElmetto, 9999);
      expect(updated.trustLevel, TrustLevel.expert);
      expect(updated.welfareActive, true);
    });

    test('preserves unchanged fields', () {
      final original = makeProfile(
        safetyScore: 88,
        streakDays: 10,
        reportsCount: 4,
      );
      final updated = original.copyWith(name: 'Changed');
      expect(updated.safetyScore, 88);
      expect(updated.streakDays, 10);
      expect(updated.reportsCount, 4);
      expect(updated.companyName, original.companyName);
    });

    test('preserves id and email (not changeable via copyWith)', () {
      final original = makeProfile(id: 'fixed_id', email: 'fixed@e.com');
      final updated = original.copyWith(
        name: 'Different',
        category: WorkerCategory.caposquadra,
      );
      expect(updated.id, 'fixed_id');
      expect(updated.email, 'fixed@e.com');
    });

    test('changes avatarUrl', () {
      final original = makeProfile(avatarUrl: null);
      final updated =
          original.copyWith(avatarUrl: 'https://new-avatar.com/pic.png');
      expect(updated.avatarUrl, 'https://new-avatar.com/pic.png');
    });
  });

  group('WorkerCategory', () {
    test('all values have non-empty label', () {
      for (final c in WorkerCategory.values) {
        expect(c.label, isNotEmpty, reason: '${c.name} has empty label');
        expect(c.labelEn, isNotEmpty, reason: '${c.name} has empty labelEn');
      }
    });

    test('all values have an icon', () {
      for (final c in WorkerCategory.values) {
        expect(c.icon, isNotNull, reason: '${c.name} has null icon');
      }
    });

    test('has exactly 4 categories', () {
      expect(WorkerCategory.values.length, 4);
    });
  });

  group('TrustLevel', () {
    test('all values have non-empty label', () {
      for (final t in TrustLevel.values) {
        expect(t.label, isNotEmpty, reason: '${t.name} has empty label');
        expect(t.labelEn, isNotEmpty, reason: '${t.name} has empty labelEn');
      }
    });

    test('stars range from 1 to 4', () {
      final stars = TrustLevel.values.map((t) => t.stars).toList();
      expect(stars, [1, 2, 3, 4]);
    });

    test('base has 1 star', () {
      expect(TrustLevel.base.stars, 1);
    });

    test('expert has 4 stars', () {
      expect(TrustLevel.expert.stars, 4);
    });

    test('all values have a color', () {
      for (final t in TrustLevel.values) {
        expect(t.color, isNotNull, reason: '${t.name} has null color');
      }
    });

    test('all values have an icon', () {
      for (final t in TrustLevel.values) {
        expect(t.icon, isNotNull, reason: '${t.name} has null icon');
      }
    });
  });
}
