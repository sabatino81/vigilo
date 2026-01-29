import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
  ];

  /// Simple greeting
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get hello;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcome(Object name);

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInButton;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Vigilo'**
  String get appName;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Workplace Safety'**
  String get appSubtitle;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Workplace Safety'**
  String get homeSubtitle;

  /// No description provided for @colorPalette.
  ///
  /// In en, this message translates to:
  /// **'Color Palette'**
  String get colorPalette;

  /// No description provided for @teamTitle.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get teamTitle;

  /// No description provided for @teamSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your work team'**
  String get teamSubtitle;

  /// No description provided for @sosTitle.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get sosTitle;

  /// No description provided for @sosSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Report, get help or activate SOS'**
  String get sosSubtitle;

  /// No description provided for @sosButton.
  ///
  /// In en, this message translates to:
  /// **'SAFETY'**
  String get sosButton;

  /// No description provided for @sosDescription.
  ///
  /// In en, this message translates to:
  /// **'Report a danger, get help or activate SOS'**
  String get sosDescription;

  /// No description provided for @puntiTitle.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get puntiTitle;

  /// No description provided for @puntiSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your safety points'**
  String get puntiSubtitle;

  /// No description provided for @imparaTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get imparaTitle;

  /// No description provided for @imparaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Educational content'**
  String get imparaSubtitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTeam.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get navTeam;

  /// No description provided for @navSos.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get navSos;

  /// No description provided for @navPunti.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get navPunti;

  /// No description provided for @navImpara.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get navImpara;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}'**
  String greeting(Object name);

  /// No description provided for @colorName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get colorName;

  /// No description provided for @colorHex.
  ///
  /// In en, this message translates to:
  /// **'Hex'**
  String get colorHex;

  /// No description provided for @colorUsage.
  ///
  /// In en, this message translates to:
  /// **'Usage'**
  String get colorUsage;

  /// No description provided for @colorPrimaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Yellow - Attention'**
  String get colorPrimaryDesc;

  /// No description provided for @colorOnPrimaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get colorOnPrimaryDesc;

  /// No description provided for @colorPrimaryContainerDesc.
  ///
  /// In en, this message translates to:
  /// **'Container'**
  String get colorPrimaryContainerDesc;

  /// No description provided for @colorSecondaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Green - OK'**
  String get colorSecondaryDesc;

  /// No description provided for @colorOnSecondaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get colorOnSecondaryDesc;

  /// No description provided for @colorSecondaryContainerDesc.
  ///
  /// In en, this message translates to:
  /// **'Container'**
  String get colorSecondaryContainerDesc;

  /// No description provided for @colorTertiaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Blue - Info'**
  String get colorTertiaryDesc;

  /// No description provided for @colorOnTertiaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get colorOnTertiaryDesc;

  /// No description provided for @colorTertiaryContainerDesc.
  ///
  /// In en, this message translates to:
  /// **'Container'**
  String get colorTertiaryContainerDesc;

  /// No description provided for @colorWarningDesc.
  ///
  /// In en, this message translates to:
  /// **'Orange - Warnings'**
  String get colorWarningDesc;

  /// No description provided for @colorOnWarningDesc.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get colorOnWarningDesc;

  /// No description provided for @colorWarningContainerDesc.
  ///
  /// In en, this message translates to:
  /// **'Container'**
  String get colorWarningContainerDesc;

  /// No description provided for @colorDangerDesc.
  ///
  /// In en, this message translates to:
  /// **'Red - SOS'**
  String get colorDangerDesc;

  /// No description provided for @colorOnDangerDesc.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get colorOnDangerDesc;

  /// No description provided for @colorDangerContainerDesc.
  ///
  /// In en, this message translates to:
  /// **'Container'**
  String get colorDangerContainerDesc;

  /// No description provided for @colorNeutralDesc.
  ///
  /// In en, this message translates to:
  /// **'Grey'**
  String get colorNeutralDesc;

  /// No description provided for @colorOnNeutralDesc.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get colorOnNeutralDesc;

  /// No description provided for @colorNeutralContainerDesc.
  ///
  /// In en, this message translates to:
  /// **'Container'**
  String get colorNeutralContainerDesc;

  /// No description provided for @colorSurfaceDesc.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get colorSurfaceDesc;

  /// No description provided for @colorOnSurfaceDesc.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get colorOnSurfaceDesc;

  /// No description provided for @colorSurfaceVariantDesc.
  ///
  /// In en, this message translates to:
  /// **'Variant'**
  String get colorSurfaceVariantDesc;

  /// No description provided for @colorOutlineDesc.
  ///
  /// In en, this message translates to:
  /// **'Borders'**
  String get colorOutlineDesc;

  /// No description provided for @colorOutlineVariantDesc.
  ///
  /// In en, this message translates to:
  /// **'Soft borders'**
  String get colorOutlineVariantDesc;

  /// No description provided for @puntiTotal.
  ///
  /// In en, this message translates to:
  /// **'Total points'**
  String get puntiTotal;

  /// No description provided for @sendSos.
  ///
  /// In en, this message translates to:
  /// **'SEND SOS'**
  String get sendSos;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @safetyScore.
  ///
  /// In en, this message translates to:
  /// **'SAFETY SCORE'**
  String get safetyScore;

  /// No description provided for @scoreOutOf.
  ///
  /// In en, this message translates to:
  /// **'/ 100'**
  String get scoreOutOf;

  /// No description provided for @trendVsYesterday.
  ///
  /// In en, this message translates to:
  /// **'vs yesterday'**
  String get trendVsYesterday;

  /// No description provided for @metricStress.
  ///
  /// In en, this message translates to:
  /// **'Stress'**
  String get metricStress;

  /// No description provided for @metricHydration.
  ///
  /// In en, this message translates to:
  /// **'Hydration'**
  String get metricHydration;

  /// No description provided for @metricFatigue.
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get metricFatigue;

  /// No description provided for @metricRest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get metricRest;

  /// No description provided for @dpiStatus.
  ///
  /// In en, this message translates to:
  /// **'PPE STATUS'**
  String get dpiStatus;

  /// No description provided for @dpiHelmet.
  ///
  /// In en, this message translates to:
  /// **'Helmet'**
  String get dpiHelmet;

  /// No description provided for @dpiSafetyShoes.
  ///
  /// In en, this message translates to:
  /// **'Safety\nshoes'**
  String get dpiSafetyShoes;

  /// No description provided for @dpiGloves.
  ///
  /// In en, this message translates to:
  /// **'Gloves'**
  String get dpiGloves;

  /// No description provided for @dpiStatusOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get dpiStatusOk;

  /// No description provided for @dpiStatusBatteryLow.
  ///
  /// In en, this message translates to:
  /// **'Low\nbattery'**
  String get dpiStatusBatteryLow;

  /// No description provided for @smartBreak.
  ///
  /// In en, this message translates to:
  /// **'SMART BREAK'**
  String get smartBreak;

  /// No description provided for @breakRemaining.
  ///
  /// In en, this message translates to:
  /// **'Break remaining'**
  String get breakRemaining;

  /// No description provided for @breakMinutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get breakMinutes;

  /// No description provided for @showShadeZone.
  ///
  /// In en, this message translates to:
  /// **'Show shade zone'**
  String get showShadeZone;

  /// No description provided for @teamChallenge.
  ///
  /// In en, this message translates to:
  /// **'TEAM CHALLENGE'**
  String get teamChallenge;

  /// No description provided for @zeroInjuriesWeek.
  ///
  /// In en, this message translates to:
  /// **'Zero Injuries Week'**
  String get zeroInjuriesWeek;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @hotStreak.
  ///
  /// In en, this message translates to:
  /// **'HOT STREAK:'**
  String get hotStreak;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @goToChallenge.
  ///
  /// In en, this message translates to:
  /// **'Go to challenge'**
  String get goToChallenge;

  /// No description provided for @dailyTodo.
  ///
  /// In en, this message translates to:
  /// **'DAILY TO-DO'**
  String get dailyTodo;

  /// No description provided for @weeklyQuiz.
  ///
  /// In en, this message translates to:
  /// **'Weekly quiz'**
  String get weeklyQuiz;

  /// No description provided for @safetySurvey.
  ///
  /// In en, this message translates to:
  /// **'Safety survey'**
  String get safetySurvey;

  /// No description provided for @safetyReport.
  ///
  /// In en, this message translates to:
  /// **'Safety report'**
  String get safetyReport;

  /// No description provided for @microTraining.
  ///
  /// In en, this message translates to:
  /// **'5\' Micro-training'**
  String get microTraining;

  /// No description provided for @actionStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get actionStart;

  /// No description provided for @actionAnswer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get actionAnswer;

  /// No description provided for @actionSos.
  ///
  /// In en, this message translates to:
  /// **'SOS'**
  String get actionSos;

  /// No description provided for @actionWatch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get actionWatch;

  /// No description provided for @personalKpi.
  ///
  /// In en, this message translates to:
  /// **'MY NUMBERS'**
  String get personalKpi;

  /// No description provided for @kpiTodoCompleted.
  ///
  /// In en, this message translates to:
  /// **'Tasks completed this week'**
  String get kpiTodoCompleted;

  /// No description provided for @kpiSafetyRecalls.
  ///
  /// In en, this message translates to:
  /// **'Safety recalls'**
  String get kpiSafetyRecalls;

  /// No description provided for @kpiPointsToday.
  ///
  /// In en, this message translates to:
  /// **'Points earned today'**
  String get kpiPointsToday;

  /// No description provided for @teamLabel.
  ///
  /// In en, this message translates to:
  /// **'Your team'**
  String get teamLabel;

  /// No description provided for @pointsAbbr.
  ///
  /// In en, this message translates to:
  /// **'pt'**
  String get pointsAbbr;

  /// No description provided for @activeChallenge.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE CHALLENGE'**
  String get activeChallenge;

  /// No description provided for @teamProgress.
  ///
  /// In en, this message translates to:
  /// **'Team progress'**
  String get teamProgress;

  /// No description provided for @deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline;

  /// No description provided for @dailyObjective.
  ///
  /// In en, this message translates to:
  /// **'Daily objective: 0 negative reports'**
  String get dailyObjective;

  /// No description provided for @teamBonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus: +{points} pt for the team'**
  String teamBonus(Object points);

  /// No description provided for @challengeDetails.
  ///
  /// In en, this message translates to:
  /// **'Go to challenge details'**
  String get challengeDetails;

  /// No description provided for @leaderboard.
  ///
  /// In en, this message translates to:
  /// **'LEADERBOARD'**
  String get leaderboard;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get live;

  /// No description provided for @teamMembers.
  ///
  /// In en, this message translates to:
  /// **'TEAM MEMBERS'**
  String get teamMembers;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @openTeamChat.
  ///
  /// In en, this message translates to:
  /// **'Open team chat'**
  String get openTeamChat;

  /// No description provided for @safetyStarTitle.
  ///
  /// In en, this message translates to:
  /// **'SAFETY STAR OF THE WEEK'**
  String get safetyStarTitle;

  /// No description provided for @winner.
  ///
  /// In en, this message translates to:
  /// **'Winner'**
  String get winner;

  /// No description provided for @motivation.
  ///
  /// In en, this message translates to:
  /// **'Motivation'**
  String get motivation;

  /// No description provided for @nominatedBy.
  ///
  /// In en, this message translates to:
  /// **'Nominated by: {names}'**
  String nominatedBy(Object names);

  /// No description provided for @nominateColleague.
  ///
  /// In en, this message translates to:
  /// **'Nominate a colleague'**
  String get nominateColleague;

  /// No description provided for @vowSurveyTitle.
  ///
  /// In en, this message translates to:
  /// **'SURVEY — Voice of Worker'**
  String get vowSurveyTitle;

  /// No description provided for @surveyStatus.
  ///
  /// In en, this message translates to:
  /// **'Status: DRAFT ({answered}/{total} answers)'**
  String surveyStatus(Object answered, Object total);

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question {number}'**
  String question(Object number);

  /// No description provided for @questionSafety.
  ///
  /// In en, this message translates to:
  /// **'Did you feel safe today?'**
  String get questionSafety;

  /// No description provided for @questionRisk.
  ///
  /// In en, this message translates to:
  /// **'What was the biggest risk?'**
  String get questionRisk;

  /// No description provided for @questionReported.
  ///
  /// In en, this message translates to:
  /// **'Did you report a hazard?'**
  String get questionReported;

  /// No description provided for @questionComment.
  ///
  /// In en, this message translates to:
  /// **'Free comment'**
  String get questionComment;

  /// No description provided for @riskEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get riskEquipment;

  /// No description provided for @riskProcedures.
  ///
  /// In en, this message translates to:
  /// **'Procedures'**
  String get riskProcedures;

  /// No description provided for @riskEnvironment.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get riskEnvironment;

  /// No description provided for @riskOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get riskOther;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @writeHere.
  ///
  /// In en, this message translates to:
  /// **'Write here...'**
  String get writeHere;

  /// No description provided for @submitSurvey.
  ///
  /// In en, this message translates to:
  /// **'Submit survey'**
  String get submitSurvey;

  /// No description provided for @socialWallTitle.
  ///
  /// In en, this message translates to:
  /// **'SOCIAL WALL'**
  String get socialWallTitle;

  /// No description provided for @topPost.
  ///
  /// In en, this message translates to:
  /// **'Top post: \"{post}\"'**
  String topPost(Object post);

  /// No description provided for @createPost.
  ///
  /// In en, this message translates to:
  /// **'Create a post'**
  String get createPost;

  /// No description provided for @viewAllPosts.
  ///
  /// In en, this message translates to:
  /// **'View all posts'**
  String get viewAllPosts;

  /// No description provided for @wellnessTitle.
  ///
  /// In en, this message translates to:
  /// **'HOW ARE YOU FEELING TODAY?'**
  String get wellnessTitle;

  /// No description provided for @moodGreat.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get moodGreat;

  /// No description provided for @moodOkay.
  ///
  /// In en, this message translates to:
  /// **'So-so'**
  String get moodOkay;

  /// No description provided for @moodStressed.
  ///
  /// In en, this message translates to:
  /// **'Stressed'**
  String get moodStressed;

  /// No description provided for @anonymousData.
  ///
  /// In en, this message translates to:
  /// **'Anonymous - aggregated team data'**
  String get anonymousData;

  /// No description provided for @transparencyTitle.
  ///
  /// In en, this message translates to:
  /// **'\"YOU SAID → WE DID\"'**
  String get transparencyTitle;

  /// No description provided for @statusResolved.
  ///
  /// In en, this message translates to:
  /// **'RESOLVED'**
  String get statusResolved;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'IN PROGRESS'**
  String get statusInProgress;

  /// No description provided for @statusEvaluating.
  ///
  /// In en, this message translates to:
  /// **'EVALUATING'**
  String get statusEvaluating;

  /// No description provided for @statusNew.
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get statusNew;

  /// No description provided for @viewAllRequests.
  ///
  /// In en, this message translates to:
  /// **'View all requests'**
  String get viewAllRequests;

  /// No description provided for @welcomeGuideTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR SAFETY AT YOUR FINGERTIPS'**
  String get welcomeGuideTitle;

  /// No description provided for @ppeProtected.
  ///
  /// In en, this message translates to:
  /// **'REQUIRED PPE'**
  String get ppeProtected;

  /// No description provided for @welcomeBoots.
  ///
  /// In en, this message translates to:
  /// **'Safety boots'**
  String get welcomeBoots;

  /// No description provided for @welcomeVest.
  ///
  /// In en, this message translates to:
  /// **'Safety vest'**
  String get welcomeVest;

  /// No description provided for @welcomeFeature1.
  ///
  /// In en, this message translates to:
  /// **'Check your Safety Score'**
  String get welcomeFeature1;

  /// No description provided for @welcomeFeature2.
  ///
  /// In en, this message translates to:
  /// **'Declare PPE worn at check-in'**
  String get welcomeFeature2;

  /// No description provided for @welcomeFeature3.
  ///
  /// In en, this message translates to:
  /// **'Report danger with SOS'**
  String get welcomeFeature3;

  /// No description provided for @welcomeFeature4.
  ///
  /// In en, this message translates to:
  /// **'Complete daily tasks'**
  String get welcomeFeature4;

  /// No description provided for @openQuickGuide.
  ///
  /// In en, this message translates to:
  /// **'Open quick guide'**
  String get openQuickGuide;

  /// No description provided for @sosPageTitle.
  ///
  /// In en, this message translates to:
  /// **'SAFETY'**
  String get sosPageTitle;

  /// No description provided for @sosPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Report a danger, get help or activate SOS'**
  String get sosPageSubtitle;

  /// No description provided for @sosEmergencySection.
  ///
  /// In en, this message translates to:
  /// **'EMERGENCY'**
  String get sosEmergencySection;

  /// No description provided for @sosHoldInstruction.
  ///
  /// In en, this message translates to:
  /// **'Hold the \"Safety\" button for 3 seconds to activate a real SOS.'**
  String get sosHoldInstruction;

  /// No description provided for @sosHoldToActivate.
  ///
  /// In en, this message translates to:
  /// **'Hold for SOS'**
  String get sosHoldToActivate;

  /// No description provided for @sosReleaseToCancel.
  ///
  /// In en, this message translates to:
  /// **'Release to cancel'**
  String get sosReleaseToCancel;

  /// No description provided for @sosConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm SOS request?'**
  String get sosConfirmTitle;

  /// No description provided for @sosConfirmSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This will immediately notify:'**
  String get sosConfirmSubtitle;

  /// No description provided for @sosConfirmSend.
  ///
  /// In en, this message translates to:
  /// **'SEND NOW'**
  String get sosConfirmSend;

  /// No description provided for @sosConfirmCancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get sosConfirmCancel;

  /// No description provided for @sosSentTitle.
  ///
  /// In en, this message translates to:
  /// **'SOS SENT'**
  String get sosSentTitle;

  /// No description provided for @sosSentSignal.
  ///
  /// In en, this message translates to:
  /// **'Signal sent to contacts'**
  String get sosSentSignal;

  /// No description provided for @sosSentLocation.
  ///
  /// In en, this message translates to:
  /// **'Location shared'**
  String get sosSentLocation;

  /// No description provided for @sosSentMovement.
  ///
  /// In en, this message translates to:
  /// **'Last 60s of movement recorded'**
  String get sosSentMovement;

  /// No description provided for @sosSentMessage.
  ///
  /// In en, this message translates to:
  /// **'Stay where you are if possible.\nWe\'re on our way.'**
  String get sosSentMessage;

  /// No description provided for @sosSentConfirm.
  ///
  /// In en, this message translates to:
  /// **'GOT IT'**
  String get sosSentConfirm;

  /// No description provided for @quickReportsSection.
  ///
  /// In en, this message translates to:
  /// **'QUICK REPORTS'**
  String get quickReportsSection;

  /// No description provided for @quickReportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Report a non-urgent issue'**
  String get quickReportsSubtitle;

  /// No description provided for @reportTypeDanger.
  ///
  /// In en, this message translates to:
  /// **'Imminent Danger'**
  String get reportTypeDanger;

  /// No description provided for @reportTypeDangerDesc.
  ///
  /// In en, this message translates to:
  /// **'Unstable material, obstacle, fall risk...'**
  String get reportTypeDangerDesc;

  /// No description provided for @reportTypeNearMiss.
  ///
  /// In en, this message translates to:
  /// **'Near Miss'**
  String get reportTypeNearMiss;

  /// No description provided for @reportTypeNearMissDesc.
  ///
  /// In en, this message translates to:
  /// **'Near accident, avoided risk'**
  String get reportTypeNearMissDesc;

  /// No description provided for @reportTypeInjury.
  ///
  /// In en, this message translates to:
  /// **'Minor Injury'**
  String get reportTypeInjury;

  /// No description provided for @reportTypeInjuryDesc.
  ///
  /// In en, this message translates to:
  /// **'Slips, bumps, small cuts...'**
  String get reportTypeInjuryDesc;

  /// No description provided for @reportTypeImprovement.
  ///
  /// In en, this message translates to:
  /// **'Improvement'**
  String get reportTypeImprovement;

  /// No description provided for @reportTypeImprovementDesc.
  ///
  /// In en, this message translates to:
  /// **'Something to fix or optimize'**
  String get reportTypeImprovementDesc;

  /// No description provided for @emergencyContactsSection.
  ///
  /// In en, this message translates to:
  /// **'SAFETY CONTACTS'**
  String get emergencyContactsSection;

  /// No description provided for @contactShiftSupervisor.
  ///
  /// In en, this message translates to:
  /// **'Shift Supervisor'**
  String get contactShiftSupervisor;

  /// No description provided for @contactOperationsCenter.
  ///
  /// In en, this message translates to:
  /// **'Operations Center'**
  String get contactOperationsCenter;

  /// No description provided for @contactCompanySafety.
  ///
  /// In en, this message translates to:
  /// **'Company Safety'**
  String get contactCompanySafety;

  /// No description provided for @contact118.
  ///
  /// In en, this message translates to:
  /// **'Emergency 118'**
  String get contact118;

  /// No description provided for @contactFamily.
  ///
  /// In en, this message translates to:
  /// **'Family Contact'**
  String get contactFamily;

  /// No description provided for @reportHistorySection.
  ///
  /// In en, this message translates to:
  /// **'MY REPORTS'**
  String get reportHistorySection;

  /// No description provided for @reportHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No reports'**
  String get reportHistoryEmpty;

  /// No description provided for @reportHistoryViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get reportHistoryViewAll;

  /// No description provided for @reportStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get reportStatusPending;

  /// No description provided for @reportStatusUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Under Review'**
  String get reportStatusUnderReview;

  /// No description provided for @reportStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get reportStatusInProgress;

  /// No description provided for @reportStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get reportStatusApproved;

  /// No description provided for @reportStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get reportStatusClosed;

  /// No description provided for @reportFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Report {type}'**
  String reportFormTitle(Object type);

  /// No description provided for @reportFormDescription.
  ///
  /// In en, this message translates to:
  /// **'Describe what you saw'**
  String get reportFormDescription;

  /// No description provided for @reportFormDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue in detail...'**
  String get reportFormDescriptionHint;

  /// No description provided for @reportFormDescriptionError.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 10 characters'**
  String get reportFormDescriptionError;

  /// No description provided for @reportFormPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo (optional)'**
  String get reportFormPhoto;

  /// No description provided for @reportFormPhotoButton.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get reportFormPhotoButton;

  /// No description provided for @reportFormLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get reportFormLocation;

  /// No description provided for @reportFormLocationAuto.
  ///
  /// In en, this message translates to:
  /// **'Location detected automatically'**
  String get reportFormLocationAuto;

  /// No description provided for @reportFormContact.
  ///
  /// In en, this message translates to:
  /// **'Do you want to be contacted?'**
  String get reportFormContact;

  /// No description provided for @reportFormContactDesc.
  ///
  /// In en, this message translates to:
  /// **'The manager may call you for more details'**
  String get reportFormContactDesc;

  /// No description provided for @reportFormSubmit.
  ///
  /// In en, this message translates to:
  /// **'SUBMIT REPORT'**
  String get reportFormSubmit;

  /// No description provided for @reportFormSuccess.
  ///
  /// In en, this message translates to:
  /// **'REPORT SUBMITTED'**
  String get reportFormSuccess;

  /// No description provided for @reportFormSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Thanks, your report has been received and will be reviewed by RSPP.'**
  String get reportFormSuccessMessage;

  /// No description provided for @reportFormSuccessId.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String reportFormSuccessId(Object id);

  /// No description provided for @reportDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Details'**
  String get reportDetailTitle;

  /// No description provided for @reportDetailDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get reportDetailDate;

  /// No description provided for @reportDetailLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get reportDetailLocation;

  /// No description provided for @reportDetailContactRequested.
  ///
  /// In en, this message translates to:
  /// **'Contact requested'**
  String get reportDetailContactRequested;

  /// No description provided for @reportDetailDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get reportDetailDescription;

  /// No description provided for @reportDetailPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get reportDetailPhotos;

  /// No description provided for @reportDetailRsppNotes.
  ///
  /// In en, this message translates to:
  /// **'RSPP Notes'**
  String get reportDetailRsppNotes;

  /// No description provided for @reportDetailClosed.
  ///
  /// In en, this message translates to:
  /// **'Report closed'**
  String get reportDetailClosed;

  /// No description provided for @puntiWallet.
  ///
  /// In en, this message translates to:
  /// **'WALLET'**
  String get puntiWallet;

  /// No description provided for @puntiPoints.
  ///
  /// In en, this message translates to:
  /// **'points'**
  String get puntiPoints;

  /// No description provided for @puntiLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String puntiLevel(Object level);

  /// No description provided for @puntiNextLevel.
  ///
  /// In en, this message translates to:
  /// **'Next: {level} ({points} pt)'**
  String puntiNextLevel(Object level, Object points);

  /// No description provided for @puntiRecentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent transactions'**
  String get puntiRecentTransactions;

  /// No description provided for @puntiViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get puntiViewAll;

  /// No description provided for @puntiCatalog.
  ///
  /// In en, this message translates to:
  /// **'REWARDS CATALOG'**
  String get puntiCatalog;

  /// No description provided for @puntiCatalogViewAll.
  ///
  /// In en, this message translates to:
  /// **'View full catalog'**
  String get puntiCatalogViewAll;

  /// No description provided for @puntiAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get puntiAvailable;

  /// No description provided for @puntiLimited.
  ///
  /// In en, this message translates to:
  /// **'Limited'**
  String get puntiLimited;

  /// No description provided for @puntiOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get puntiOutOfStock;

  /// No description provided for @puntiCategoryVoucher.
  ///
  /// In en, this message translates to:
  /// **'Vouchers'**
  String get puntiCategoryVoucher;

  /// No description provided for @puntiCategoryPpe.
  ///
  /// In en, this message translates to:
  /// **'PPE'**
  String get puntiCategoryPpe;

  /// No description provided for @puntiCategoryGadget.
  ///
  /// In en, this message translates to:
  /// **'Gadget'**
  String get puntiCategoryGadget;

  /// No description provided for @puntiCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get puntiCategoryOther;

  /// No description provided for @puntiSortByPointsAsc.
  ///
  /// In en, this message translates to:
  /// **'Points ↑'**
  String get puntiSortByPointsAsc;

  /// No description provided for @puntiSortByPointsDesc.
  ///
  /// In en, this message translates to:
  /// **'Points ↓'**
  String get puntiSortByPointsDesc;

  /// No description provided for @puntiSortByName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get puntiSortByName;

  /// No description provided for @puntiFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get puntiFilterAll;

  /// No description provided for @puntiSortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by:'**
  String get puntiSortBy;

  /// No description provided for @puntiStats.
  ///
  /// In en, this message translates to:
  /// **'STATISTICS'**
  String get puntiStats;

  /// No description provided for @puntiLast7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get puntiLast7Days;

  /// No description provided for @puntiLast30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get puntiLast30Days;

  /// No description provided for @puntiMissions.
  ///
  /// In en, this message translates to:
  /// **'{count} missions'**
  String puntiMissions(Object count);

  /// No description provided for @puntiWeeklyTrend.
  ///
  /// In en, this message translates to:
  /// **'Weekly trend'**
  String get puntiWeeklyTrend;

  /// No description provided for @puntiLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'LEADERBOARD'**
  String get puntiLeaderboard;

  /// No description provided for @puntiLive.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get puntiLive;

  /// No description provided for @puntiYou.
  ///
  /// In en, this message translates to:
  /// **'YOU'**
  String get puntiYou;

  /// No description provided for @puntiInstantWin.
  ///
  /// In en, this message translates to:
  /// **'INSTANT WIN'**
  String get puntiInstantWin;

  /// No description provided for @puntiSpinWheel.
  ///
  /// In en, this message translates to:
  /// **'Spin the wheel every day!'**
  String get puntiSpinWheel;

  /// No description provided for @puntiSpinAvailable.
  ///
  /// In en, this message translates to:
  /// **'1 SPIN AVAILABLE'**
  String get puntiSpinAvailable;

  /// No description provided for @puntiSpinUsed.
  ///
  /// In en, this message translates to:
  /// **'Already used today'**
  String get puntiSpinUsed;

  /// No description provided for @puntiSpinAction.
  ///
  /// In en, this message translates to:
  /// **'SPIN NOW'**
  String get puntiSpinAction;

  /// No description provided for @puntiSpinComeBack.
  ///
  /// In en, this message translates to:
  /// **'Come back tomorrow'**
  String get puntiSpinComeBack;

  /// No description provided for @puntiSpinWheelTitle.
  ///
  /// In en, this message translates to:
  /// **'Spin the Wheel'**
  String get puntiSpinWheelTitle;

  /// No description provided for @puntiSpinInfo.
  ///
  /// In en, this message translates to:
  /// **'You have 1 free spin available!'**
  String get puntiSpinInfo;

  /// No description provided for @puntiSpinUsedInfo.
  ///
  /// In en, this message translates to:
  /// **'You already used your spin today'**
  String get puntiSpinUsedInfo;

  /// No description provided for @puntiSpinButton.
  ///
  /// In en, this message translates to:
  /// **'SPIN THE WHEEL'**
  String get puntiSpinButton;

  /// No description provided for @puntiSpinning.
  ///
  /// In en, this message translates to:
  /// **'THE WHEEL IS SPINNING...'**
  String get puntiSpinning;

  /// No description provided for @puntiSpinTomorrow.
  ///
  /// In en, this message translates to:
  /// **'COME BACK TOMORROW'**
  String get puntiSpinTomorrow;

  /// No description provided for @puntiSpinCongrats.
  ///
  /// In en, this message translates to:
  /// **'CONGRATULATIONS!'**
  String get puntiSpinCongrats;

  /// No description provided for @puntiSpinNoWin.
  ///
  /// In en, this message translates to:
  /// **'NO PRIZE TODAY'**
  String get puntiSpinNoWin;

  /// No description provided for @puntiSpinWon.
  ///
  /// In en, this message translates to:
  /// **'YOU WON:'**
  String get puntiSpinWon;

  /// No description provided for @puntiSpinNewBalance.
  ///
  /// In en, this message translates to:
  /// **'New balance: {points} pt'**
  String puntiSpinNewBalance(Object points);

  /// No description provided for @puntiSpinResult.
  ///
  /// In en, this message translates to:
  /// **'The wheel stopped on: {prize}'**
  String puntiSpinResult(Object prize);

  /// No description provided for @puntiSpinTryTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Try again tomorrow with your free spin!'**
  String get puntiSpinTryTomorrow;

  /// No description provided for @puntiSpinGreat.
  ///
  /// In en, this message translates to:
  /// **'AWESOME!'**
  String get puntiSpinGreat;

  /// No description provided for @puntiSpinOk.
  ///
  /// In en, this message translates to:
  /// **'OK, GOT IT'**
  String get puntiSpinOk;

  /// No description provided for @puntiRewardDetail.
  ///
  /// In en, this message translates to:
  /// **'Reward Details'**
  String get puntiRewardDetail;

  /// No description provided for @puntiRewardCost.
  ///
  /// In en, this message translates to:
  /// **'{cost} points'**
  String puntiRewardCost(Object cost);

  /// No description provided for @puntiRewardDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get puntiRewardDescription;

  /// No description provided for @puntiRewardDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery method'**
  String get puntiRewardDelivery;

  /// No description provided for @puntiRewardRedeem.
  ///
  /// In en, this message translates to:
  /// **'REDEEM NOW'**
  String get puntiRewardRedeem;

  /// No description provided for @puntiRewardNotEnough.
  ///
  /// In en, this message translates to:
  /// **'You need {points} more points'**
  String puntiRewardNotEnough(Object points);

  /// No description provided for @puntiRewardUnavailable.
  ///
  /// In en, this message translates to:
  /// **'NOT AVAILABLE'**
  String get puntiRewardUnavailable;

  /// No description provided for @puntiLevelBronze.
  ///
  /// In en, this message translates to:
  /// **'Bronze'**
  String get puntiLevelBronze;

  /// No description provided for @puntiLevelSilver.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get puntiLevelSilver;

  /// No description provided for @puntiLevelGold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get puntiLevelGold;

  /// No description provided for @puntiLevelPlatinum.
  ///
  /// In en, this message translates to:
  /// **'Platinum'**
  String get puntiLevelPlatinum;

  /// No description provided for @puntiLevelDiamond.
  ///
  /// In en, this message translates to:
  /// **'Diamond'**
  String get puntiLevelDiamond;

  /// No description provided for @puntiTransactionEarned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get puntiTransactionEarned;

  /// No description provided for @puntiTransactionSpent.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get puntiTransactionSpent;

  /// No description provided for @puntiTransactionBonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus'**
  String get puntiTransactionBonus;

  /// No description provided for @puntiTransactionPenalty.
  ///
  /// In en, this message translates to:
  /// **'Penalty'**
  String get puntiTransactionPenalty;

  /// No description provided for @imparaTrainingTodo.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S TRAINING'**
  String get imparaTrainingTodo;

  /// No description provided for @imparaLibrary.
  ///
  /// In en, this message translates to:
  /// **'LIBRARY'**
  String get imparaLibrary;

  /// No description provided for @imparaSearchContents.
  ///
  /// In en, this message translates to:
  /// **'Search contents...'**
  String get imparaSearchContents;

  /// No description provided for @imparaSuggestedContents.
  ///
  /// In en, this message translates to:
  /// **'Suggested contents:'**
  String get imparaSuggestedContents;

  /// No description provided for @imparaViewAllLibrary.
  ///
  /// In en, this message translates to:
  /// **'View full library'**
  String get imparaViewAllLibrary;

  /// No description provided for @imparaTrainingProgress.
  ///
  /// In en, this message translates to:
  /// **'TRAINING PROGRESS'**
  String get imparaTrainingProgress;

  /// No description provided for @imparaProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'Progress:'**
  String get imparaProgressLabel;

  /// No description provided for @imparaModulesCompleted.
  ///
  /// In en, this message translates to:
  /// **'Modules completed: {completed} / {total}'**
  String imparaModulesCompleted(Object completed, Object total);

  /// No description provided for @imparaModulesInProgress.
  ///
  /// In en, this message translates to:
  /// **'Modules in progress:'**
  String get imparaModulesInProgress;

  /// No description provided for @imparaCertificatesObtained.
  ///
  /// In en, this message translates to:
  /// **'Certificates obtained:'**
  String get imparaCertificatesObtained;

  /// No description provided for @imparaCertificateExpiring.
  ///
  /// In en, this message translates to:
  /// **'Expiring soon'**
  String get imparaCertificateExpiring;

  /// No description provided for @imparaCertificateValid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get imparaCertificateValid;

  /// No description provided for @imparaRecommendedForYou.
  ///
  /// In en, this message translates to:
  /// **'RECOMMENDED FOR YOU'**
  String get imparaRecommendedForYou;

  /// No description provided for @imparaContentVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get imparaContentVideo;

  /// No description provided for @imparaContentPdf.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get imparaContentPdf;

  /// No description provided for @imparaContentQuiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get imparaContentQuiz;

  /// No description provided for @imparaContentLesson.
  ///
  /// In en, this message translates to:
  /// **'Lesson'**
  String get imparaContentLesson;

  /// No description provided for @imparaCategorySafety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get imparaCategorySafety;

  /// No description provided for @imparaCategoryProcedures.
  ///
  /// In en, this message translates to:
  /// **'Procedures'**
  String get imparaCategoryProcedures;

  /// No description provided for @imparaCategoryEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get imparaCategoryEquipment;

  /// No description provided for @imparaCategoryEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get imparaCategoryEmergency;

  /// No description provided for @imparaCategoryWellbeing.
  ///
  /// In en, this message translates to:
  /// **'Wellbeing'**
  String get imparaCategoryWellbeing;

  /// No description provided for @imparaStatusNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get imparaStatusNotStarted;

  /// No description provided for @imparaStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get imparaStatusInProgress;

  /// No description provided for @imparaStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get imparaStatusCompleted;

  /// No description provided for @imparaTodoWatch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get imparaTodoWatch;

  /// No description provided for @imparaTodoStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get imparaTodoStart;

  /// No description provided for @imparaTodoRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get imparaTodoRead;

  /// No description provided for @imparaLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get imparaLibraryTitle;

  /// No description provided for @imparaContentsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} contents'**
  String imparaContentsCount(Object count);

  /// No description provided for @imparaFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get imparaFilterAll;

  /// No description provided for @imparaFilterAllCategories.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get imparaFilterAllCategories;

  /// No description provided for @imparaNoContentsFound.
  ///
  /// In en, this message translates to:
  /// **'No contents found'**
  String get imparaNoContentsFound;

  /// No description provided for @imparaContentMandatory.
  ///
  /// In en, this message translates to:
  /// **'Mandatory'**
  String get imparaContentMandatory;

  /// No description provided for @imparaContentStatus.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String imparaContentStatus(Object status);

  /// No description provided for @imparaContentProgressPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% completed'**
  String imparaContentProgressPercent(Object percent);

  /// No description provided for @imparaContentDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get imparaContentDescription;

  /// No description provided for @imparaContentSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get imparaContentSaved;

  /// No description provided for @imparaContentSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get imparaContentSave;

  /// No description provided for @imparaContentContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get imparaContentContinue;

  /// No description provided for @imparaContentWatchVideo.
  ///
  /// In en, this message translates to:
  /// **'Watch Video'**
  String get imparaContentWatchVideo;

  /// No description provided for @imparaContentOpenPdf.
  ///
  /// In en, this message translates to:
  /// **'Open PDF'**
  String get imparaContentOpenPdf;

  /// No description provided for @imparaContentStartAction.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get imparaContentStartAction;

  /// No description provided for @imparaContentOpening.
  ///
  /// In en, this message translates to:
  /// **'Opening {type}...'**
  String imparaContentOpening(Object type);

  /// No description provided for @imparaQuizQuestion.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String imparaQuizQuestion(Object current, Object total);

  /// No description provided for @imparaQuizBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get imparaQuizBack;

  /// No description provided for @imparaQuizNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get imparaQuizNext;

  /// No description provided for @imparaQuizFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish Quiz'**
  String get imparaQuizFinish;

  /// No description provided for @imparaQuizExitTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit quiz?'**
  String get imparaQuizExitTitle;

  /// No description provided for @imparaQuizExitMessage.
  ///
  /// In en, this message translates to:
  /// **'Your progress won\'t be saved.'**
  String get imparaQuizExitMessage;

  /// No description provided for @imparaQuizCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get imparaQuizCancel;

  /// No description provided for @imparaQuizExit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get imparaQuizExit;

  /// No description provided for @imparaQuizResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz Completed!'**
  String get imparaQuizResultTitle;

  /// No description provided for @imparaQuizResultScore.
  ///
  /// In en, this message translates to:
  /// **'{correct}/{total}'**
  String imparaQuizResultScore(Object correct, Object total);

  /// No description provided for @imparaQuizResultCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct answers'**
  String get imparaQuizResultCorrect;

  /// No description provided for @imparaQuizResultPassed.
  ///
  /// In en, this message translates to:
  /// **'PASSED'**
  String get imparaQuizResultPassed;

  /// No description provided for @imparaQuizResultFailed.
  ///
  /// In en, this message translates to:
  /// **'FAILED'**
  String get imparaQuizResultFailed;

  /// No description provided for @imparaQuizResultPassedMessage.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You passed the quiz.'**
  String get imparaQuizResultPassedMessage;

  /// No description provided for @imparaQuizResultFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'You didn\'t reach the minimum score. Try again!'**
  String get imparaQuizResultFailedMessage;

  /// No description provided for @imparaQuizResultEarned.
  ///
  /// In en, this message translates to:
  /// **'Points earned'**
  String get imparaQuizResultEarned;

  /// No description provided for @imparaQuizResultNoPoints.
  ///
  /// In en, this message translates to:
  /// **'No points'**
  String get imparaQuizResultNoPoints;

  /// No description provided for @imparaQuizResultMinScore.
  ///
  /// In en, this message translates to:
  /// **'Minimum score: 60%'**
  String get imparaQuizResultMinScore;

  /// No description provided for @imparaQuizResultSummary.
  ///
  /// In en, this message translates to:
  /// **'Answer summary'**
  String get imparaQuizResultSummary;

  /// No description provided for @imparaQuizResultRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry Quiz'**
  String get imparaQuizResultRetry;

  /// No description provided for @imparaQuizResultBackToLearn.
  ///
  /// In en, this message translates to:
  /// **'Back to Learn'**
  String get imparaQuizResultBackToLearn;

  /// No description provided for @imparaDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String imparaDurationMinutes(Object minutes);

  /// No description provided for @imparaDurationHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String imparaDurationHours(Object hours, Object minutes);

  /// No description provided for @walletTitle.
  ///
  /// In en, this message translates to:
  /// **'HELMET POINTS'**
  String get walletTitle;

  /// No description provided for @walletElmetto.
  ///
  /// In en, this message translates to:
  /// **'Helmet Points'**
  String get walletElmetto;

  /// No description provided for @walletConversionInfo.
  ///
  /// In en, this message translates to:
  /// **'{rate} pt = 1 EUR  |  Max {percent}% discount'**
  String walletConversionInfo(Object rate, Object percent);

  /// No description provided for @walletWelfareActive.
  ///
  /// In en, this message translates to:
  /// **'Welfare active (up to 100% discount)'**
  String get walletWelfareActive;

  /// No description provided for @walletWelfareCompany.
  ///
  /// In en, this message translates to:
  /// **'Welfare activated by {company}'**
  String walletWelfareCompany(Object company);

  /// No description provided for @walletLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String walletLevel(Object level);

  /// No description provided for @walletNextLevel.
  ///
  /// In en, this message translates to:
  /// **'Next: {level} ({points} pt)'**
  String walletNextLevel(Object level, Object points);

  /// No description provided for @walletRecentMoves.
  ///
  /// In en, this message translates to:
  /// **'Recent transactions'**
  String get walletRecentMoves;

  /// No description provided for @walletViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get walletViewAll;

  /// No description provided for @walletElmettoValue.
  ///
  /// In en, this message translates to:
  /// **'= {value} EUR'**
  String walletElmettoValue(Object value);

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'Company Store'**
  String get shopTitle;

  /// No description provided for @shopVigiloTitle.
  ///
  /// In en, this message translates to:
  /// **'Company Store'**
  String get shopVigiloTitle;

  /// No description provided for @shopVigiloSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your exclusive store: discounts and free products with your points'**
  String get shopVigiloSubtitle;

  /// No description provided for @shopSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get shopSearchHint;

  /// No description provided for @shopCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get shopCategoryAll;

  /// No description provided for @shopProductCount.
  ///
  /// In en, this message translates to:
  /// **'{count} products'**
  String shopProductCount(Object count);

  /// No description provided for @shopMarkupInfo.
  ///
  /// In en, this message translates to:
  /// **'30% markup included'**
  String get shopMarkupInfo;

  /// No description provided for @shopNoProducts.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get shopNoProducts;

  /// No description provided for @shopCategoryCasa.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get shopCategoryCasa;

  /// No description provided for @shopCategoryAbbigliamento.
  ///
  /// In en, this message translates to:
  /// **'Clothing'**
  String get shopCategoryAbbigliamento;

  /// No description provided for @shopCategoryTech.
  ///
  /// In en, this message translates to:
  /// **'Tech'**
  String get shopCategoryTech;

  /// No description provided for @shopCategoryConsumabili.
  ///
  /// In en, this message translates to:
  /// **'Consumables'**
  String get shopCategoryConsumabili;

  /// No description provided for @shopCategorySport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get shopCategorySport;

  /// No description provided for @shopCategoryVoucher.
  ///
  /// In en, this message translates to:
  /// **'Vouchers'**
  String get shopCategoryVoucher;

  /// No description provided for @shopBadgeGratis.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get shopBadgeGratis;

  /// No description provided for @shopBadgeScontato.
  ///
  /// In en, this message translates to:
  /// **'DISCOUNTED'**
  String get shopBadgeScontato;

  /// No description provided for @shopBadgePromo.
  ///
  /// In en, this message translates to:
  /// **'PROMO'**
  String get shopBadgePromo;

  /// No description provided for @shopSupplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier: {name}'**
  String shopSupplier(Object name);

  /// No description provided for @shopQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get shopQuantity;

  /// No description provided for @shopAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get shopAddToCart;

  /// No description provided for @shopAddFree.
  ///
  /// In en, this message translates to:
  /// **'Add for free'**
  String get shopAddFree;

  /// No description provided for @shopAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart: {name} x{qty}'**
  String shopAddedToCart(Object name, Object qty);

  /// No description provided for @shopGoToCart.
  ///
  /// In en, this message translates to:
  /// **'Go to cart'**
  String get shopGoToCart;

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'Cart ({count})'**
  String cartTitle(Object count);

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cart is empty'**
  String get cartEmpty;

  /// No description provided for @cartShipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping: {amount} EUR (always paid by worker)'**
  String cartShipping(Object amount);

  /// No description provided for @cartCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to checkout'**
  String get cartCheckout;

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @checkoutItems.
  ///
  /// In en, this message translates to:
  /// **'Items ({count})'**
  String checkoutItems(Object count);

  /// No description provided for @checkoutAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get checkoutAddress;

  /// No description provided for @checkoutPaymentSummary.
  ///
  /// In en, this message translates to:
  /// **'Payment summary'**
  String get checkoutPaymentSummary;

  /// No description provided for @checkoutSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get checkoutSubtotal;

  /// No description provided for @checkoutWelfare.
  ///
  /// In en, this message translates to:
  /// **'Welfare'**
  String get checkoutWelfare;

  /// No description provided for @checkoutElmettoDiscount.
  ///
  /// In en, this message translates to:
  /// **'Helmet discount ({points} pt)'**
  String checkoutElmettoDiscount(Object points);

  /// No description provided for @checkoutToPay.
  ///
  /// In en, this message translates to:
  /// **'To pay'**
  String get checkoutToPay;

  /// No description provided for @checkoutFree.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get checkoutFree;

  /// No description provided for @checkoutTotal.
  ///
  /// In en, this message translates to:
  /// **'TOTAL'**
  String get checkoutTotal;

  /// No description provided for @checkoutBnplLabel.
  ///
  /// In en, this message translates to:
  /// **'Pay in 3 installments with Scalapay'**
  String get checkoutBnplLabel;

  /// No description provided for @checkoutBnplRate.
  ///
  /// In en, this message translates to:
  /// **'{amount} EUR/month - interest paid by you'**
  String checkoutBnplRate(Object amount);

  /// No description provided for @checkoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm and pay'**
  String get checkoutConfirm;

  /// No description provided for @checkoutConfirmFree.
  ///
  /// In en, this message translates to:
  /// **'Confirm free order'**
  String get checkoutConfirmFree;

  /// No description provided for @checkoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Order confirmed!'**
  String get checkoutSuccess;

  /// No description provided for @checkoutSuccessFree.
  ///
  /// In en, this message translates to:
  /// **'Your order is confirmed. Fully covered by welfare!'**
  String get checkoutSuccessFree;

  /// No description provided for @checkoutSuccessBnpl.
  ///
  /// In en, this message translates to:
  /// **'You will pay in 3 installments of {amount} EUR/month with Scalapay.'**
  String checkoutSuccessBnpl(Object amount);

  /// No description provided for @checkoutSuccessCharged.
  ///
  /// In en, this message translates to:
  /// **'Total charged: {amount} EUR'**
  String checkoutSuccessCharged(Object amount);

  /// No description provided for @checkoutBackToShop.
  ///
  /// In en, this message translates to:
  /// **'Back to Store'**
  String get checkoutBackToShop;

  /// No description provided for @shopShipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shopShipping;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileSafetyStats.
  ///
  /// In en, this message translates to:
  /// **'Safety Statistics'**
  String get profileSafetyStats;

  /// No description provided for @profileSafetyScore.
  ///
  /// In en, this message translates to:
  /// **'Safety Score'**
  String get profileSafetyScore;

  /// No description provided for @profileStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get profileStreak;

  /// No description provided for @profileReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get profileReports;

  /// No description provided for @profileTrustLevel.
  ///
  /// In en, this message translates to:
  /// **'Trust Level'**
  String get profileTrustLevel;

  /// No description provided for @profileTrustBase.
  ///
  /// In en, this message translates to:
  /// **'Base'**
  String get profileTrustBase;

  /// No description provided for @profileTrustVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get profileTrustVerified;

  /// No description provided for @profileTrustTrusted.
  ///
  /// In en, this message translates to:
  /// **'Trusted'**
  String get profileTrustTrusted;

  /// No description provided for @profileTrustExpert.
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get profileTrustExpert;

  /// No description provided for @profileWorkerOperaio.
  ///
  /// In en, this message translates to:
  /// **'Worker'**
  String get profileWorkerOperaio;

  /// No description provided for @profileWorkerCaposquadra.
  ///
  /// In en, this message translates to:
  /// **'Team Lead'**
  String get profileWorkerCaposquadra;

  /// No description provided for @profileWorkerPreposto.
  ///
  /// In en, this message translates to:
  /// **'Supervisor'**
  String get profileWorkerPreposto;

  /// No description provided for @profileWorkerRspp.
  ///
  /// In en, this message translates to:
  /// **'Safety Officer'**
  String get profileWorkerRspp;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettings;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get profileTheme;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// No description provided for @profileBiometric.
  ///
  /// In en, this message translates to:
  /// **'Biometrics'**
  String get profileBiometric;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogout;

  /// No description provided for @profileActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get profileActive;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notificationsAll;

  /// No description provided for @notificationsCategorySafety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get notificationsCategorySafety;

  /// No description provided for @notificationsCategoryPoints.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get notificationsCategoryPoints;

  /// No description provided for @notificationsCategoryTeam.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get notificationsCategoryTeam;

  /// No description provided for @notificationsCategorySystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get notificationsCategorySystem;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get notificationsEmpty;

  /// No description provided for @notificationsToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get notificationsToday;

  /// No description provided for @notificationsYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get notificationsYesterday;

  /// No description provided for @notificationsThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get notificationsThisWeek;

  /// No description provided for @notificationsEarlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get notificationsEarlier;

  /// No description provided for @notificationsMinAgo.
  ///
  /// In en, this message translates to:
  /// **'{min} min ago'**
  String notificationsMinAgo(Object min);

  /// No description provided for @notificationsHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String notificationsHoursAgo(Object hours);

  /// No description provided for @notificationsDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String notificationsDaysAgo(Object days);

  /// No description provided for @streakTitle.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streakTitle;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String streakDays(Object count);

  /// No description provided for @streakMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Multiplier x{value}'**
  String streakMultiplier(Object value);

  /// No description provided for @streakDaysToNext.
  ///
  /// In en, this message translates to:
  /// **'{days} days to {level}'**
  String streakDaysToNext(Object days, Object level);

  /// No description provided for @streakCalendar.
  ///
  /// In en, this message translates to:
  /// **'Month calendar'**
  String get streakCalendar;

  /// No description provided for @streakLevels.
  ///
  /// In en, this message translates to:
  /// **'Streak Levels'**
  String get streakLevels;

  /// No description provided for @streakBestRecord.
  ///
  /// In en, this message translates to:
  /// **'Personal record'**
  String get streakBestRecord;

  /// No description provided for @streakLevelFiammella.
  ///
  /// In en, this message translates to:
  /// **'Spark'**
  String get streakLevelFiammella;

  /// No description provided for @streakLevelFuocherello.
  ///
  /// In en, this message translates to:
  /// **'Flame'**
  String get streakLevelFuocherello;

  /// No description provided for @streakLevelFalo.
  ///
  /// In en, this message translates to:
  /// **'Bonfire'**
  String get streakLevelFalo;

  /// No description provided for @streakLevelIncendio.
  ///
  /// In en, this message translates to:
  /// **'Blaze'**
  String get streakLevelIncendio;

  /// No description provided for @streakLevelInferno.
  ///
  /// In en, this message translates to:
  /// **'Inferno'**
  String get streakLevelInferno;

  /// No description provided for @streakDaysMin.
  ///
  /// In en, this message translates to:
  /// **'{days}+ days  |  x{multiplier}'**
  String streakDaysMin(Object days, Object multiplier);

  /// No description provided for @challengeTitle.
  ///
  /// In en, this message translates to:
  /// **'Team Challenge'**
  String get challengeTitle;

  /// No description provided for @challengeTeamContributions.
  ///
  /// In en, this message translates to:
  /// **'Team Contributions'**
  String get challengeTeamContributions;

  /// No description provided for @challengeHistory.
  ///
  /// In en, this message translates to:
  /// **'Challenge History'**
  String get challengeHistory;

  /// No description provided for @challengeTimeRemaining.
  ///
  /// In en, this message translates to:
  /// **'{value} remaining'**
  String challengeTimeRemaining(Object value);

  /// No description provided for @challengeExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get challengeExpired;

  /// No description provided for @challengeBonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus: +{points} pt'**
  String challengeBonus(Object points);

  /// No description provided for @challengePoints.
  ///
  /// In en, this message translates to:
  /// **'{current} / {target} points'**
  String challengePoints(Object current, Object target);

  /// No description provided for @pointsEarnedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'+{points} Helmet Points'**
  String pointsEarnedSnackbar(Object points);

  /// No description provided for @pointsEarnedAction.
  ///
  /// In en, this message translates to:
  /// **'+{points} Helmet Points - {action}'**
  String pointsEarnedAction(Object points, Object action);

  /// No description provided for @pointsActionCheckin.
  ///
  /// In en, this message translates to:
  /// **'Wellness check-in'**
  String get pointsActionCheckin;

  /// No description provided for @pointsActionReport.
  ///
  /// In en, this message translates to:
  /// **'Safety report'**
  String get pointsActionReport;

  /// No description provided for @pointsActionQuiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz completed'**
  String get pointsActionQuiz;

  /// No description provided for @pointsActionAccess.
  ///
  /// In en, this message translates to:
  /// **'Shift check-in'**
  String get pointsActionAccess;

  /// No description provided for @pointsActionSurvey.
  ///
  /// In en, this message translates to:
  /// **'Safety survey'**
  String get pointsActionSurvey;

  /// No description provided for @wellnessNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)...'**
  String get wellnessNoteHint;

  /// No description provided for @wellnessSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send check-in'**
  String get wellnessSubmit;

  /// No description provided for @wellnessSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Check-in sent! +10 points'**
  String get wellnessSubmitted;

  /// No description provided for @wellnessMoodGreat.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get wellnessMoodGreat;

  /// No description provided for @wellnessMoodGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get wellnessMoodGood;

  /// No description provided for @wellnessMoodOkay.
  ///
  /// In en, this message translates to:
  /// **'So-so'**
  String get wellnessMoodOkay;

  /// No description provided for @wellnessMoodStressed.
  ///
  /// In en, this message translates to:
  /// **'Stressed'**
  String get wellnessMoodStressed;

  /// No description provided for @wellnessMoodBad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get wellnessMoodBad;

  /// No description provided for @vowSurveyPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Voice of Worker'**
  String get vowSurveyPageTitle;

  /// No description provided for @vowSurveyQuestion.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String vowSurveyQuestion(Object current, Object total);

  /// No description provided for @vowSurveyAnonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get vowSurveyAnonymous;

  /// No description provided for @vowSurveyBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get vowSurveyBack;

  /// No description provided for @vowSurveyNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get vowSurveyNext;

  /// No description provided for @vowSurveySubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit survey'**
  String get vowSurveySubmit;

  /// No description provided for @vowSurveySubmitted.
  ///
  /// In en, this message translates to:
  /// **'Survey Submitted!'**
  String get vowSurveySubmitted;

  /// No description provided for @vowSurveyThanks.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your anonymous contribution'**
  String get vowSurveyThanks;

  /// No description provided for @vowSurveyAverage.
  ///
  /// In en, this message translates to:
  /// **'Average score'**
  String get vowSurveyAverage;

  /// No description provided for @vowSurveySummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get vowSurveySummary;

  /// No description provided for @vowSurveyBackToTeam.
  ///
  /// In en, this message translates to:
  /// **'Back to Team'**
  String get vowSurveyBackToTeam;

  /// No description provided for @vowRating1.
  ///
  /// In en, this message translates to:
  /// **'Not at all'**
  String get vowRating1;

  /// No description provided for @vowRating2.
  ///
  /// In en, this message translates to:
  /// **'A little'**
  String get vowRating2;

  /// No description provided for @vowRating3.
  ///
  /// In en, this message translates to:
  /// **'Somewhat'**
  String get vowRating3;

  /// No description provided for @vowRating4.
  ///
  /// In en, this message translates to:
  /// **'Very much'**
  String get vowRating4;

  /// No description provided for @vowRating5.
  ///
  /// In en, this message translates to:
  /// **'Absolutely'**
  String get vowRating5;

  /// No description provided for @checkinTitle.
  ///
  /// In en, this message translates to:
  /// **'SHIFT CHECK-IN'**
  String get checkinTitle;

  /// No description provided for @checkinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'PPE Self-declaration'**
  String get checkinSubtitle;

  /// No description provided for @checkinDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get checkinDone;

  /// No description provided for @checkinTodo.
  ///
  /// In en, this message translates to:
  /// **'To do'**
  String get checkinTodo;

  /// No description provided for @checkinCompleted.
  ///
  /// In en, this message translates to:
  /// **'Check-in completed'**
  String get checkinCompleted;

  /// No description provided for @checkinDpiRequired.
  ///
  /// In en, this message translates to:
  /// **'PPE required for your role'**
  String get checkinDpiRequired;

  /// No description provided for @checkinConfirm.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM CHECK-IN'**
  String get checkinConfirm;

  /// No description provided for @checkinSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all PPE items'**
  String get checkinSelectAll;

  /// No description provided for @checkinPointsAction.
  ///
  /// In en, this message translates to:
  /// **'Shift check-in'**
  String get checkinPointsAction;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
