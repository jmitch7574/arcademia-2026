class_name ShopSFXManager
extends AudioStreamPlayer2D

const LEVELUP = preload("uid://biccdupw7h4wx")
const LOUD_INNCORRECT_BUZZER = preload("uid://bcxbyuibu3d3u")
const REROLL = preload("uid://omsol7dhor2t")

func play_level_up():
	stream = LEVELUP
	play()

func play_reroll():
	stream = REROLL
	play()

func play_buzzer():
	stream = LOUD_INNCORRECT_BUZZER
	play()
