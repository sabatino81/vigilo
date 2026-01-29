// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello!';

  @override
  String welcome(Object name) {
    return 'Welcome, $name!';
  }

  @override
  String get loginTitle => 'Login';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get signInButton => 'Sign in';

  @override
  String get appName => 'Vigilo';

  @override
  String get appSubtitle => 'Workplace Safety';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeSubtitle => 'Workplace Safety';

  @override
  String get colorPalette => 'Color Palette';

  @override
  String get teamTitle => 'Team';

  @override
  String get teamSubtitle => 'Your work team';

  @override
  String get sosTitle => 'Safety';

  @override
  String get sosSubtitle => 'Report, get help or activate SOS';

  @override
  String get sosButton => 'SAFETY';

  @override
  String get sosDescription => 'Report a danger, get help or activate SOS';

  @override
  String get puntiTitle => 'Points';

  @override
  String get puntiSubtitle => 'Your safety points';

  @override
  String get imparaTitle => 'Learn';

  @override
  String get imparaSubtitle => 'Educational content';

  @override
  String get navHome => 'Home';

  @override
  String get navTeam => 'Team';

  @override
  String get navSos => 'Safety';

  @override
  String get navPunti => 'Points';

  @override
  String get navImpara => 'Learn';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get logout => 'Logout';

  @override
  String get notifications => 'Notifications';

  @override
  String get profile => 'Profile';

  @override
  String greeting(Object name) {
    return 'Hi, $name';
  }

  @override
  String get colorName => 'Name';

  @override
  String get colorHex => 'Hex';

  @override
  String get colorUsage => 'Usage';

  @override
  String get colorPrimaryDesc => 'Yellow - Attention';

  @override
  String get colorOnPrimaryDesc => 'Text';

  @override
  String get colorPrimaryContainerDesc => 'Container';

  @override
  String get colorSecondaryDesc => 'Green - OK';

  @override
  String get colorOnSecondaryDesc => 'Text';

  @override
  String get colorSecondaryContainerDesc => 'Container';

  @override
  String get colorTertiaryDesc => 'Blue - Info';

  @override
  String get colorOnTertiaryDesc => 'Text';

  @override
  String get colorTertiaryContainerDesc => 'Container';

  @override
  String get colorWarningDesc => 'Orange - Warnings';

  @override
  String get colorOnWarningDesc => 'Text';

  @override
  String get colorWarningContainerDesc => 'Container';

  @override
  String get colorDangerDesc => 'Red - SOS';

  @override
  String get colorOnDangerDesc => 'Text';

  @override
  String get colorDangerContainerDesc => 'Container';

  @override
  String get colorNeutralDesc => 'Grey';

  @override
  String get colorOnNeutralDesc => 'Text';

  @override
  String get colorNeutralContainerDesc => 'Container';

  @override
  String get colorSurfaceDesc => 'Background';

  @override
  String get colorOnSurfaceDesc => 'Text';

  @override
  String get colorSurfaceVariantDesc => 'Variant';

  @override
  String get colorOutlineDesc => 'Borders';

  @override
  String get colorOutlineVariantDesc => 'Soft borders';

  @override
  String get puntiTotal => 'Total points';

  @override
  String get sendSos => 'SEND SOS';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get safetyScore => 'SAFETY SCORE';

  @override
  String get scoreOutOf => '/ 100';

  @override
  String get trendVsYesterday => 'vs yesterday';

  @override
  String get metricStress => 'Stress';

  @override
  String get metricHydration => 'Hydration';

  @override
  String get metricFatigue => 'Fatigue';

  @override
  String get metricRest => 'Rest';

  @override
  String get dpiStatus => 'PPE STATUS';

  @override
  String get dpiHelmet => 'Helmet';

  @override
  String get dpiSafetyShoes => 'Safety\nshoes';

  @override
  String get dpiGloves => 'Gloves';

  @override
  String get dpiStatusOk => 'OK';

  @override
  String get dpiStatusBatteryLow => 'Low\nbattery';

  @override
  String get smartBreak => 'SMART BREAK';

  @override
  String get breakRemaining => 'Break remaining';

  @override
  String get breakMinutes => 'min';

  @override
  String get showShadeZone => 'Show shade zone';

  @override
  String get teamChallenge => 'TEAM CHALLENGE';

  @override
  String get zeroInjuriesWeek => 'Zero Injuries Week';

  @override
  String get progress => 'Progress';

  @override
  String get hotStreak => 'HOT STREAK:';

  @override
  String get days => 'days';

  @override
  String get goToChallenge => 'Go to challenge';

  @override
  String get dailyTodo => 'DAILY TO-DO';

  @override
  String get weeklyQuiz => 'Weekly quiz';

  @override
  String get safetySurvey => 'Safety survey';

  @override
  String get safetyReport => 'Safety report';

  @override
  String get microTraining => '5\' Micro-training';

  @override
  String get actionStart => 'Start';

  @override
  String get actionAnswer => 'Answer';

  @override
  String get actionSos => 'SOS';

  @override
  String get actionWatch => 'Watch';

  @override
  String get personalKpi => 'MY NUMBERS';

  @override
  String get kpiTodoCompleted => 'Tasks completed this week';

  @override
  String get kpiSafetyRecalls => 'Safety recalls';

  @override
  String get kpiPointsToday => 'Points earned today';

  @override
  String get teamLabel => 'Your team';

  @override
  String get pointsAbbr => 'pt';

  @override
  String get activeChallenge => 'ACTIVE CHALLENGE';

  @override
  String get teamProgress => 'Team progress';

  @override
  String get deadline => 'Deadline';

  @override
  String get dailyObjective => 'Daily objective: 0 negative reports';

  @override
  String teamBonus(Object points) {
    return 'Bonus: +$points pt for the team';
  }

  @override
  String get challengeDetails => 'Go to challenge details';

  @override
  String get leaderboard => 'LEADERBOARD';

  @override
  String get live => 'LIVE';

  @override
  String get teamMembers => 'TEAM MEMBERS';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get openTeamChat => 'Open team chat';

  @override
  String get safetyStarTitle => 'SAFETY STAR OF THE WEEK';

  @override
  String get winner => 'Winner';

  @override
  String get motivation => 'Motivation';

  @override
  String nominatedBy(Object names) {
    return 'Nominated by: $names';
  }

  @override
  String get nominateColleague => 'Nominate a colleague';

  @override
  String get vowSurveyTitle => 'SURVEY — Voice of Worker';

  @override
  String surveyStatus(Object answered, Object total) {
    return 'Status: DRAFT ($answered/$total answers)';
  }

  @override
  String question(Object number) {
    return 'Question $number';
  }

  @override
  String get questionSafety => 'Did you feel safe today?';

  @override
  String get questionRisk => 'What was the biggest risk?';

  @override
  String get questionReported => 'Did you report a hazard?';

  @override
  String get questionComment => 'Free comment';

  @override
  String get riskEquipment => 'Equipment';

  @override
  String get riskProcedures => 'Procedures';

  @override
  String get riskEnvironment => 'Environment';

  @override
  String get riskOther => 'Other';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get writeHere => 'Write here...';

  @override
  String get submitSurvey => 'Submit survey';

  @override
  String get socialWallTitle => 'SITE SOCIAL WALL';

  @override
  String topPost(Object post) {
    return 'Top post: \"$post\"';
  }

  @override
  String get createPost => 'Create a post';

  @override
  String get viewAllPosts => 'View all posts';

  @override
  String get wellnessTitle => 'HOW ARE YOU FEELING TODAY?';

  @override
  String get moodGreat => 'Great';

  @override
  String get moodOkay => 'So-so';

  @override
  String get moodStressed => 'Stressed';

  @override
  String get anonymousData => 'Anonymous - aggregated team data';

  @override
  String get transparencyTitle => '\"YOU SAID → WE DID\"';

  @override
  String get statusResolved => 'RESOLVED';

  @override
  String get statusInProgress => 'IN PROGRESS';

  @override
  String get statusEvaluating => 'EVALUATING';

  @override
  String get statusNew => 'NEW';

  @override
  String get viewAllRequests => 'View all requests';

  @override
  String get welcomeGuideTitle => 'YOUR SAFETY AT YOUR FINGERTIPS';

  @override
  String get ppeProtected => 'PPE ACTIVE';

  @override
  String get welcomeBoots => 'Safety boots';

  @override
  String get welcomeVest => 'Safety vest';

  @override
  String get welcomeFeature1 => 'Check your Safety Score';

  @override
  String get welcomeFeature2 => 'Verify PPE are active';

  @override
  String get welcomeFeature3 => 'Report danger with SOS';

  @override
  String get welcomeFeature4 => 'Complete daily tasks';

  @override
  String get openQuickGuide => 'Open quick guide';

  @override
  String get sosPageTitle => 'SAFETY';

  @override
  String get sosPageSubtitle => 'Report a danger, get help or activate SOS';

  @override
  String get sosEmergencySection => 'EMERGENCY';

  @override
  String get sosHoldInstruction =>
      'Hold the \"Safety\" button for 3 seconds to activate a real SOS.';

  @override
  String get sosHoldToActivate => 'Hold for SOS';

  @override
  String get sosReleaseToCancel => 'Release to cancel';

  @override
  String get sosConfirmTitle => 'Confirm SOS request?';

  @override
  String get sosConfirmSubtitle => 'This will immediately notify:';

  @override
  String get sosConfirmSend => 'SEND NOW';

  @override
  String get sosConfirmCancel => 'CANCEL';

  @override
  String get sosSentTitle => 'SOS SENT';

  @override
  String get sosSentSignal => 'Signal sent to contacts';

  @override
  String get sosSentLocation => 'Location shared';

  @override
  String get sosSentMovement => 'Last 60s of movement recorded';

  @override
  String get sosSentMessage =>
      'Stay where you are if possible.\nWe\'re on our way.';

  @override
  String get sosSentConfirm => 'GOT IT';

  @override
  String get quickReportsSection => 'QUICK REPORTS';

  @override
  String get quickReportsSubtitle => 'Report a non-urgent issue';

  @override
  String get reportTypeDanger => 'Imminent Danger';

  @override
  String get reportTypeDangerDesc =>
      'Unstable material, obstacle, fall risk...';

  @override
  String get reportTypeNearMiss => 'Near Miss';

  @override
  String get reportTypeNearMissDesc => 'Near accident, avoided risk';

  @override
  String get reportTypeInjury => 'Minor Injury';

  @override
  String get reportTypeInjuryDesc => 'Slips, bumps, small cuts...';

  @override
  String get reportTypeImprovement => 'Improvement';

  @override
  String get reportTypeImprovementDesc => 'Something to fix or optimize';

  @override
  String get emergencyContactsSection => 'SAFETY CONTACTS';

  @override
  String get contactShiftSupervisor => 'Shift Supervisor';

  @override
  String get contactOperationsCenter => 'Operations Center';

  @override
  String get contactCompanySafety => 'Company Safety';

  @override
  String get contact118 => 'Emergency 118';

  @override
  String get contactFamily => 'Family Contact';

  @override
  String get reportHistorySection => 'MY REPORTS';

  @override
  String get reportHistoryEmpty => 'No reports';

  @override
  String get reportHistoryViewAll => 'View all';

  @override
  String get reportStatusPending => 'Pending';

  @override
  String get reportStatusUnderReview => 'Under Review';

  @override
  String get reportStatusInProgress => 'In Progress';

  @override
  String get reportStatusApproved => 'Approved';

  @override
  String get reportStatusClosed => 'Closed';

  @override
  String reportFormTitle(Object type) {
    return 'Report $type';
  }

  @override
  String get reportFormDescription => 'Describe what you saw';

  @override
  String get reportFormDescriptionHint => 'Describe the issue in detail...';

  @override
  String get reportFormDescriptionError => 'Enter at least 10 characters';

  @override
  String get reportFormPhoto => 'Photo (optional)';

  @override
  String get reportFormPhotoButton => 'Take a photo';

  @override
  String get reportFormLocation => 'Location';

  @override
  String get reportFormLocationAuto => 'Location detected automatically';

  @override
  String get reportFormContact => 'Do you want to be contacted?';

  @override
  String get reportFormContactDesc =>
      'The manager may call you for more details';

  @override
  String get reportFormSubmit => 'SUBMIT REPORT';

  @override
  String get reportFormSuccess => 'REPORT SUBMITTED';

  @override
  String get reportFormSuccessMessage =>
      'Thanks, your report has been received and will be reviewed by RSPP.';

  @override
  String reportFormSuccessId(Object id) {
    return 'ID: $id';
  }

  @override
  String get reportDetailTitle => 'Report Details';

  @override
  String get reportDetailDate => 'Date';

  @override
  String get reportDetailLocation => 'Location';

  @override
  String get reportDetailContactRequested => 'Contact requested';

  @override
  String get reportDetailDescription => 'Description';

  @override
  String get reportDetailPhotos => 'Photos';

  @override
  String get reportDetailRsppNotes => 'RSPP Notes';

  @override
  String get reportDetailClosed => 'Report closed';

  @override
  String get puntiWallet => 'WALLET';

  @override
  String get puntiPoints => 'points';

  @override
  String puntiLevel(Object level) {
    return 'Level $level';
  }

  @override
  String puntiNextLevel(Object level, Object points) {
    return 'Next: $level ($points pt)';
  }

  @override
  String get puntiRecentTransactions => 'Recent transactions';

  @override
  String get puntiViewAll => 'View all';

  @override
  String get puntiCatalog => 'REWARDS CATALOG';

  @override
  String get puntiCatalogViewAll => 'View full catalog';

  @override
  String get puntiAvailable => 'Available';

  @override
  String get puntiLimited => 'Limited';

  @override
  String get puntiOutOfStock => 'Out of Stock';

  @override
  String get puntiCategoryVoucher => 'Vouchers';

  @override
  String get puntiCategoryPpe => 'PPE';

  @override
  String get puntiCategoryGadget => 'Gadget';

  @override
  String get puntiCategoryOther => 'Other';

  @override
  String get puntiSortByPointsAsc => 'Points ↑';

  @override
  String get puntiSortByPointsDesc => 'Points ↓';

  @override
  String get puntiSortByName => 'Name';

  @override
  String get puntiFilterAll => 'All';

  @override
  String get puntiSortBy => 'Sort by:';

  @override
  String get puntiStats => 'STATISTICS';

  @override
  String get puntiLast7Days => 'Last 7 days';

  @override
  String get puntiLast30Days => 'Last 30 days';

  @override
  String puntiMissions(Object count) {
    return '$count missions';
  }

  @override
  String get puntiWeeklyTrend => 'Weekly trend';

  @override
  String get puntiLeaderboard => 'LEADERBOARD';

  @override
  String get puntiLive => 'LIVE';

  @override
  String get puntiYou => 'YOU';

  @override
  String get puntiInstantWin => 'INSTANT WIN';

  @override
  String get puntiSpinWheel => 'Spin the wheel every day!';

  @override
  String get puntiSpinAvailable => '1 SPIN AVAILABLE';

  @override
  String get puntiSpinUsed => 'Already used today';

  @override
  String get puntiSpinAction => 'SPIN NOW';

  @override
  String get puntiSpinComeBack => 'Come back tomorrow';

  @override
  String get puntiSpinWheelTitle => 'Spin the Wheel';

  @override
  String get puntiSpinInfo => 'You have 1 free spin available!';

  @override
  String get puntiSpinUsedInfo => 'You already used your spin today';

  @override
  String get puntiSpinButton => 'SPIN THE WHEEL';

  @override
  String get puntiSpinning => 'THE WHEEL IS SPINNING...';

  @override
  String get puntiSpinTomorrow => 'COME BACK TOMORROW';

  @override
  String get puntiSpinCongrats => 'CONGRATULATIONS!';

  @override
  String get puntiSpinNoWin => 'NO PRIZE TODAY';

  @override
  String get puntiSpinWon => 'YOU WON:';

  @override
  String puntiSpinNewBalance(Object points) {
    return 'New balance: $points pt';
  }

  @override
  String puntiSpinResult(Object prize) {
    return 'The wheel stopped on: $prize';
  }

  @override
  String get puntiSpinTryTomorrow => 'Try again tomorrow with your free spin!';

  @override
  String get puntiSpinGreat => 'AWESOME!';

  @override
  String get puntiSpinOk => 'OK, GOT IT';

  @override
  String get puntiRewardDetail => 'Reward Details';

  @override
  String puntiRewardCost(Object cost) {
    return '$cost points';
  }

  @override
  String get puntiRewardDescription => 'Description';

  @override
  String get puntiRewardDelivery => 'Delivery method';

  @override
  String get puntiRewardRedeem => 'REDEEM NOW';

  @override
  String puntiRewardNotEnough(Object points) {
    return 'You need $points more points';
  }

  @override
  String get puntiRewardUnavailable => 'NOT AVAILABLE';

  @override
  String get puntiLevelBronze => 'Bronze';

  @override
  String get puntiLevelSilver => 'Silver';

  @override
  String get puntiLevelGold => 'Gold';

  @override
  String get puntiLevelPlatinum => 'Platinum';

  @override
  String get puntiLevelDiamond => 'Diamond';

  @override
  String get puntiTransactionEarned => 'Earned';

  @override
  String get puntiTransactionSpent => 'Spent';

  @override
  String get puntiTransactionBonus => 'Bonus';

  @override
  String get puntiTransactionPenalty => 'Penalty';

  @override
  String get imparaTrainingTodo => 'TODAY\'S TRAINING';

  @override
  String get imparaLibrary => 'LIBRARY';

  @override
  String get imparaSearchContents => 'Search contents...';

  @override
  String get imparaSuggestedContents => 'Suggested contents:';

  @override
  String get imparaViewAllLibrary => 'View full library';

  @override
  String get imparaTrainingProgress => 'TRAINING PROGRESS';

  @override
  String get imparaProgressLabel => 'Progress:';

  @override
  String imparaModulesCompleted(Object completed, Object total) {
    return 'Modules completed: $completed / $total';
  }

  @override
  String get imparaModulesInProgress => 'Modules in progress:';

  @override
  String get imparaCertificatesObtained => 'Certificates obtained:';

  @override
  String get imparaCertificateExpiring => 'Expiring soon';

  @override
  String get imparaCertificateValid => 'Valid';

  @override
  String get imparaRecommendedForYou => 'RECOMMENDED FOR YOU';

  @override
  String get imparaContentVideo => 'Video';

  @override
  String get imparaContentPdf => 'PDF';

  @override
  String get imparaContentQuiz => 'Quiz';

  @override
  String get imparaContentLesson => 'Lesson';

  @override
  String get imparaCategorySafety => 'Safety';

  @override
  String get imparaCategoryProcedures => 'Procedures';

  @override
  String get imparaCategoryEquipment => 'Equipment';

  @override
  String get imparaCategoryEmergency => 'Emergency';

  @override
  String get imparaCategoryWellbeing => 'Wellbeing';

  @override
  String get imparaStatusNotStarted => 'Not started';

  @override
  String get imparaStatusInProgress => 'In progress';

  @override
  String get imparaStatusCompleted => 'Completed';

  @override
  String get imparaTodoWatch => 'Watch';

  @override
  String get imparaTodoStart => 'Start';

  @override
  String get imparaTodoRead => 'Read';

  @override
  String get imparaLibraryTitle => 'Library';

  @override
  String imparaContentsCount(Object count) {
    return '$count contents';
  }

  @override
  String get imparaFilterAll => 'All';

  @override
  String get imparaFilterAllCategories => 'All';

  @override
  String get imparaNoContentsFound => 'No contents found';

  @override
  String get imparaContentMandatory => 'Mandatory';

  @override
  String imparaContentStatus(Object status) {
    return 'Status: $status';
  }

  @override
  String imparaContentProgressPercent(Object percent) {
    return '$percent% completed';
  }

  @override
  String get imparaContentDescription => 'Description';

  @override
  String get imparaContentSaved => 'Saved';

  @override
  String get imparaContentSave => 'Save';

  @override
  String get imparaContentContinue => 'Continue';

  @override
  String get imparaContentWatchVideo => 'Watch Video';

  @override
  String get imparaContentOpenPdf => 'Open PDF';

  @override
  String get imparaContentStartAction => 'Start';

  @override
  String imparaContentOpening(Object type) {
    return 'Opening $type...';
  }

  @override
  String imparaQuizQuestion(Object current, Object total) {
    return 'Question $current of $total';
  }

  @override
  String get imparaQuizBack => 'Back';

  @override
  String get imparaQuizNext => 'Next';

  @override
  String get imparaQuizFinish => 'Finish Quiz';

  @override
  String get imparaQuizExitTitle => 'Exit quiz?';

  @override
  String get imparaQuizExitMessage => 'Your progress won\'t be saved.';

  @override
  String get imparaQuizCancel => 'Cancel';

  @override
  String get imparaQuizExit => 'Exit';

  @override
  String get imparaQuizResultTitle => 'Quiz Completed!';

  @override
  String imparaQuizResultScore(Object correct, Object total) {
    return '$correct/$total';
  }

  @override
  String get imparaQuizResultCorrect => 'Correct answers';

  @override
  String get imparaQuizResultPassed => 'PASSED';

  @override
  String get imparaQuizResultFailed => 'FAILED';

  @override
  String get imparaQuizResultPassedMessage =>
      'Congratulations! You passed the quiz.';

  @override
  String get imparaQuizResultFailedMessage =>
      'You didn\'t reach the minimum score. Try again!';

  @override
  String get imparaQuizResultEarned => 'Points earned';

  @override
  String get imparaQuizResultNoPoints => 'No points';

  @override
  String get imparaQuizResultMinScore => 'Minimum score: 60%';

  @override
  String get imparaQuizResultSummary => 'Answer summary';

  @override
  String get imparaQuizResultRetry => 'Retry Quiz';

  @override
  String get imparaQuizResultBackToLearn => 'Back to Learn';

  @override
  String imparaDurationMinutes(Object minutes) {
    return '$minutes min';
  }

  @override
  String imparaDurationHours(Object hours, Object minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get walletTitle => 'HELMET POINTS';

  @override
  String get walletElmetto => 'Helmet Points';

  @override
  String walletConversionInfo(Object rate, Object percent) {
    return '$rate pt = 1 EUR  |  Max $percent% discount';
  }

  @override
  String get walletWelfareActive => 'Welfare active (up to 100% discount)';

  @override
  String walletWelfareCompany(Object company) {
    return 'Welfare activated by $company';
  }

  @override
  String walletLevel(Object level) {
    return 'Level $level';
  }

  @override
  String walletNextLevel(Object level, Object points) {
    return 'Next: $level ($points pt)';
  }

  @override
  String get walletRecentMoves => 'Recent transactions';

  @override
  String get walletViewAll => 'View all';

  @override
  String walletElmettoValue(Object value) {
    return '= $value EUR';
  }

  @override
  String get shopTitle => 'Company Store';

  @override
  String get shopVigiloTitle => 'Company Store';

  @override
  String get shopVigiloSubtitle =>
      'Your exclusive store: discounts and free products with your points';

  @override
  String get shopSearchHint => 'Search products...';

  @override
  String get shopCategoryAll => 'All';

  @override
  String shopProductCount(Object count) {
    return '$count products';
  }

  @override
  String get shopMarkupInfo => '30% markup included';

  @override
  String get shopNoProducts => 'No products found';

  @override
  String get shopCategoryCasa => 'Home';

  @override
  String get shopCategoryAbbigliamento => 'Clothing';

  @override
  String get shopCategoryTech => 'Tech';

  @override
  String get shopCategoryConsumabili => 'Consumables';

  @override
  String get shopCategorySport => 'Sport';

  @override
  String get shopCategoryVoucher => 'Vouchers';

  @override
  String get shopBadgeGratis => 'FREE';

  @override
  String get shopBadgeScontato => 'DISCOUNTED';

  @override
  String get shopBadgePromo => 'PROMO';

  @override
  String shopSupplier(Object name) {
    return 'Supplier: $name';
  }

  @override
  String get shopQuantity => 'Quantity';

  @override
  String get shopAddToCart => 'Add to cart';

  @override
  String get shopAddFree => 'Add for free';

  @override
  String shopAddedToCart(Object name, Object qty) {
    return 'Added to cart: $name x$qty';
  }

  @override
  String get shopGoToCart => 'Go to cart';

  @override
  String cartTitle(Object count) {
    return 'Cart ($count)';
  }

  @override
  String get cartEmpty => 'Cart is empty';

  @override
  String cartShipping(Object amount) {
    return 'Shipping: $amount EUR (always paid by worker)';
  }

  @override
  String get cartCheckout => 'Proceed to checkout';

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String checkoutItems(Object count) {
    return 'Items ($count)';
  }

  @override
  String get checkoutAddress => 'Delivery address';

  @override
  String get checkoutPaymentSummary => 'Payment summary';

  @override
  String get checkoutSubtotal => 'Subtotal';

  @override
  String get checkoutWelfare => 'Welfare';

  @override
  String checkoutElmettoDiscount(Object points) {
    return 'Helmet discount ($points pt)';
  }

  @override
  String get checkoutToPay => 'To pay';

  @override
  String get checkoutFree => 'FREE';

  @override
  String get checkoutTotal => 'TOTAL';

  @override
  String get checkoutBnplLabel => 'Pay in 3 installments with Scalapay';

  @override
  String checkoutBnplRate(Object amount) {
    return '$amount EUR/month - interest paid by you';
  }

  @override
  String get checkoutConfirm => 'Confirm and pay';

  @override
  String get checkoutConfirmFree => 'Confirm free order';

  @override
  String get checkoutSuccess => 'Order confirmed!';

  @override
  String get checkoutSuccessFree =>
      'Your order is confirmed. Fully covered by welfare!';

  @override
  String checkoutSuccessBnpl(Object amount) {
    return 'You will pay in 3 installments of $amount EUR/month with Scalapay.';
  }

  @override
  String checkoutSuccessCharged(Object amount) {
    return 'Total charged: $amount EUR';
  }

  @override
  String get checkoutBackToShop => 'Back to Store';

  @override
  String get shopShipping => 'Shipping';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileSafetyStats => 'Safety Statistics';

  @override
  String get profileSafetyScore => 'Safety Score';

  @override
  String get profileStreak => 'Streak';

  @override
  String get profileReports => 'Reports';

  @override
  String get profileTrustLevel => 'Trust Level';

  @override
  String get profileTrustBase => 'Base';

  @override
  String get profileTrustVerified => 'Verified';

  @override
  String get profileTrustTrusted => 'Trusted';

  @override
  String get profileTrustExpert => 'Expert';

  @override
  String get profileWorkerOperaio => 'Worker';

  @override
  String get profileWorkerCaposquadra => 'Team Lead';

  @override
  String get profileWorkerPreposto => 'Supervisor';

  @override
  String get profileWorkerRspp => 'Safety Officer';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profileTheme => 'Theme';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileBiometric => 'Biometrics';

  @override
  String get profileLogout => 'Log out';

  @override
  String get profileActive => 'Active';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsAll => 'All';

  @override
  String get notificationsCategorySafety => 'Safety';

  @override
  String get notificationsCategoryPoints => 'Points';

  @override
  String get notificationsCategoryTeam => 'Team';

  @override
  String get notificationsCategorySystem => 'System';

  @override
  String get notificationsEmpty => 'No notifications';

  @override
  String get notificationsToday => 'Today';

  @override
  String get notificationsYesterday => 'Yesterday';

  @override
  String get notificationsThisWeek => 'This week';

  @override
  String get notificationsEarlier => 'Earlier';

  @override
  String notificationsMinAgo(Object min) {
    return '$min min ago';
  }

  @override
  String notificationsHoursAgo(Object hours) {
    return '${hours}h ago';
  }

  @override
  String notificationsDaysAgo(Object days) {
    return '${days}d ago';
  }

  @override
  String get streakTitle => 'Streak';

  @override
  String streakDays(Object count) {
    return '$count days';
  }

  @override
  String streakMultiplier(Object value) {
    return 'Multiplier x$value';
  }

  @override
  String streakDaysToNext(Object days, Object level) {
    return '$days days to $level';
  }

  @override
  String get streakCalendar => 'Month calendar';

  @override
  String get streakLevels => 'Streak Levels';

  @override
  String get streakBestRecord => 'Personal record';

  @override
  String get streakLevelFiammella => 'Spark';

  @override
  String get streakLevelFuocherello => 'Flame';

  @override
  String get streakLevelFalo => 'Bonfire';

  @override
  String get streakLevelIncendio => 'Blaze';

  @override
  String get streakLevelInferno => 'Inferno';

  @override
  String streakDaysMin(Object days, Object multiplier) {
    return '$days+ days  |  x$multiplier';
  }

  @override
  String get challengeTitle => 'Team Challenge';

  @override
  String get challengeTeamContributions => 'Team Contributions';

  @override
  String get challengeHistory => 'Challenge History';

  @override
  String challengeTimeRemaining(Object value) {
    return '$value remaining';
  }

  @override
  String get challengeExpired => 'Expired';

  @override
  String challengeBonus(Object points) {
    return 'Bonus: +$points pt';
  }

  @override
  String challengePoints(Object current, Object target) {
    return '$current / $target points';
  }

  @override
  String pointsEarnedSnackbar(Object points) {
    return '+$points Helmet Points';
  }

  @override
  String pointsEarnedAction(Object points, Object action) {
    return '+$points Helmet Points - $action';
  }

  @override
  String get pointsActionCheckin => 'Wellness check-in';

  @override
  String get pointsActionReport => 'Safety report';

  @override
  String get pointsActionQuiz => 'Quiz completed';

  @override
  String get pointsActionAccess => 'Site access';

  @override
  String get pointsActionSurvey => 'Safety survey';

  @override
  String get wellnessNoteHint => 'Notes (optional)...';

  @override
  String get wellnessSubmit => 'Send check-in';

  @override
  String get wellnessSubmitted => 'Check-in sent! +10 points';

  @override
  String get wellnessMoodGreat => 'Great';

  @override
  String get wellnessMoodGood => 'Good';

  @override
  String get wellnessMoodOkay => 'So-so';

  @override
  String get wellnessMoodStressed => 'Stressed';

  @override
  String get wellnessMoodBad => 'Bad';

  @override
  String get vowSurveyPageTitle => 'Voice of Worker';

  @override
  String vowSurveyQuestion(Object current, Object total) {
    return 'Question $current of $total';
  }

  @override
  String get vowSurveyAnonymous => 'Anonymous';

  @override
  String get vowSurveyBack => 'Back';

  @override
  String get vowSurveyNext => 'Next';

  @override
  String get vowSurveySubmit => 'Submit survey';

  @override
  String get vowSurveySubmitted => 'Survey Submitted!';

  @override
  String get vowSurveyThanks => 'Thanks for your anonymous contribution';

  @override
  String get vowSurveyAverage => 'Average score';

  @override
  String get vowSurveySummary => 'Summary';

  @override
  String get vowSurveyBackToTeam => 'Back to Team';

  @override
  String get vowRating1 => 'Not at all';

  @override
  String get vowRating2 => 'A little';

  @override
  String get vowRating3 => 'Somewhat';

  @override
  String get vowRating4 => 'Very much';

  @override
  String get vowRating5 => 'Absolutely';
}
