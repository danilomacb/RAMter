extends Node

enum UpgradeType {AttackSpeed, Multishot, ReverseShot, Penetrator, Reflector, DeathArrow}
enum ExpType {Blue, Red}

var UpgradeAttackSpeedCounter: int = 0
var UpgradeMultiShotCounter: int = 0
var UpgradeReverseShotCounter: int = 0
var UpgradePenetratorCounter: int = 0
var UpgradeReflectorCounter: int = 0
var UpgradeDeathArrowCounter: int = 0

var ShowingLvUpPanel: bool = false
