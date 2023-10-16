extends Panel

@export var settingBackgroundPanel: Panel
@export var resolutionOptionButton: OptionButton

@onready var screenResolution: Vector2 = DisplayServer.screen_get_size(DisplayServer.window_get_current_screen())

var windowWidth = ProjectSettings.get_setting("display/window/size/viewport_width")
var windowHeight = ProjectSettings.get_setting("display/window/size/viewport_height")

var commonResolutions: Array[Vector2] = [
	Vector2(800, 600),
	Vector2(1024, 768),
	Vector2(1280, 720),
	Vector2(1366, 768),
	Vector2(1920, 1080),
	Vector2(2560, 1440),
	Vector2(3840, 2160)
]

var currentResolutionIndex: int = -1

func _ready():
	CheckUserResolution()
	SetResolutionsToOptionButton()
	SetUserResolution()

func CheckUserResolution():
	var exist: bool = false
	
	for i in commonResolutions.size():
		if commonResolutions[i] == screenResolution:
			exist = true
			currentResolutionIndex = i
	
	if !exist:
		commonResolutions.push_front(screenResolution)
		currentResolutionIndex = 0

func SetResolutionsToOptionButton():
	for i in commonResolutions.size():
		resolutionOptionButton.add_item(str(commonResolutions[i].x) + "x" + str(commonResolutions[i].y))

func SetUserResolution():
	if !Globals.UserResolutionSetted:
		get_viewport().size = screenResolution
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
		resolutionOptionButton.select(currentResolutionIndex)
		
		Globals.UserResolutionSetted = true

func _on_close_button_pressed():
	settingBackgroundPanel.visible = false

func _on_auto_shoot_check_button_toggled(button_pressed):
	Globals.AutoShoot = button_pressed

func _on_resolution_option_button_item_selected(index):
	currentResolutionIndex = index
	
	get_viewport().size = commonResolutions[index]
	
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_full_screen_check_button_toggled(button_pressed):
	print(commonResolutions[currentResolutionIndex])
	
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	get_viewport().size = commonResolutions[currentResolutionIndex]
